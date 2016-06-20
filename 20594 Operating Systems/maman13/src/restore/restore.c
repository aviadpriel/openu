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
		exit(EXIT_FAILURE);
	}

	fcpy(sourceFile, targetFile, item.size);
	safeClose(targetFile);

	//seek 1 byte backwards, this fixes a bug.
	if(fseek(sourceFile, -1 ,SEEK_CUR) == ERROR) {
		perror("fseek error");
		exit(EXIT_FAILURE);
	}

	safeChown(path, item.uid, item.gid);
	safeChmod(path, item.mode);
	setModTime(path, item.modTime);
}

void restoreLink(String path, BackupItem item)
{
	debugPrint("Restoring symlink %s", path);
	safeSymlink(item.linkPath, path);
	safeChown(path, item.uid, item.gid);
	safeChmod(path, item.mode);
}

void restoreFolder(String path, BackupItem item, FILE *sourceFile)
{
	debugPrint("Restoring folder %s (%d children)", path, item.children);
	safeMkdir(path);
	Int i;
	for(i = 0; i < item.children; i++) {
		debugPrint("cursor at %d",ftell(sourceFile));
		BackupItem child = readItem(sourceFile);
		String childPath = pathComponents(path,child.name);
		switch(child.type) {
		case ItemTypeFile:
			restoreFile(childPath, child, sourceFile);
			break;
		case ItemTypeSLink:
			restoreLink(childPath, child);
			break;
		case ItemTypeFolder:
			restoreFolder(childPath, child, sourceFile);
			break;
		default:
			printf("Error: Unknown file type %d\n",child.type);
			exit(1);
		}
		debugPrint("endfor, cursor at %d",ftell(sourceFile));
	}

	safeChown(path, item.uid, item.gid);
	safeChmod(path, item.mode);
	setModTime(path, item.modTime);
}

void restore(String sourcePath)
{
	debugPrint("restoring archive '%s'", sourcePath);
	FILE *sourceFile = fopen(sourcePath,"r");
	if(sourceFile == NULL) {
		perror("Could not open archive file");
		exit(1);
	}

	debugPrint("cursor at %d",ftell(sourceFile));
	BackupItem rootItem = readItem(sourceFile);

	if(pathExists(rootItem.name)) {
		printf("Error: '%s' already exists\n", rootItem.name);
		exit(EXIT_FAILURE);
	}

	switch(rootItem.type) {
	case ItemTypeSLink:
		restoreLink(rootItem.name, rootItem);
		break;
	case ItemTypeFile:
		restoreFile(rootItem.name, rootItem, sourceFile);
		break;
	case ItemTypeFolder:
		restoreFolder(rootItem.name, rootItem, sourceFile);
		break;
	default:
		printf("Error: Unknown archive type\n");
		exit(1);
	}

	safeClose(sourceFile);
}
