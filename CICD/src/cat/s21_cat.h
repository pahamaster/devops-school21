#ifndef _SRC_CAT_S21_CAT_H_
#define _SRC_CAT_S21_CAT_H_

#include <getopt.h>
#include <stdio.h>
#include <stdlib.h>

#define BUFFER_SIZE 4096

struct Flags {
  char b;
  char e;
  char n;
  char s;
  char t;
  char T;
  char E;
  char v;
};

struct Chars {
  char penult;
  char last;
};

int main(int argc, char **argv);
void v_print(unsigned char ch, struct Flags flags);
int get_opt(struct Flags *flags, int argc, char **argv);
void print_chars(char *buffer, size_t count_char, struct Flags flags,
                 unsigned *line_number, struct Chars *chars);

#endif  // _SRC_CAT_S21_CAT_H_
