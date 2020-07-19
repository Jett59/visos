all: boot.vbl load.vkl

boot.vbl: clean-boot


load.vkl: load-clean
	nasm mbr/main.asm -o loader.vkl

boot-clean:
	rm -f *.vkl

load-clean:
	rm -f *.vkl
