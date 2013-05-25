# $< - param
# $@ - goal

RESULT	=	bin
CC	=	gcc
LD	=	gcc
INCPATH	=	-I/usr/include/ -I./inc/
LIBS	=	-L/usr/lib -lc
SRC	=	main.c

CFLAGS	=	-c -Wall -Werror -pedantic
DFLAGS	=	-D_DEBUG -g -O0
RFLAGS	=	-D_RELEASE -O3

OBJ=$(patsubst %.c, %.o, $(SRC))
vpath %.c src/

all: release

debug: CFLAGS += $(DFLAGS)
debug: build

release: CFLAGS += $(RFLAGS)
release: build

build: $(OBJ)
	$(LD) $(LIBS) $(OBJ) -o $(RESULT)

%.o: %.c
	$(CC) $(CFLAGS) $(INCPATH) $< -o $@

.PHONY: clean
clean:
	rm -f $(OBJ)

.PHONY: distclean
distclean: clean
	rm -f $(RESULT)
