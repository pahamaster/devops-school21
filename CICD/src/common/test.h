#ifndef _SRC_COMMON_TEST_H_
#define _SRC_COMMON_TEST_H_

#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int file_is_empty(char *file_str);
void execute_command(const char *s1, const char *s2, const char *s3);
int test(const char *command1, const char *command2, const char *commands[],
         const int f_check_leaks);
void execute_command_leak(const char *s1, const char *s2, const char *s3);

#endif  // _SRC_COMMON_TEST_H_