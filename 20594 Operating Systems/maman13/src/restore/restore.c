/*
 * restore.c
 *
 *  Created on: Jun 12, 2016
 *      Author: stas
 */

#include "restore.h"

BackupItem readItem(FILE *sourceFile)
{
	BackupItem item;
	Int readResult = fread(&item, sizeof(BackupItem), 1, sourceFile);
	if(!readResult) {
		perror("Could read file");
		exit(1);
	}

	printItem(item);
	return item;
}

void restoreFile(String path, BackupItem item, FILE *sourceFile)
{
	debugPrint("Restoring file %s", path);
	FILE *targetFile = fopen(path, "w+");
	if(targetFile == NULL) {
		perror("Cannot open file for writing");
	}

	fcpy(sourceFile, targetFile, item.size);
	safeClose(targetFile);
}

void restoreFolder(String path, BackupItem item, FILE *sourceFile)
{
	debugPrint("Restoring folder %s (%d children)", path, item.children);
	safeMkdir(path);
	Int i;
	for(i = 0; i < item.children; i++) {
		BackupItem child = readItem(sourceFile);
		String childPath = pathComponents(path,child.name);
		switch(child.type) {
		case ItemTypeFile:
		case ItemTypeSLink:
			restoreFile(childPath, child, sourceFile);
			break;
		case ItemTypeFolder:
			restoreFolder(childPath, child, sourceFile);
			break;
		default:
			printf("Error: Unknown archive type");
			exit(1);
		}
	}
}

void restore(String sourcePath)
{
	debugPrint("restoring file '%s'", sourcePath);
	FILE *sourceFile = fopen(sourcePath,"r");
	if(sourceFile == NULL) {
		perror("Could not open archive file");
		exit(1);
	}

	BackupItem rootItem = readItem(sourceFile);
	switch(rootItem.type) {
	case ItemTypeFile:
	case ItemTypeSLink:
		restoreFile(rootItem.name, rootItem, sourceFile);
		break;
	case ItemTypeFolder:
		restoreFolder(rootItem.name, rootItem, sourceFile);
		break;
	default:
		printf("Error: Unknown archive type");
		exit(1);
	}

	safeClose(sourceFile);
}
