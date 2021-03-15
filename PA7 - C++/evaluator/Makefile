
CC = g++  # or instead of 'g++' choose compiler 'clang++'
FLAGS = -std=c++17 -Wall -Wextra -pedantic # use latest C++17 and give usefull warnings
SRCS = $(wildcard *.cpp)
HEADERS = $(wildcard *.h)
PROGS = $(patsubst %.cpp,%,$(SRCS))

all: 	$(PROGS)

clean:
	rm -f $(PROGS) ./intermediate_result_*.txt

%: %.cpp $(HEADERS)
	$(CC) $(FLAGS) -o $@ $<
