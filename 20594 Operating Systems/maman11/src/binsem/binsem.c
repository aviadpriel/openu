/*
 * binsem.c
 *
 *  Created on: Apr 11, 2016
 *      Author: stas
 */

#include "binsem.h"
#include <signal.h>

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
		sleep(2);
		if(raise(SIGALRM) < 0 ) {
			perror("syscall raise failed: ");
			return -1;
		}
	}
	return 0;
}
