CFLAGS=`pkg-config --libs --cflags raylib`

run: build
	./RunVisualizer $(FILEPATH)

build:
	cc $(CFLAGS) main.c -g -o RunVisualizer

clean:
	rm -f main.o RunVisualizer
