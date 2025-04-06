# ASS01 Example Makefile
#
# This makefile is intended for use with GNU make
# This example is intended to be built with Linaro bare-metal GCC

TARGET=Lab03
CC=gcc
LD=gcc

FLAGS=-g -O0

all: $(TARGET)

clean:
	rm *.o
	rm $(TARGET)

main.o: main.c
# Compile for best debug view (lowest optimization)
	$(CC) $(FLAGS) -c $^  -o $@

test.o: test.S
# Compile for best debug view (lowest optimization)
	$(CC) $(FLAGS) -c $^ -o $@

q3.o: lab03b.S
	$(CC) $(FLAGS) -c $^ -o $@

q4.o: lab03c.S
	$(CC) $(FLAGS) -c $^ -o $@

$(TARGET): main.o test.o q3.o q4.o
	$(LD) main.o test.o q3.o q4.o -o $@
