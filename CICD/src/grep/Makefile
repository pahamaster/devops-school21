# Makefile

CFLAGS=-c -Wall -Werror -Wextra

all: build

rebuild: clean all

# "Build"
build: s21_grep

test: build test_grep
	cp -f s21_grep ./test/s21_grep
	cd test && ./test

test_grep: test.o test_grep.o
	gcc test.o test_grep.o -o test/test

test.o: ../common/test.c
	gcc $(CFLAGS) ../common/test.c -o test.o

test_grep.o: test/test_grep.c
	gcc $(CFLAGS) test/test_grep.c -o test_grep.o

s21_grep: s21_grep.o support.o
	gcc s21_grep.o support.o -o s21_grep

support.o: support.c
	gcc $(CFLAGS) support.c -o support.o	

s21_grep.o: s21_grep.c
	gcc $(CFLAGS) s21_grep.c -o s21_grep.o

test_style:
	clang-format -n -verbose --Werror --style=Google *.c *.h test/*.c

format_style:
	clang-format -i --style=Google *.c *.h test/*.c

clean:
	rm -f *.o *.a *.so s21_grep
	cd test && rm -f *.o e1 e2 r r1 r2 s21_grep test
