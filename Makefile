all:
	zip	-r netherflood.zip *.lua shack/ tuto.png icon.png pixel.png sfx/
	mv netherflood.zip releases/netherflood.love

win32: all
	mkdir -p releases/win32
	cat releases/love-11.1.0-win32/love.exe releases/netherflood.love > releases/win32/netherflood.exe
	cp releases/love-11.1.0-win32/license.txt releases/love-11.1.0-win32/*.dll releases/win32/
	rm releases/netherflood_win32.zip
	zip	-r releases/netherflood_win32.zip releases/win32/

win64: all
	mkdir -p releases/win64
	cat releases/love-11.1.0-win64/love.exe releases/netherflood.love > releases/win64/netherflood.exe
	cp releases/love-11.1.0-win64/license.txt releases/love-11.1.0-win64/*.dll releases/win64/
	rm releases/netherflood_win64.zip
	zip	-r releases/netherflood_win64.zip releases/win64/
