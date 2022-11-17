C_SOURCES = $(wildcard kernel/*.c drivers/*.c)
OBJ = ${C_SOURCES:.c=.o}
HEADERS = $(wildcard kernel/*.h drivers/*.h)

all: os-image

run: all
	qemu-system-x86_64 -fda os-image

os-image: boot/boot_sect.bin kernel.bin
	cat $^ > os-image

kernel.bin: kernel/kernel_entry.o ${OBJ}
	ld -o $@ -Ttext 0x1000 $^ --oformat binary

%.o : %.c ${HEADERS}
	gcc -ffreestanding -c $< -o $@

%.o : %.asm
	nasm $< -f elf64 -o $@

%.bin : %.asm
	nasm $< -f bin -I 'boot/16bit/' -o $@

clean:
	rm -fr *.bin *.o *.dis os-image *map
	rm -fr kernel/*.o boot/*.bin drivers/*.o

kernel.dis : kernel.bin
	ndisasm -b 32 $< > $@