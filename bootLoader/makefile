all: boot.vbl load.vkl

boot.vbl: clean-boot
	nasm mbr/main.asm -o loader.vkl

load.vkl: clean-load
	echo "todo: implement kernel loader compile"

clean-boot:
	rm -f *.vbl

clean-load:
	rm -f *.vkl
