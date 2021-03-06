#############################################################################
# Makefile for building: csvworker
#############################################################################

MAKEFILE      = Makefile

####### Compiler, tools and options

CC            = gcc
CXX           = g++
CFLAGS        = -pipe -g -Wall -W -D_REENTRANT -fPIE $(DEFINES)
CXXFLAGS      = -pipe -g -Wall -W -D_REENTRANT -fPIC
INCPATH       = -I. -I/usr/include
LINK          = g++

####### Output directory

OBJECTS_DIR   = ./


first: all

all: libcsvworker.so example

example: libcsvworker.so example.o
	$(CXX) -o example example.o -L. -lcsvworker

example.o: example.cpp csvworker.h
	$(CXX) -c $(CXXFLAGS) $(INCPATH) -o example.o example.cpp

libcsvworker.so: csvworker.o
	$(CXX) -shared -o libcsvworker.so csvworker.o

csvworker.o: csvworker.cpp csvworker.h
	$(CXX) -c $(CXXFLAGS) $(INCPATH) -L/usr/lib -o csvworker.o csvworker.cpp

clean:
	rm -f *.o *.so example

install:
	install libcsvworker.so /usr/lib
	install csvworker.h /usr/include

uninstall:
	rm -rf /usr/lib/libcsvworker.so
	rm -rf /usr/include/csvworker.h
