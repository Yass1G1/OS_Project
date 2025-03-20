# Note related to my OS Project 
# Video followed : https://www.youtube.com/watch?v=9t-SPC7Tczc&list=PLFjM7v6KGMpiH2G-kT781ByCNC_0pKpPN

## To run system : 
## make Makefile (install nasm, make)
## qemu-system-i386 -fda build/main_floppy.img 
--
## Theory 
### CPU ARCHITECTURE : 
**Register** : ...


**Stack** : the stack grows downwards ("sp" is decremented by the number of bytes pushed) which is why we put the "sp" pointer (which points at the top of the stack) at the address 0x7C00 (which is the where the bios gonna find the OS) to ensure that the stack won't overwrite the program we're writing.

**interrupt** : a signal that stops the CPU from whatever it is doing to handle that signal
- An exception : Dividing by 0, segfault, page fault...
- Hardware : key pressed, disk controller finished on operation
- Software : through "int" instruction (0 --> 255 : 10h video; 13h Disk I/O; 15h Cassette; etc...). Each of these "int" value has sub-values that specify which actions to do 


## Definitions
Directive : assembler-specific information to choose how program gets compiled
Instruction : code that will be translated to machine code and executed by CPU

## Directives
ORG : 
BITS : to emit code in a certain bit format (16, 32, 64)
DB : "define bytes", hard-code certain bytes value in binary file
TIMES : indicate how many time instruction has to be repeated
DW : similar to DB but for "words" (2 bytes value)

## Instructions
hlt : stops CPU from executing
jmp : jump to given location
mov <dest>, <src> : copies data from source
lodsb, lodsw, lodsd : load a byte/word/double-word from ds:si into AL/AX/EAX, then increment si by the number of bytes loaded
or <dest>, <src> : perform bitwise OR and store results in dest
jz <dest> : jump to destination if zero flag is set

## Misc
$ : Special symbol which is equal to the memory offset of the current line
$$ : equal to the memory offset of the current section (in our case : program)
$-$$ : gives the size of the program (big off - smaller off)

## Syntax
example 1 :
var: dw 100         ; assign label "var" a word with value = 100
    mov ax, var     ; copy offset (of label "var) to ax
    mov ax, [var]   ; copy memory content to ax

example 2 : 
array: dw 100, 200, 300
    mov bx, array       ; copy offset of array in bx    
    mov si, 2 * 2       ; copy array[2] (& word of 2 bytes) into si
    mov ax, [bx + si]   ; copy [offset of array + offset of 3rd element] into ax 