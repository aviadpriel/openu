/*
 * backup.c
 *
 *  Created on: Jun 12, 2016
 *      Author: stas
 */

#include "backup.h"

String* getFileName(String path)
{
	char name[FILENAME_LENGTH];
	int i=0;
	for(i=0; i<FILENAME_LENGTH; i++) {
		name[i] = 0;
	}
	strcpy(name, basename(path));
	return name;
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
	item.name = getFileName(path);

	if(S_ISREG(s.st_mode)) {
		item.type = ItemTypeFile;
		debugPrint("Regular file");
	}
	else if(S_ISDIR(s.st_mode)) {
		item.type = ItemTypeFolder;
		debugPrint("Folder");
	}
	else if(S_ISLNK(s.st_mode)) {
		item.type = ItemTypeSLink;
		debugPrint("Symbolic link");
	}
	else {
		debugPrint("Unknown filetype");
	}

	debugPrint("%s (name=%s, uid=%ld, gid=%ld, size=%ld, modetime = %ld)",
			path, item.name, item.uid, item.gid, item.size, item.modTime.tv_sec);
	return item;
}

void writeFile(String filePath, FILE *backupFile)
{
	BackupItem info = getItemInfo(filePath);
	fwrite(&info,sizeof(BackupItem),1,backupFile);
}

void writeFolder(String folderPath, FILE *backupFile)
{

}

void backup(String targetPath, String sourcePath)
{
	debugPrint("backing up '%s' to file '%s'",sourcePath, targetPath);

	FILE *backup = fopen(targetPath, "w+");
	if(backup == NULL) {
		printf("Could not create file '%s'",targetPath);
		exit(1);
	}

	struct stat s;
	stat(sourcePath, &s);

	if(backup) {
		writeFile(sourcePath, backup);
	}
	else {
		printf("Could not find path '%s'",sourcePath);
		exit(1);
	}
}
