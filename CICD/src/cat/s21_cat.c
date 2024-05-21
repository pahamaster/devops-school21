#include "s21_cat.h"

int main(int argc, char **argv) {
  int res = 0, file_index;
  struct Flags flags = {0, 0, 0, 0, 0, 0, 0, 0};
  FILE *file_p = NULL;
  unsigned int line_number = 1;
  struct Chars chars = {0, '\n'};
  char buffer[BUFFER_SIZE];

  res = get_opt(&flags, argc, argv);
  file_index = optind;

  while (file_index < argc && !res) {
    file_p = fopen(argv[file_index], "rb");
    if (file_p == NULL) {
      fprintf(stderr, "%s: %s: No such file or directory\n", argv[0],
              argv[file_index]);
    } else {
      size_t count_char = fread(buffer, sizeof(char), BUFFER_SIZE, file_p);
      while (count_char) {
        print_chars(buffer, count_char, flags, &line_number, &chars);
        count_char = fread(buffer, sizeof(char), BUFFER_SIZE, file_p);
      }
      fclose(file_p);
    }
    file_index++;
  }
  return res;
}

void print_chars(char *buffer, size_t count_char, struct Flags flags,
                 unsigned *line_number, struct Chars *chars) {
  for (unsigned i = 0; i < count_char; i++) {
    if (chars->last == '\n' &&
        !(flags.s && buffer[i] == '\n' && chars->penult == '\n')) {
      if (flags.b) {
        if (buffer[i] != '\n') {
          printf("%*d\t", 6, (*line_number)++);
        }
      } else if (flags.n) {
        printf("%*d\t", 6, (*line_number)++);
      }
    }

    if (!(flags.s && buffer[i] == '\n' && chars->last == '\n' &&
          chars->penult == '\n')) {
      if (flags.e || flags.t || flags.v) {
        v_print(buffer[i], flags);
      } else if (flags.E) {
        if (buffer[i] == '\n')
          printf("$\n");
        else
          printf("%c", buffer[i]);
      } else if (flags.T) {
        if (buffer[i] == '\t')
          printf("^I");
        else
          printf("%c", buffer[i]);
      } else {
        printf("%c", buffer[i]);
      }
    }
    chars->penult = chars->last;
    chars->last = buffer[i];
  }
}

int get_opt(struct Flags *flags, int argc, char **argv) {
  int res = 0;
  int opt, option_index = 0;
  static struct option long_options[] = {{"number-nonblank", 0, 0, 'b'},
                                         {"number", 0, 0, 'n'},
                                         {"squeeze-blank", 0, 0, 's'},
                                         {0, 0, 0, 0}};
  while ((opt = getopt_long(argc, argv, "vbeEnstT?", long_options,
                            &option_index)) != -1) {
    if (opt == 'b') flags->b++;
    if (opt == 'e') flags->e++;
    if (opt == 'n') flags->n++;
    if (opt == 's') flags->s++;
    if (opt == 't') flags->t++;
    if (opt == 'T') flags->T++;
    if (opt == 'E') flags->E++;
    if (opt == 'v') flags->v++;
    if (opt == '?') {
      fprintf(stderr,
              "usage: %s [-bveEnstT] [--number-nonblank] [--number] "
              "[--squeeze-blank] [file ...]\n",
              argv[0]);
      res = 1;
    }
  }
  return res;
}

void v_print(unsigned char ch, struct Flags flags) {
  if (ch == '\t' || ch == '\n' || ch == 127 || ch == 255) {
    switch (ch) {
      case '\t':
        if (flags.t || flags.T)
          printf("^I");
        else
          printf("\t");
        break;
      case '\n':
        if (flags.e || flags.E)
          printf("$\n");
        else
          printf("\n");
        break;
      case 127:
        printf("^?");
        break;
      case 255:
        printf("M-^?");
        break;
    }
  } else {
    if ((ch < ' ')) {
      printf("^%c", ch + 64);
    } else if (ch >= ' ' && ch < 127) {
      printf("%c", ch);
    } else if (ch >= 128 && ch < 160) {
      printf("M-^%c", ch - 64);
    } else {
      printf("M-%c", ch - 128);
    }
  }
}
