/*
 * logger.h
 *
 *  Created on: Apr 10, 2016
 *      Author: stas
 */

#ifndef LOGGER_H_
#define LOGGER_H_

typedef enum {
	ERROR,
	WARN,
	INFO,
	DEBUG,
	NONE
}log_level;

static log_level current_log_level = DEBUG;

void log(log_level level, const char* message, ...);

#endif /* LOGGER_H_ */
