all: boot.vbl load.vkl

boot.vbl: clean-boot
	nasm boot/main.asm -o boot.vbl

load.vkl: clean-load
	nasm load/main.asm -o load.vkl

clean-boot:
	rm -f *.vbl

clean-load:
	rm -f *.vkl
