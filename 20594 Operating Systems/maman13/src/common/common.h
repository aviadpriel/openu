/*
 * common.h
 *
 *  Created on: Jun 12, 2016
 *      Author: stas
 */

#ifndef COMMON_H_
#define COMMON_H_

#include <stdint.h>
#include <sys/stat.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <libgen.h>

//types
typedef int32_t Int;
typedef int64_t Long;
typedef char* String;
typedef enum { false = 0, true = 1 } Bool;
typedef enum {
	ItemTypeFile = 0,
	ItemTypeFolder = 1,
	ItemTypeSLink = 2,
	ItemTypeUnknown = 3
}
ItemType;

//constants
#define FILENAME_LENGTH 512
#define DEBUG true

//structs
typedef struct {
	char name[FILENAME_LENGTH];
	ItemType type;
	uid_t uid;
	gid_t gid;
	off_t size;
	struct timespec modTime;
} BackupItem;

//functions
void debugPrint(String message, ...);

#endif /* COMMON_H_ */
