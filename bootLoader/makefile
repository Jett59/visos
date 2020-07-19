all: combine

combine: boot.vbl load.vkl
	cat boot.vbl load.vkl > image.bin

boot.vbl: clean-boot
	nasm boot/main.asm -o boot.vbl

load.vkl: clean-load
	nasm load/main.asm -o load.vkl

clean-boot:
	rm -f *.vbl

clean-load:
	rm -f *.vkl

test: combine
	qemu-system-i386 image.bin
