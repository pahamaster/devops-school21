#ifndef SRC_GREP_SUPPORT_H_
#define SRC_GREP_SUPPORT_H_

#include <getopt.h>
#include <regex.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

struct Flags {
  char i;
  char v;
  char c;
  char l;
  char n;
  char h;
  char s;
  char o;
  char name;
};

int get_opt(struct Flags *flags, char **pattern, int argc, char **argv);
char *sub_str(const char *str, unsigned start, unsigned end);
void add_n(char *buffer);
int reg_exec(regex_t reg, char *buffer, regmatch_t *pm);
void add_pattern(char **pattern, char *str);
void read_patterns(struct Flags *flags, char **pattern, char *file_name,
                   char *app_name);

#endif  // SRC_GREP_SUPPORT_H_