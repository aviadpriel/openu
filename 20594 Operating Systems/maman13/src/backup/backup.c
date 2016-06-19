/*
 * backup.c
 *
 *  Created on: Jun 12, 2016
 *      Author: stas
 */

#include "backup.h"

Int getNumberOfChildren(String folderPath)
{
	debugPrint("Count items for folder '%s'",folderPath);
	Int count = 0;
    DIR *dir = safeOpenDir(folderPath);

    struct dirent *dp;
    while ((dp = readdir(dir)) != NULL) {
        if ( equalStrings(dp->d_name, ".") || equalStrings(dp->d_name, "..")) {
        	continue;
        }
    	count++;
    }
    safeCloseDir(dir);
    debugPrint("Found %d items", count);
    return count;
}

BackupItem getItemInfo(String path)
{
	struct stat s;
	lstat(path, &s);

	BackupItem item;
	item.uid = s.st_uid;
	item.gid = s.st_gid;
	item.size = s.st_size;
	item.modTime = s.st_mtim;
	item.separator = '@';

	Int i;
	for(i=0; i<FILENAME_LENGTH; i++) {
		item.name[i] = 0;
	}
	for(i=0; i<PATH_LENGTH; i++) {
		item.linkPath[i]=0;
	}
	strcpy(item.name, basename(path));

	if(S_ISREG(s.st_mode)) {
		item.type = ItemTypeFile;
		item.children = 0;
	}
	else if(S_ISDIR(s.st_mode)) {
		item.type = ItemTypeFolder;
		item.children = getNumberOfChildren(path);
	}
	else if(S_ISLNK(s.st_mode)) {
		item.type = ItemTypeSLink;
		item.children = 0;
		item.size = 0;
		safeReadLink(path, item.linkPath, PATH_LENGTH - 1);
	}

	return item;
}

void writeFile(String sourcePath, FILE *targetFile)
{
	//get meta data
	BackupItem info = getItemInfo(sourcePath);
	debugPrint("Writing file '%s'",sourcePath);
	printItem(info);

	//write meta data
	fwrite(&info,sizeof(BackupItem),1,targetFile);

	//write data
	FILE *sourceFile = fopen(sourcePath, "r");
	fcpy(sourceFile, targetFile, info.size);
	safeClose(sourceFile);
}

void writeLink(String sourcePath, FILE *targetFile)
{
	//get meta data
	BackupItem info = getItemInfo(sourcePath);
	debugPrint("Writing symlink '%s'",sourcePath);
	printItem(info);

	//write meta data
	fwrite(&info,sizeof(BackupItem),1,targetFile);
}

void writeFolder(String sourcePath, FILE *targetFile)
{
	//get info
	BackupItem folderInfo = getItemInfo(sourcePath);
	debugPrint("Writing folder '%s'",sourcePath);
	printItem(folderInfo);

	//write meta data
	fwrite(&folderInfo,sizeof(BackupItem),1,targetFile);

	//write data
    DIR *dir = dir = safeOpenDir(sourcePath);
    struct dirent *dp;
    while ((dp=readdir(dir)) != NULL) {
        if ( equalStrings(dp->d_name, ".") || equalStrings(dp->d_name, "..")) {
        	continue;
        }

        String childPath = pathComponents(sourcePath, dp->d_name);
        switch(dp->d_type) {
        case DT_REG:
        	writeFile(childPath, targetFile);
        	break;
        case DT_LNK:
        	writeLink(childPath, targetFile);
        	break;
        case DT_DIR:
        	writeFolder(childPath, targetFile);
        	break;
        default:
        	printf("Warning: '%s' has unknown type and was not backed up", childPath);
        }

        free(childPath);
    }

    safeCloseDir(dir);
}

void backup(String targetPath, String sourcePath)
{
	debugPrint("backing up '%s' to file '%s'",sourcePath, targetPath);

	FILE *targetFile = fopen(targetPath, "w+");
	if(targetFile == NULL) {
		perror("Could not create file");
		exit(EXIT_FAILURE);
	}

	if(pathExists(sourcePath) == false) {
		printf("Could not find path '%s'\n",sourcePath);
		exit(EXIT_FAILURE);
	}

	BackupItem rootItem = getItemInfo(sourcePath);
	switch(rootItem.type) {
	case ItemTypeFile:
	case ItemTypeSLink:
		writeFile(sourcePath, targetFile);
		break;
	case ItemTypeFolder:
		writeFolder(sourcePath, targetFile);
		break;
	case ItemTypeUnknown:
		printf("Cannot backup '%s': Unknown type",sourcePath);
		safeClose(targetFile);
		exit(EXIT_FAILURE);
	}

	safeClose(targetFile);
}
