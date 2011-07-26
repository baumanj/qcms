
COVERAGE_FLAGS=-fprofile-arcs -ftest-coverage
#COVERAGE_FLAGS=
OPT_FLAGS=-O0
OPT_FLAGS=
CFLAGS=-Wall $(OPT_FLAGS) $(COVERAGE_FLAGS) -Wdeclaration-after-statement -ggdb `pkg-config --cflags lcms`
LDFLAGS=`pkg-config --libs lcms` -ldl

QCMS_SRC=iccread.c transform.c matrix.c chain.c transform_util.c transform-sse2.c transform-sse1.c
QCMS_OBJS=iccread.o transform.o matrix.o chain.o transform_util.o transform-sse2.o transform-sse1.o

PROGRAMS=profile-gen test test-invalid lcms-compare dump-profile div-test coverage malloc-fail invalid-coverage

all: $(PROGRAMS)

$(PROGRAMS): $(QCMS_OBJS)

gen-coverage:
	mkdir -p lcov
	lcov -d . -c --output-file lcov/lcov.info
	genhtml -o lcov/ lcov/lcov.info

clean:
	rm -f $(PROGRAMS) $(QCMS_OBJS)
