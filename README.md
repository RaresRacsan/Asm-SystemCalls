
# Saving KeyStrokes

This is a primitive Keylogger written in x86_64 assembly for linux.

## Key learning point
- How to use System calls in linux (including sys_open, sys_read, sys_write, sys_close, and sys_exit) using asm.

## Prerequisites

- Linux operating system.
- NASM assembler.
- LD linker.

## Building the Keylogger
1. Create a file called keystrokes.log:
    ```sh
    touch keystrokes.log
    ```
2. Assemble the code:

    ```sh
    nasm -f elf64 script.asm -o script.o
    ```

3. Link the object file:

    ```sh
    ld script.o -o script
    ```

## Running the Keylogger

To run the keylogger:

```sh
./script
```

To stop the Keylogger press CTRL + C.

To check the keys that were saved:
```sh
cat keystrokes.log
```
