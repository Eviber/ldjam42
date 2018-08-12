all:
	zip	-r jam.zip *.lua shack/ pixel.png
	mv jam.zip releases/jam.love

win32: all
	cat releases/love32.exe releases/jam.love > releases/jam32.exe

win64: all
	cat releases/love64.exe releases/jam.love > releases/jam64.exe
