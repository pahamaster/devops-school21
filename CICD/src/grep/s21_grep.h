#ifndef _SRC_GREP_S21_GREP_H_
#define _SRC_GREP_S21_GREP_H_

#include <regex.h>
#include <stdio.h>
#include <stdlib.h>

#include "support.h"

#define BUFFER_SIZE 16384

struct Counts {
  unsigned match;
  unsigned line;
};

int enum_files(int argc, char **argv, int file_index, struct Flags flags,
               regex_t reg);

int file_working(FILE *file_p, char *file_name, struct Flags flags,
                 regex_t reg);
void line_working(char *buffer, struct Flags flags, struct Counts *counts,
                  char *file_name, regex_t reg);
int main(int argc, char **argv);

#endif  // _SRC_GREP_S21_GREP_H_