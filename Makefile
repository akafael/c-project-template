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
DOCS_DIR := $(realpath $(MAKEFILE_DIR)/docs)

# Source Code ------------------------------------------------------------

MAIN_SRC := $(SRCS_DIR)/main.c
TEST_SRCS := $(wildcard $(SRCS_DIR)/test_*.c)
SRCS := $(wildcard $(SRCS_DIR)/*.c)
HEADERS := $(wildcard $(SRCS_DIR)/*.h)

# Generated files --------------------------------------------------------

OBJS := $(patsubst %.c,%.o, $(filter-out ${MAIN_SRC} ${TEST_SRCS}, $(SRCS)))
MAIN_BIN = ${BIN_DIR}/main
TEST_BIN := $(patsubst $(SRCS_DIR)/%.c,$(BIN_DIR)/%, $(TEST_SRCS))

# Coverage
COV_SRCS := $(filter-out test% main%, $(SRCS))
GCOV_FILES := $(patsubst %.c,%.c.gcov, $(SRCS))
GCDA_FILES := $(patsubst %.c,%.gcda, $(SRCS))
GCNO_FILES := $(patsubst %.c,%.gcno, $(SRCS))
LCOV_REPORT_DIR := $(abspath $(DOCS_DIR)/lcov)
LCOV_REPORT_INFO := $(abspath $(LCOV_REPORT_DIR)/coverage.info)
LCOV_REPORT_HTML := $(abspath $(LCOV_REPORT_DIR)/index.html)

# Coverage target
COV_TARGET := 80

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
${BIN_DIR}/main: $(SRCS_DIR)/main.o ${OBJS} ${BIN_DIR}
	$(CC) $(CC_FLAGS) $< ${OBJS} -o $@

# Generate binary dir if is missing
${BIN_DIR}:
	mkdir -p ${BIN_DIR}

# Run Binary
.PHONY: run
run: ${BIN_DIR}/main
	${BIN_DIR}/main

# Test Coverage ---------------------------------------------------------------

# deps: gcc, lcov

# Generate Coverage reports
.PHONY: coverage
coverage: lcov-report

# Generate GCOV Report
.PHONY: gcov_output
gcov_output: $(GCOV_FILES)

$(GCOV_FILES): gcov_coverage

# Run code coverage
.PHONY: gcov_coverage
gcov_coverage:
	cd $(SRCS_DIR) && \
	gcov $(SRCS)

# Create report directories
$(LCOV_REPORT_DIR) $(GCOVR_REPORT_DIR):
	mkdir -p $@

# Generate LCOV reports
.PHONY: lcov-report
lcov-report: $(LCOV_REPORT_HTML)

# Generate LCOV info report
$(LCOV_REPORT_INFO): $(LCOV_REPORT_DIR) gcov_coverage
	lcov --capture --rc lcov_branch_coverage=1 \
	     --directory $(SRCS_DIR) \
		 --output-file $@

# Generate LCOV html report
$(LCOV_REPORT_HTML): $(LCOV_REPORT_INFO) $(LCOV_REPORT_DIR)
	genhtml $< --branch-coverage --output-directory $(LCOV_REPORT_DIR)

# Remove coverage output files
.PHONY: clear-coverage
clear-coverage:
	@rm -rf $(GCDA_FILES) $(SRCS_DIR)/*.gcda
	@rm -rf $(GCNO_FILES) $(SRCS_DIR)/*.gcno
	@rm -rf $(GCOV_FILES) $(SRCS_DIR)/*.gcov
	@rm -rf $(LCOV_REPORT_DIR) $(GCOVR_REPORT_DIR)

# Tests -----------------------------------------------------------------------
# Build test file
${BIN_DIR}/test_%: $(SRCS_DIR)/test_%.o ${OBJS} ${BIN_DIR}
	$(CC) $(CC_FLAGS) $< ${OBJS} -o $@

# Build and run all tests
.PHONY: test
test: build ${TEST_BIN}
	${BIN_DIR}/test_utils_basic
	${BIN_DIR}/test_utils_utest

# Auxiliar Rules --------------------------------------------------------------

# Clear Generated Files
.PHONY: clean
clean: clear-coverage
	@rm -fv $(SRCS_DIR)/*.o
	@rm ${BIN_DIR}/* -fvr
