CC=gcc
CFLAGS=-g2 -ggdb -std=c11 -pedantic -W -Wall -Wextra -Wno-pointer-arith

.SUFFIXES:
.SUFFIXES: .c .o

DEBUG=./build/debug
RELEASE=./build/release
OUT_DIR=$(DEBUG)

vpath %.c src
vpath %.h src
vpath %.o build/debug

ifeq ($(MODE), release)
	CFLAGS = -std=c11 -pedantic -W -Wall -Wextra -Wno-unused-parameter -Wno-pointer-arith -Werror
	OUT_DIR = $(RELEASE)
	vpath %.o build/release
endif

objects = $(OUT_DIR)/sorter.o
prog = $(OUT_DIR)/sorter

ifeq ($(TARGET), generator)
	objects = $(OUT_DIR)/generator.o
	prog = $(OUT_DIR)/generator
endif

ifeq ($(TARGET), viewer)
	objects = $(OUT_DIR)/viewer.o
	prog = $(OUT_DIR)/viewer
endif

.PHONY: all

all: $(OUT_DIR) $(prog)

$(OUT_DIR):
	mkdir -p $(OUT_DIR)

$(prog): $(objects)
	$(CC) $(CFLAGS) $(objects) -o $@

$(OUT_DIR)/%.o: %.c
	$(CC) -c $(CFLAGS) $^ -o $@

.PHONY: clean
clean:
	@rm -rf $(DEBUG)/* $(RELEASE)/*
