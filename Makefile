LD=ld -m elf_i386 /lib/libdl.so.2 --dynamic-linker /lib/ld-linux.so.2 -s

all: ff fftk

ff.o: fflin.asm ff.asm fflinio.asm ff.boot fflin.boot
	fasm $< $@

ff: ff.o
	$(LD) -o $@ $<

cmpl dict: ff
	./ff -f mkimage

fftk.o: fftk.asm cmpl dict
	fasm $< $@

fftk: fftk.o
	$(LD) -o $@ $<

clean:
	rm -f ff fftk *.o

.PHONY: clean
