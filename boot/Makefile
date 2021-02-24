CC=clang
CFLAGS=-m16 -ansi -ffreestanding -target x86_64-unknown-linux-elf --sysroot=./include/ -I ./include/ -nostdinc
AFLAGS=-felf

all: image.bin

image.bin: image.img
	objcopy -O binary image.img image.bin

%.obj: %.nasm
	nasm $(AFLAGS) $^ -o $@

image.img: mbr.obj vram.obj kernel16.o video.o main.o
	ld.lld -T boot.ld -o image.img $^

clean:
	rm *.o *.obj image.img image.bin
