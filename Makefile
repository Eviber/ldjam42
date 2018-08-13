all:
	zip	-r fractab.zip *.lua shack/ pixel.png sfx/
	mv fractab.zip releases/fractab.love

win32: all
	mkdir -p releases/win32
	cat releases/love-11.1.0-win32/love.exe releases/fractab.love > releases/win32/fractab.exe
	cp releases/love-11.1.0-win32/license.txt releases/love-11.1.0-win32/*.dll releases/win32/
	zip	-r releases/fractab_win32 releases/win32/

win64: all
	mkdir -p releases/win64
	cat releases/love-11.1.0-win64/love.exe releases/fractab.love > releases/win64/fractab.exe
	cp releases/love-11.1.0-win64/license.txt releases/love-11.1.0-win64/*.dll releases/win64/
	zip	-r releases/fractab_win64.zip releases/win64/
