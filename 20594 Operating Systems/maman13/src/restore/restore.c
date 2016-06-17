/*
 * restore.c
 *
 *  Created on: Jun 12, 2016
 *      Author: stas
 */

#include "restore.h"

void restore(String fileToRestore)
{
	debugPrint("restoring file '%s'", fileToRestore);
	FILE *backup = fopen(fileToRestore,"r");
	if(backup) {
		debugPrint("Found path");
	}
	else {
		debugPrint("Path was not found");
	}
}
