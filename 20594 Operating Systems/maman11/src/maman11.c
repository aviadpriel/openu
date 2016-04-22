/*
 ============================================================================
 Name        : maman11.c
 Author      : Stas Seldin
 Version     :
 Copyright   : 
 Description : Hello World in C, Ansi-style
 ============================================================================
 */

#include <stdio.h>
#include <stdlib.h>
#include <signal.h>
#include "ut/ut.h"
#include "binsem/binsem.h"
#include <unistd.h>

sem_t mySem;

void printme(int num)
{
	int i = 0;
	while(1) {
		printf("This is thread #%d. i=%d\n",num,i++);
		sleep(1);
	}
}


int main(void) {
	binsem_init(&mySem, 1);
	puts("Hello world"); /* prints Hello world */

	int n = 5;
	ut_init(n);
	int i;
	for(i=0; i< n; i++) {
		ut_spawn_thread(printme, i);
	}

	ut_start();

	while(1);

	return EXIT_SUCCESS;
}
