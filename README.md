[![C/C++ CI](https://github.com/akafael/c-project-template/actions/workflows/build.yaml/badge.svg?branch=master)](https://github.com/akafael/c-project-template/actions/workflows/build.yaml)

# c-project-template

Minimal Template for C Projects using Makefile

## Requirements

* gcc
* make
* lcov

## Commands

### Build

```bash
make
```

### Test

```bash
make test
```

### Removing Generated files

```bash
make clean
```

### Generating coverage report

```bash
make clean
make test coverage
```

## Reference

 * [GCC Guide](http://www.network-theory.co.uk/docs/gccintro/gccintro_9.html)
 * [Introduction to Makefile](https://www.gnu.org/software/make/manual/make.html#Introduction)
 * [Google C++ Style Guide](https://google.github.io/styleguide/cppguide.html)
 * [GCOV Example](https://github.com/shenxianpeng/gcov-example): Great code example from @shenxianpeng.