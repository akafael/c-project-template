##
# Basic Makefile for C
##

# Compiler Options
CC = gcc
CC_FLAGS = -Wall

##
# Recipes
##
.PHONY = ALL
ALL: main

# Compile
main: main.c main.h
	$(CC) $(CC_FLAGS) main.c -o main

# Clear Generated Files
clear: main
	rm main
