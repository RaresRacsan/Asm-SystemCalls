chmod 644 keys.log
nasm -f elf64 script.asm -o script.o
ld script.o -o script
./script
