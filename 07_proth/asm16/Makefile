# $< - param
# $@ - goal

RESULT	=	bin
AS	=	gcc
LD	=	gcc
SRC	=	main.s

CFLAGS	=	-c -Wall -Werror -pedantic -mthumb
DFLAGS	=	-D_DEBUG -g -O0
RFLAGS	=	-D_RELEASE -O3

OBJ=$(patsubst %.s, %.o, $(SRC))
vpath %.s src/

all: release

debug: CFLAGS += $(DFLAGS)
debug: build

release: CFLAGS += $(RFLAGS)
release: build

build: $(OBJ)
	$(LD) $(LIBS) $(OBJ) -o $(RESULT)

%.o: %.s
	$(AS) $(CFLAGS) $(INCPATH) $< -o $@

.PHONY: clean
clean:
	rm -f $(OBJ)

.PHONY: distclean
distclean: clean
	rm -f $(RESULT)
