/*
 * ut.c
 *
 *  Created on: Apr 9, 2016
 *      Author: stas
 */

#include "ut.h"
#include <stdio.h>
#include "../logger/logger.h"
#include <signal.h>
#include <ucontext.h>
#include <stdlib.h>
#include <sys/time.h>
#include <unistd.h>


#define SUCCESS 0
#define QUANTUM_TIME 1 //in seconds
#define VTIME_MS 100

static ut_slot *thread_table;
static volatile int spawned_threads = 0;
static volatile int max_threads;
static volatile tid_t current_thread;
static struct sigaction sa,sva;
static struct itimerval itv;

void handler(int signal)
{
	tid_t current_tid = current_thread;
	tid_t new_tid = (current_thread + 1) % spawned_threads;
	ut_slot running_thread = thread_table[current_tid];
	ut_slot new_thread = thread_table[new_tid];
	logger(DEBUG, "in signal handler: switching from thread %d to thread %d",current_tid , new_tid);
	logger(DEBUG, "new thread arg is %d",new_thread->arg);
	logger(DEBUG, "stack address is %x", new_thread->uc.uc_stack.ss_sp);
	logger(INFO, "Thread is running for %d ms", running_thread->vtime);

	current_thread = new_tid;
	alarm(QUANTUM_TIME);
	if(swapcontext(&running_thread->uc, &new_thread->uc) == -1) {
		logger(ERROR, "error swapping context. Exiting");
		perror("error swapping context: ");
		exit(1);
	}

	logger(DEBUG, "Exit alarm handler for thread %d", current_tid);
}

void vtime_count(int signal)
{
	logger(INFO, "vt");
	thread_table[current_thread]->vtime += VTIME_MS;
}

int ut_init(int tab_size)
{
	logger(DEBUG, "ut_init");
	if(tab_size < MIN_TAB_SIZE || tab_size > MAX_TAB_SIZE)
	{
		logger(WARN, "ut_init: incorrect tab_size provided. assuming: %d",MAX_TAB_SIZE);
		tab_size = MAX_TAB_SIZE;
	}

	max_threads = tab_size;
	logger(DEBUG, "ut_init: allocating thread_table...");
	thread_table = (ut_slot *)malloc(tab_size * sizeof(ut_slot_t));

	if(thread_table == NULL) {
		logger(ERROR, "ut_init: cannot allocate memory for thread_table (malloc failed)");
		return SYS_ERR;
	}

	logger(INFO, "thread table initialized with space for %d threads", tab_size);
	return SUCCESS;
}


tid_t ut_spawn_thread(void (*func)(int), int arg)
{
	logger(DEBUG, "ut_spawn_thread");

	if (spawned_threads >= max_threads) {
		logger(WARN, "Cannot spawn new threads: tab is full");
		return TAB_FULL;
	}

	//init thread
	logger(DEBUG, "creating new thread");
	ut_slot new_thread = malloc(sizeof(ut_slot_t));

	new_thread->func = func;
	new_thread->arg = arg;

	//init context
	logger(DEBUG,"getcontext");
	if(getcontext(&(new_thread->uc)) == -1) {
		//failed to allocate the stack
		logger(ERROR, "getcontext call failed");
		return SYS_ERR;
	}

	//init thread's stack
	logger(DEBUG,"Initializing stack");
	void *stack = malloc(STACKSIZE);
	new_thread->uc.uc_stack.ss_size = STACKSIZE;
	new_thread->uc.uc_link = NULL; //do not need to go back
	new_thread->uc.uc_stack.ss_sp = stack;
	logger(DEBUG, "Stack address = %x",new_thread->uc.uc_stack.ss_sp);

	//make context
	logger(DEBUG, "makecontext");
	makecontext(&(new_thread->uc), (void(*)(void))func, 1, arg);

	logger(DEBUG, "Adding thread to the thread table");
	tid_t new_thread_id = spawned_threads;
	thread_table[new_thread_id] = new_thread;
	spawned_threads++;

	logger(INFO, "thread added successfully. new thread id = %d", new_thread_id);
	return new_thread_id;
}

int ut_start(void)
{
	logger(DEBUG, "ut_start");
	current_thread = 0;

	logger(DEBUG, "ut_start: installing the alarm for context switch");

	/* set up sigalarm */
	sa.sa_flags = SA_RESTART;
	sigfillset(&sa.sa_mask);
	sa.sa_handler = handler;

	/* set up sig virtual alarm */
	sva.sa_flags = SA_RESTART;
	sigfillset(&sva.sa_mask);
	sva.sa_handler = vtime_count;

	/* set up vtimer for accounting */
	itv.it_interval.tv_sec = 0;
	itv.it_interval.tv_usec = VTIME_MS * 1000;
	itv.it_value = itv.it_interval;

	if (sigaction(SIGVTALRM, &sva, NULL) < 0)
	{
		perror("ut_start: Error installing signal handler: ");
		return SYS_ERR;
	}

	if (setitimer(ITIMER_VIRTUAL, &itv, NULL) < 0)
	{
		perror("ut_start: Error installing  virtual time: ");
		return SYS_ERR;
	}

	if (sigaction(SIGALRM, &sa, NULL) < 0 )
	{
		perror("ut_start: Error installing signal handler: ");
		return SYS_ERR;
	}

	logger(DEBUG, "swapping context");
	alarm(QUANTUM_TIME);
	ucontext_t uctx_main;
	if(swapcontext(&uctx_main, &(thread_table[current_thread]->uc)) == -1) {
		logger(ERROR, "error swapping context. Exiting");
		perror("error swapping context: ");
		return SYS_ERR;
	}
	logger(ERROR, "Error swapping context. we should never get here!");
	return SUCCESS;
}

unsigned long ut_get_vtime(tid_t tid)
{
	logger(DEBUG, "ut_get_vtime");
	if(tid < 0 || tid > spawned_threads) {
		return 0;
	}

	return thread_table[tid]->vtime;
}


