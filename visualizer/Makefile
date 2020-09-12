CFLAGS=`pkg-config --libs --cflags raylib`

run: build
	./RunVisualizer

build:
	cc $(CFLAGS) main.c -o RunVisualizer

clean:
	rm -f main.o RunVisualizer
