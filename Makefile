all: minicrt test

minicrt:
	gcc -c -m32 -fno-builtin -nostdlib -fno-stack-protector entry.c malloc.c stdio.c string.c printf.c
	ar -rs minicrt.a malloc.o printf.o stdio.o string.o entry.o

test: minicrt
	gcc -c -m32 -ggdb -fno-builtin -nostdlib -fno-stack-protector test.c
	ld -m elf_i386 -static -e mini_crt_entry entry.o test.o minicrt.a -o test

clean:
	rm -rf *.o *.a *.txt test
