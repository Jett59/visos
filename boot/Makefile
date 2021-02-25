CC=clang
CFLAGS=-m16 -ansi -ffreestanding -target x86_64-unknown-linux-elf --sysroot=./include/ -I ./include/ -nostdinc
AFLAGS=-felf

all: image.bin

image.bin: image.img
	@echo "objcopy $@"
	@objcopy -O binary image.img image.bin

%.obj: %.nasm
	@echo "nasm $@"
	@nasm $(AFLAGS) $^ -o $@

%.o: %.c
	@echo "$(CC) $@"
	@$(CC) $(CFLAGS) -c $^ -o $@

image.img: realmode/mbr.obj realmode/vram.obj realmode/kernel16.o realmode/video.o realmode/main.o
	@echo "ld.lld $@"
	@ld.lld -T boot.ld -o image.img $^

clean:
	rm */*.o */*.obj image.img image.bin
