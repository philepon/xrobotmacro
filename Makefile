VERSION=0.4

all: xrobotmacroplay xrobotmacrorec

xrobotmacroplay: xrobotmacroplay.cpp chartbl.h
	g++ -O2  -I/usr/X11R6/include -Wall -pedantic -DVERSION=$(VERSION) xrobotmacroplay.cpp -o xrobotmacroplay -L/usr/X11R6/lib -lXtst -lX11

xrobotmacrorec: xrobotmacrorec.cpp
	g++ -O2  -I/usr/X11R6/include -Wall -pedantic -DVERSION=$(VERSION) xrobotmacrorec.cpp -o xrobotmacrorec -L/usr/X11R6/lib -lXtst -lX11

clean:
	rm xrobotmacroplay xrobotmacrorec
