CC=clang
CFLAGS=-m16 -ffreestanding -target x86_64-unknown-linux-elf --sysroot=./include/ -I ./include/ -nostdinc
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
