##
# Makefile to automate everything
# @author Rafael
##

###############################################################################
# Variables
###############################################################################

# Compiler Options -------------------------------------------------------
CC = gcc
CODE_QUALITY_FLAGS := -Wall -Werror -Wpedantic 
DEBUG_FLAGS := -ggdb -fprofile-arcs
COVERAGE_FLAGS_BUILD := -ftest-coverage 
COVERAGE_FLAGS_LD := -lgcov
CC_FLAGS = -fPIC $(CODE_QUALITY_FLAGS) $(DEBUG_FLAGS)

# Folders Paths ----------------------------------------------------------

# Get Makefile directory (enables using it as reference for relative paths)
MAKEFILE_DIR:=$(dir $(realpath $(firstword $(MAKEFILE_LIST))))
SRCS_DIR := $(realpath $(MAKEFILE_DIR)/src)
BIN_DIR := $(realpath $(MAKEFILE_DIR))/bin

# Source Code ------------------------------------------------------------

MAIN_SRC := $(SRCS_DIR)/main.c
SRCS := $(wildcard $(SRCS_DIR)/*.c)
HEADERS := $(wildcard $(SRCS_DIR)/*.h)

# Generated files --------------------------------------------------------

OBJS := $(patsubst %.c,%.o, $(filter-out ${MAIN_SRC}, $(SRCS)))
MAIN_BIN = ${BIN_DIR}/main

###############################################################################
# Rules
###############################################################################

# Build -----------------------------------------------------------------------

# Build Everything
build: ${MAIN_BIN}

# Generate .o files
%.o: %.c %.h
	$(CC) $(CC_FLAGS) $(COVERAGE_FLAGS_BUILD) -c $< -o $@

# Build main binary
${BIN_DIR}/main: $(SRCS_DIR)/main.o $(SRCS_DIR)/utils.o
	$(CC) $(CC_FLAGS) $^ -o $@

# Generate binary dir if is missing
${BIN_DIR}:
	mkdir -p ${BIN_DIR}

# Tests -----------------------------------------------------
# Build test file
${BIN_DIR}/test_%: $(SRCS_DIR)/test_%.o $(SRCS_DIR)/utils.o
	$(CC) $(CC_FLAGS) $^ -o $@

test: build ${BIN_DIR}/test_utils_basic
	${BIN_DIR}/test_utils_basic

# Auxiliar Roles --------------------------------------------------------------

# Clear Generated Files
.PHONY: clean
clean:
	@rm -fv $(SRCS_DIR)/*.o
	@rm -fv $(SRCS_DIR)/*.gcda
	@rm -fv $(SRCS_DIR)/*.gcno
	@rm -fv $(SRCS_DIR)/*.gcov
	@rm ${BIN_DIR}/* -fvr
