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

void logger(log_level level, const char* message, ...);

#endif /* LOGGER_H_ */
