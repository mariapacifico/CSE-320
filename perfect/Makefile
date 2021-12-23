project = perfect

objs = $(project).o

CC=gcc
CFLAGS := $(CFLAGS) -Wall

outputfile  = $(project)

.PHONY: all
all: $(project)

$(project): $(objs)
.PHONY: clean
clean:
	rm -f $(project)
	rm -f *.o
