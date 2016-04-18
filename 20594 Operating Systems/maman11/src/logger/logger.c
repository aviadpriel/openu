/*
 * logger.c
 *
 *  Created on: Apr 10, 2016
 *      Author: stas
 */

#include "logger.h"
#include <stdarg.h>

void log(log_level level, const char* message, ...)
{
	if (level > current_log_level || current_log_level == NONE) {
		return;
	}

	va_list arglist;
	va_start( arglist, message );

	switch(level)
	{
	case ERROR:
		printf("[ERROR] ");
		break;
	case WARN:
		printf("[WARNING] ");
		break;
	case INFO:
		printf("[INFO] ");
		break;
	case DEBUG:
		printf("[DEBUG] ");
		break;
	}

	vprintf( message, arglist );
	printf("\n");
	va_end( arglist );
}
