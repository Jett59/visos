CC=clang
CFLAGS=-m16 -ffreestanding -target i386-unknown-linux-elf --sysroot=./include/ -I ./include/
AFLAGS=-felf

all: image.bin

image.bin: image.img
	objcopy -O binary image.img image.bin

%.obj: %.nasm
	nasm $(AFLAGS) $^ -o $@

image.img: mbr.obj _kernel_functions.obj kernel16.o
	ld.lld -T boot.ld -o image.img $^

clean:
	rm *.o *.obj image.img image.bin
