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
		if(fputc(c, dest) == ERROR) {
			perror("Fatal: error writing to file");
			exit(1);
		}
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

Bool pathExists(String path) {
	if(access( path, F_OK ) != -1) {
		return true;
	}
	return false;
}

Bool equalStrings(String str1, String str2) {
	return strcmp(str1, str2) == 0;
}

void safeClose(FILE *file) {
	if(fclose(file) == ERROR) {
    	perror("Error closing file");
    	exit(1);
	}
}

void safeMkdir(String path) {
	if(mkdir(path, S_IRWXU | S_IRWXG | S_IROTH | S_IXOTH) == ERROR) {
		perror("unable to create dir");
		exit(1);
	}
}

DIR* safeOpenDir(String path) {
	DIR *dir = opendir(path);
    if (dir == NULL) {
    	perror("unable to opendir");
    	exit(1);
    }
    return dir;
}

void safeCloseDir(DIR *dir) {
    if(closedir(dir) == ERROR) {
    	perror("Error closing dir");
    	exit(1);
    }
}

void safeReadLink(String path, String buffer, Int bufferSize) {
	Int readLinkBytes = readlink(path, buffer, bufferSize - 1);
	if(readLinkBytes == ERROR) {
		perror("Read link error");
		exit(EXIT_FAILURE);
	}
	buffer[readLinkBytes] = '\0';
}

void safeSymlink(String oldname, String newname)
{
	if(symlink(oldname, newname) == ERROR) {
		perror("Error creating symlink");
		exit(EXIT_FAILURE);
	}
}

