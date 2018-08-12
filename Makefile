all:
	zip	-r jam.zip *.lua shack/ pixel.png
	mv jam.zip releases/jam.love

win32: all
	mkdir -p releases/win32
	cat releases/love-11.1.0-win32/love.exe releases/jam.love > releases/win32/42.exe
	cp releases/love-11.1.0-win32/license.txt releases/love-11.1.0-win32/*.dll releases/win32/

win64: all
	mkdir -p releases/win64
	cat releases/love-11.1.0-win64/love.exe releases/jam.love > releases/win64/42.exe
	cp releases/love-11.1.0-win64/license.txt releases/love-11.1.0-win64/*.dll releases/win64/
