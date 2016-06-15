/*
 * common.h
 *
 *  Created on: Jun 12, 2016
 *      Author: stas
 */

#ifndef COMMON_H_
#define COMMON_H_

#include <stdint.h>

//types
typedef int32_t Int;
typedef int64_t Long;
typedef const char* String;
typedef enum { false = 0, true = 1 } Bool;

//constants
#define FILENAME_LENGTH 4096
#define DEBUG true

void debugPrint(String message, ...);

#endif /* COMMON_H_ */
