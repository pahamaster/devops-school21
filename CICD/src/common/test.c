#include "test.h"

int test(const char *command1, const char *command2, const char *params[],
         const int f_check_leaks) {
  unsigned success_count = 0, fail_count = 0, error_count = 0,
           diff_error_count = 0, leaks_count = 0, valgrind_error_count = 0;
  unsigned i;
  for (i = 0; params[i]; i++) {
    int e1_empty, e2_empty;

    execute_command(command1, params[i], " > r1 2> e1");
    execute_command(command2, params[i], " > r2 2> e2");
    e1_empty = file_is_empty("e1");
    e2_empty = file_is_empty("e2");
    system("diff r1 r2 > r");
    if (!e1_empty || !e2_empty) {
      // system("cat e1");
      // system("cat e2");
      if (!e1_empty && !e2_empty) {
        // printf("Equal errors\n");
        error_count++;
      } else {
        // printf("Different errors\n");
        diff_error_count++;
      }
    }
    if (file_is_empty("r") && (e1_empty == e2_empty)) {
      // ((e1_empty && e2_empty) || (!e1_empty && !e2_empty))) {
      // printf("Test passed\n");
      success_count++;
    } else {
      // printf("%s:\n", command1);
      // system("cat r1");
      // printf("%s:\n", command2);
      // system("cat r2");
      printf("Test %u\n%s %s\n", i + 1, command2, params[i]);
      if (e1_empty != e2_empty) {
        printf("Different errors\n");
        system("cat e1");
        system("cat e2");
      }
      system("cat r");
      printf("Test fail\n\n");
      fail_count++;
    }

    if (f_check_leaks) {
      execute_command_leak(command2, params[i], " > r2 2> e2");
      system("grep 'no leaks are possible' e2 > r");
      if (file_is_empty("r")) {
        leaks_count++;
        printf("Leaks detected\n");
      }
      system("grep 'ERROR SUMMARY: 0' e2 > r");
      if (file_is_empty("r")) {
        valgrind_error_count++;
        system("grep 'ERROR SUMMARY' e2");
      }
    }

    // printf("\n");
  }
  printf("Total tests: %d\n", i);
  if (!fail_count) {
    printf("All tests passed successfully\n");
  } else {
    printf("Success: %u. Fail: %u\n", success_count, fail_count);
  }
  // if (error_count) printf("Equal errors: %u\n", error_count);
  if (diff_error_count) printf("Different errors: %u\n", diff_error_count);
  if (f_check_leaks) {
    if (leaks_count)
      printf("Leaks count: %u\n", leaks_count);
    else
      printf("Leaks not found\n");
    if (valgrind_error_count)
      printf("Valgrind error: %u\n", valgrind_error_count);
  }
  return fail_count;
}

int file_is_empty(char *file_str) {
  int res = 0;
  FILE *file;
  file = fopen(file_str, "r");
  fgetc(file);
  if (feof(file)) res = 1;
  fclose(file);
  return res;
}

void execute_command(const char *s1, const char *s2, const char *s3) {
  const unsigned len_str = strlen(s1) + strlen(s2) + strlen(s3) + 2;
  char *str = calloc(len_str, 1);
  strcpy(str, s1);
  strcat(str, " ");
  strcat(str, s2);
  strcat(str, s3);
  system(str);
  str[strlen(str) - 11] = 0;
  // printf("%s\n", str);
  free(str);
}

void execute_command_leak(const char *s1, const char *s2, const char *s3) {
  const char *valgrind = "valgrind --leak-check=full --leak-resolution=med ";
  char *str = calloc(strlen(s1) + strlen(valgrind) + 1, 1);
  strcpy(str, valgrind);
  strcat(str, s1);
  execute_command(str, s2, s3);
  free(str);
}