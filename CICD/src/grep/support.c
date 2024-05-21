#include "support.h"

void add_n(char *buffer) {
  unsigned len_buff = strlen(buffer);
  if (len_buff && buffer[len_buff - 1] != '\n') {
    buffer[len_buff + 1] = 0;
    buffer[len_buff] = '\n';
  }
}

int get_opt(struct Flags *flags, char **pattern, int argc, char **argv) {
  int res = 0;
  int opt;
  while ((opt = getopt(argc, argv, "e:f:ivclnhso?")) != -1) {
    if (opt == 'e') {
      add_pattern(pattern, optarg);
    }
    if (opt == 'f') {
      read_patterns(flags, pattern, optarg, argv[0]);
    }
    if (opt == 'i') flags->i++;
    if (opt == 'v') flags->v++;
    if (opt == 'c') flags->c++;
    if (opt == 'l') flags->l++;
    if (opt == 'n') flags->n++;
    if (opt == 'h') flags->h++;
    if (opt == 's') flags->s++;
    if (opt == 'o') flags->o++;
    if (opt == '?') res = 1;
  }
  return res;
}

void read_patterns(struct Flags *flags, char **pattern, char *file_name,
                   char *app_name) {
  FILE *file_p;
  file_p = fopen(file_name, "r");
  if (file_p == NULL) {
    if (!flags->s)
      fprintf(stderr, "%s: %s: No such file or directory\n", app_name,
              file_name);
  } else {
    char buffer[128];
    while (fgets(buffer, 127, file_p)) {
      unsigned len_buff = strlen(buffer);
      if (len_buff && buffer[len_buff - 1] == '\n') buffer[len_buff - 1] = 0;
      add_pattern(pattern, buffer);
    }
    fclose(file_p);
  }
}

int reg_exec(regex_t reg, char *buffer, regmatch_t *pm) {
  int res_reg = regexec(&reg, buffer, 1, pm, 0);
  if (res_reg > REG_NOMATCH) {
    char e_buff[128];
    regerror(res_reg, &reg, e_buff, sizeof(e_buff));
    fprintf(stderr, "%s: regexec('%s')\n", e_buff, buffer);
  }
  return res_reg;
}

void add_pattern(char **pattern, char *str) {
  if (*pattern == NULL) {
    *pattern = calloc(strlen(str) + 1, 1);
    strcpy(*pattern, str);
  } else {
    char *temp = calloc(strlen(str) + strlen(*pattern) + 3, 1);
    strcpy(temp, *pattern);
    strcat(temp, "\\|");
    strcat(temp, str);
    free(*pattern);
    *pattern = temp;
  }
}

char *sub_str(const char *str, unsigned start, unsigned end) {
  int n = end - start;
  char *buf = NULL;
  if (n > 0) {
    buf = calloc(n + 1, 1);
    strncpy(buf, str + start, n);
  }
  return buf;
}
