CC=clang
CFLAGS=-mregparm=3 -ansi -ffreestanding -target x86_64-unknown-linux-elf --sysroot=./include/ -I ./include/ -nostdinc
AFLAGS=-felf

all: image.bin

image.bin: image.img
	@echo "objcopy $@"
	@objcopy -O binary image.img image.bin

%.obj: %.nasm
	@echo "nasm $@"
	@nasm $(AFLAGS) $^ -o $@

realmode/%.o: realmode/%.c
	@echo "$(CC) $@"
	@$(CC) -m16 $(CFLAGS) -c $^ -o $@

image.img: realmode/mbr.obj realmode/vram.obj realmode/bios.obj realmode/io.obj realmode/memory.obj realmode/kernel16.o realmode/video.o realmode/a20.o realmode/main.o
	@echo "ld.lld $@"
	@ld.lld -T boot.ld -o image.img $^

clean:
	@echo "clean image"
	@rm image.bin image.img
	@echo "clean realmode/"
	@rm realmode/*.o realmode/*.obj
