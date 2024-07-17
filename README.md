nasm -f elf64 script.asm -o script.o
ld script.o -o script
./script
