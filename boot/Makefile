AFLAGS=-felf

all: image.bin

image.bin: image.img
	objcopy -O binary image.img image.bin

%.o: %.nasm
	nasm $(AFLAGS) $^ -o $@

image.img: mbr.o kernel_entry.o
	ld.lld -T boot.ld -o image.img mbr.o kernel_entry.o

clean:
	rm *.o image.img image.bin
