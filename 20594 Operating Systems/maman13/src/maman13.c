/*
 ============================================================================
 Name        : maman13.c
 Author      : Stas Seldin
 Version     :
 Copyright   : ID: 311950943
 Description : Hello World in C, Ansi-style
 ============================================================================
 */

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "common/common.h"
#include "backup/backup.h"
#include "restore/restore.h"

void showUsageMessageAndExit()
{
	puts("Usage: mkbkp <-c|-x> <backup_file> [file_to_backup|directory_to_backup]\n");
	exit(1);
}


int main(Int argc, String* argv) {

	if(argc < 2) {
		showUsageMessageAndExit();
	}

	if(strcmp(argv[1],"-c") == 0 && argc >= 4) {
		String backupFileName = argv[2];
		String pathToBackup = argv[3];
		backup(backupFileName, pathToBackup);
	}
	else if(strcmp(argv[1],"-x") == 0 && argc >= 3) {
		String fileToRestore = argv[2];
		restore(fileToRestore);
	}
	else {
		showUsageMessageAndExit();
	}

	FILE *fp = fopen("birthday.txt","w+b");

	Int stas[] = {1,2,3,4,5,6,7,8,9};
	fwrite(&stas,sizeof(stas),1,fp);
	fclose(fp);
	return EXIT_SUCCESS;
}
