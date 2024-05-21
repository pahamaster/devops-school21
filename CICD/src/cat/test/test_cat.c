
#include <getopt.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#include "../../common/test.h"

int get_opt(int argc, char **argv, int *f_check_leaks);

const char *params[] = {
    "-f 3", "33", "-sj 35", "3", "-T 3", "1", "-E 3", "-be 1 2", "-bn 1 5",
    "-st 2 4", "-bT 1 2 3", "-b --squeeze-blank 1 2 3", "-e 3 3 5",
    "--number-nonblank -s 1 2 4", "--number -s 1 2 4", "-v 1 2 4", "-sT 2 4 5",
    "-E 1 3 2 4", "-benst 1 3 2 4", "-benst 12", "-bens 3 3 3", "-b 3 3 3",
    "-e 3 3 3", "-n 3 3 3", "-s 3 3 3", "-E 3 3 3", "-t 3 3 3",
    "-bes ../cat.c ../cat.c", "7 3", "-q 3", "-bs ../cat.c 12 3", "-e 6",
    "-et 6",
    // "-bs ../*",
    NULL};

int main(int argc, char **argv) {
  int f_check_leaks = 0, res = 0;
  if (get_opt(argc, argv, &f_check_leaks)) {
    fprintf(stderr, "usage: %s [-l?]\n", argv[0]);
  } else {
    res = test("cat", "./s21_cat", params, f_check_leaks);
  }
  return res;
}

int get_opt(int argc, char **argv, int *f_check_leaks) {
  int res = 0;
  int opt;
  while ((opt = getopt(argc, argv, "l?")) != -1) {
    if (opt == 'l') (*f_check_leaks)++;
    if (opt == '?') res = 1;
  }
  return res;
}