#include <getopt.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#include "../../common/test.h"

int get_opt(int argc, char **argv, int *f_check_leaks);

const char *params[] = {
    "twenty[1-3] 1", "-e twenty[5-7] 1 2", "-i twenty 1 2", "-nn .eve. 3 4",
    "-c char ../grep.c", "-vc int ../grep.c", "-c teen 6 1", "-ccl teen 5 1",
    "-ci five 2 1 3 4 5", "-cln teen 3 4", "teen 3 4 5", "-l twenty[1-3] 1",
    "-l twenty[3-5] 1 2 3 5", "-in '^sixteen' 1 2 3 4 5",
    "'\\(two\\)\\{2\\}' 1 2 3 4 5", "-e 'twenty[1-3]\\|one' 1 2",
    "-e twenty[1-3] -e one 1 2", "-e twenty[1-3] -e one -e two 3 5",
    "-e twenty[1-3] -e one -e 'two' 1 4",
    "-ec 'twenty[1-3]' -e 'one' -e 'two' 2 4",
    "-c -e 'twenty[1-3]' -e 'one' -e 'two' 2 4", "-h nine 3 4 5",
    "-chl nine 1 2", "-ch nine 1 4 5", "-vh nine 1 2 3 4 5", "-hvn nine 3 4",
    "-hvn nine 3", "once 1 2", "-s once 1 6", "-ic -f reg 2 4", "-f reg 2 4",
    "-f reg -e once 1 2 4 3 4 5", "-f reg 2", "-f re 2 4", "-icg -f reg 2 4",
    "-e twenty[1-3 1", "-e twenty[1-3 -e tee 1", "-e teen -e twenty[1-3 1",
    "-o 'o..e' 1 2", "-on 'o..e' 1 2", "-ol 'o..e' 1 2", "-onlc 'o..e' 1 2",
    "-onl 'o..e' 1 2", "-onc 'o..e' 1 2", "-onvl 'o..e' 1 2 5",
    "-onv 'o..e' 1 2", "-olv 'o..e' 1 2", "-ov 'o..e' 1 2 4",
    "-ovc 'o..e' 1 2 3", "-ol 'o..e' 1 2 3", "-on -e 'o..e' -e 'ty[1-3]' 1 2 3",
    "-oc -e 'o..e' -e 'ty[1-3]' 1 2 3", "-on -e 'o..e' -e 't*n' 1 2 3",
    "-onc -e 'o..e' -e 't*n' 1 2 3", "",
    // "-i 'int' ../*",
    "abs 6",
    // "abc 6",
    NULL
    // "1",
    // "'ggg' ../*",
};

int main(int argc, char **argv) {
  int f_check_leaks = 0, res = 0;
  if (get_opt(argc, argv, &f_check_leaks)) {
    fprintf(stderr, "usage: %s [-l?]\n", argv[0]);
  } else {
    res = test("grep", "./s21_grep", params, f_check_leaks);
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