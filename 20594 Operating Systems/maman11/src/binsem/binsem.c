/*
 *  binsem.c
 *  Implementation of a binary semaphore in C language.
 *  Stas Seldin
 *  ID: 311950943
 */

#include "binsem.h"
#include <signal.h>
#include <stdio.h>

void binsem_init(sem_t *s, int init_val)
{
	*s = (init_val == 0 ? 0 : 1);
}

void binsem_up(sem_t *s)
{
	*s = 1;
}

int binsem_down(sem_t *s)
{
	while(xchg(s, 0) == 0) {
		//yield thread
		if(raise(SIGALRM) < 0 ) {
			perror("syscall raise failed: ");
			return -1;
		}
	}
	return 0;
}
