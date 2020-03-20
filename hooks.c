/*
  Hooks for emulating Tenda routers. This has only been tested on two different Tenda versions: AC6 and AC15. 
  Cross-compile for the Arm architecture and copy it into the squashfs-root folder.
*/

#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <dlfcn.h>
#include <string.h>

int j_get_cfm_blk_size_from_cache(const int i) 
{
	puts("j_get_cfm_blk_size_from_cache called....\n");
	return 0x20000;
}

int get_flash_type()
{
	puts("get_flash_type called....\n");
	return 4;
}

int load_l7setting_file()
{
	puts("load_l7setting_file called....\n");
	return 1;
}

int restore_power(int a, int b)
{
	puts("restore_power called....\n");	
	return 0;
}

char *bcm_nvram_get(char *key)
{
	char *value = NULL;
    
	if(strcmp(key, "et0macaddr") == 0)
	{
			value = strdup("DE:AD:BE:EF:CA:FE");
	}

  if(strcmp(key, "sb/1/macaddr") == 0)
	{
			value = strdup("DE:AD:BE:EF:CA:FD");
	}

	if(strcmp(key, "default_nvram") == 0)
	{
			value = strdup("default_nvram");
	}

	printf("bcm_nvram_get(%s) == %s\n", key, value);

	return value;
}
