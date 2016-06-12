/*
 * common.c
 *
 *  Created on: Jun 12, 2016
 *      Author: stas
 */

#include "common.h"
#include <stdio.h>
#include <stdarg.h>

void debugPrint(string message, ...)
{
	if(!DEBUG) {
		return;
	}

	va_list arglist;
	va_start( arglist, message );
	printf("[DEBUG] ");
	vprintf( message, arglist );
	printf("\n");
	va_end( arglist );
}
