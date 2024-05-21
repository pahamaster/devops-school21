#include "s21_grep.h"

int main(int argc, char **argv) {
  int res = 0, file_index;
  struct Flags flags = {0, 0, 0, 0, 0, 0, 0, 0, 0};
  regex_t reg;
  char *pattern = NULL;

  res = get_opt(&flags, &pattern, argc, argv);
  file_index = optind;

  if (argc > 1 && !res) {
    int res_reg, c_flags = 0;
    if (flags.i) c_flags += REG_ICASE;

    if (!pattern && optind < argc) {
      add_pattern(&pattern, argv[optind]);
      file_index++;
    }

    res_reg = regcomp(&reg, pattern, c_flags);
    if (res_reg) {
      char e_buff[128];
      regerror(res_reg, &reg, e_buff, 128);  // BUFFER_SIZE
      fprintf(stderr, "%s: pattern '%s' \n", e_buff, pattern);
      res = 1;
    } else {
      res = enum_files(argc, argv, file_index, flags, reg);
    }
    regfree(&reg);
  } else {
    fprintf(stderr, "usage: %s [-e PATTERN -f file -ivclnhso?] [file ...]\n",
            argv[0]);
  }
  if (pattern) free(pattern);
  return res;
}

int enum_files(int argc, char **argv, int file_index, struct Flags flags,
               regex_t reg) {
  int res = 0;
  flags.name = ((argc - file_index) > 1) && !flags.h;

  while (file_index < argc && !res) {
    FILE *file_p = fopen(argv[file_index], "r");
    if (file_p == NULL) {
      if (!flags.s)
        fprintf(stderr, "%s: %s: No such file or directory\n", argv[0],
                argv[file_index]);
    } else {
      res = file_working(file_p, argv[file_index], flags, reg);
      fclose(file_p);
    }
    file_index++;
  }
  return res;
}

int file_working(FILE *file_p, char *file_name, struct Flags flags,
                 regex_t reg) {
  int res = 0;
  char buffer[BUFFER_SIZE];
  struct Counts counts = {0, 1};

  while (fgets(buffer, BUFFER_SIZE - 1, file_p) && !res) {
    int res_reg;
    regmatch_t pm;
    add_n(buffer);
    res_reg = reg_exec(reg, buffer, &pm);
    if (res_reg > REG_NOMATCH) {
      res = 1;
    } else {
      if ((flags.v && res_reg) || (!flags.v && !res_reg)) {
        line_working(buffer, flags, &counts, file_name, reg);
      }
    }
    counts.line++;
  }

  if (!res) {
    if (flags.l) {
      if (counts.match) printf("%s\n", file_name);
    } else if (flags.c) {
      if (flags.name) printf("%s:", file_name);
      printf("%u\n", counts.match);
    }
  }
  return res;
}

void line_working(char *buffer, struct Flags flags, struct Counts *counts,
                  char *file_name, regex_t reg) {
  if (!flags.c && !flags.l) {
    if (!flags.o) {
      if (flags.name) printf("%s:", file_name);
      if (flags.n) printf("%u:", counts->line);
      printf("%s", buffer);
    } else {
      regmatch_t pm;
      unsigned offset = 0;
      while (reg_exec(reg, buffer + offset, &pm) == 0) {
        char *str = sub_str(buffer + offset, pm.rm_so, pm.rm_eo);
        if (str) {
          if (flags.name) printf("%s:", file_name);
          if (flags.n) printf("%u:", counts->line);
          printf("%s\n", str);
          free(str);
        }
        offset += pm.rm_eo;
      }
    }
  }
  counts->match++;
}
