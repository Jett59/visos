AFLAGS=-felf

all: image.bin

image.bin: image.img
	objcopy -O binary image.img image.bin

%.o: %.nasm
	nasm $(AFLAGS) $^ -o $@

image.img: $(patsubst %.nasm,%.o,$(shell find -type f -name "*.nasm"))
	ld.lld -T boot.ld -o image.img $^

clean:
	rm *.o image.img image.bin
