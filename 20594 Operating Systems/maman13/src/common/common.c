/*
 * common.c
 *
 *  Created on: Jun 12, 2016
 *      Author: stas
 */

#include "common.h"
#include <stdio.h>
#include <stdarg.h>

void debugPrint(String message, ...)
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

void printItem(BackupItem info)
{
	String strType;
	switch(info.type) {
		case ItemTypeFile:
			strType = "File";
		break;
		case ItemTypeFolder:
			strType = "Folder";
		break;
		case ItemTypeSLink:
			strType = "SLink";
		break;
		case ItemTypeUnknown:
			strType = "Unknown";
		break;
	}

	debugPrint("%s: (type=%s, uid=%ld, gid=%ld, size=%ld, modetime = %ld)",
			info.name, strType, info.uid, info.gid, info.size, info.modTime.tv_sec);
}

void fcpy(FILE *src, FILE *dest, Long bytes)
{
	Int c, i = 0;
	while((c = fgetc(src)) != EOF && i++ < bytes) {
		fputc(c, dest);
	}
}

String pathComponents(String path1, String path2)
{
	String result = malloc(strlen(path1)+strlen(path2)+2);
	strcpy(result, path1);
	strcat(result, "/");
	strcat(result, path2);
	return result;
}

Bool equalStrings(String str1, String str2) {
	return strcmp(str1, str2) == 0;
}
