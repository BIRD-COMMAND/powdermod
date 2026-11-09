@echo off

:: Isolate environment variables and enable command extensions
setlocal enableextensions

:: Force the current directory to be the folder containing this batch file
cd /d "%~dp0"

:: Initialize CLEAR_BUILT_TOOLS to 0
set "CLEAR_BUILT_TOOLS=0"

:: Set CLEAR_BUILT_TOOLS only if %1 is NOT empty
if not "%~1"=="" (
	:: Set CLEAR_BUILT_TOOLS only if the flag is one of the following: --all, all, -a
	if /I "%~1"=="--all" set "CLEAR_BUILT_TOOLS=1"
	if /I "%~1"=="all" set "CLEAR_BUILT_TOOLS=1"
	if /I "%~1"=="-a" set "CLEAR_BUILT_TOOLS=1"
)

echo Clearing generated files...
rmdir /s /q "port\windows\Release" 2>nul
rmdir /s /q "port\windows\Debug" 2>nul
del /q "credits.cpp" 2>nul
del /q "encyclopedia.cpp" 2>nul
del /q "encyclopedia.h" 2>nul
del /q "glbdef.cpp" 2>nul
del /q "glbdef.h" 2>nul
del /q "license.cpp" 2>nul
del /q "gfx\adambolt\alphabet_brass_8.c" 2>nul
del /q "gfx\adambolt\alphabet_classic_8.c" 2>nul
del /q "gfx\adambolt\alphabet_heavy_8.c" 2>nul
del /q "gfx\adambolt\alphabet_light_8.c" 2>nul
del /q "gfx\adambolt\alphabet_shadow_8.c" 2>nul
del /q "gfx\adambolt\dungeon16_16.c" 2>nul
del /q "gfx\adambolt\master.pal.c" 2>nul
del /q "gfx\adambolt\mini16_16.c" 2>nul
del /q "gfx\adambolt\minif16_16.c" 2>nul
del /q "gfx\adambolt\sprite.pal.c" 2>nul
del /q "gfx\adambolt\sprite16_16.c" 2>nul
del /q "gfx\akoi10\alphabet_brass_8.c" 2>nul
del /q "gfx\akoi10\alphabet_classic_8.c" 2>nul
del /q "gfx\akoi10\alphabet_heavy_8.c" 2>nul
del /q "gfx\akoi10\alphabet_light_8.c" 2>nul
del /q "gfx\akoi10\alphabet_shadow_8.c" 2>nul
del /q "gfx\akoi10\dungeon16_16.c" 2>nul
del /q "gfx\akoi10\master.pal.c" 2>nul
del /q "gfx\akoi10\mini16_16.c" 2>nul
del /q "gfx\akoi10\minif16_16.c" 2>nul
del /q "gfx\akoi10\sprite.pal.c" 2>nul
del /q "gfx\akoi10\sprite16_16.c" 2>nul
del /q "gfx\akoi12\alphabet_brass_8.c" 2>nul
del /q "gfx\akoi12\alphabet_classic_8.c" 2>nul
del /q "gfx\akoi12\alphabet_heavy_8.c" 2>nul
del /q "gfx\akoi12\alphabet_light_8.c" 2>nul
del /q "gfx\akoi12\alphabet_shadow_8.c" 2>nul
del /q "gfx\akoi12\dungeon16_16.c" 2>nul
del /q "gfx\akoi12\master.pal.c" 2>nul
del /q "gfx\akoi12\mini16_16.c" 2>nul
del /q "gfx\akoi12\minif16_16.c" 2>nul
del /q "gfx\akoi12\sprite.pal.c" 2>nul
del /q "gfx\akoi12\sprite16_16.c" 2>nul
del /q "gfx\akoi3x\sprite16_3x.bmp" 2>nul
del /q "gfx\akoi3x\sprite16_3x.bmp.c" 2>nul
del /q "gfx\akoimeexx\alphabet_brass_8.c" 2>nul
del /q "gfx\akoimeexx\alphabet_classic_8.c" 2>nul
del /q "gfx\akoimeexx\alphabet_heavy_8.c" 2>nul
del /q "gfx\akoimeexx\alphabet_light_8.c" 2>nul
del /q "gfx\akoimeexx\alphabet_shadow_8.c" 2>nul
del /q "gfx\akoimeexx\dungeon16_16.c" 2>nul
del /q "gfx\akoimeexx\master.pal.c" 2>nul
del /q "gfx\akoimeexx\mini16_16.c" 2>nul
del /q "gfx\akoimeexx\minif16_16.c" 2>nul
del /q "gfx\akoimeexx\sprite.pal.c" 2>nul
del /q "gfx\akoimeexx\sprite16_16.c" 2>nul
del /q "gfx\ascii\alphabet_brass_8.c" 2>nul
del /q "gfx\ascii\alphabet_classic_8.c" 2>nul
del /q "gfx\ascii\alphabet_heavy_8.c" 2>nul
del /q "gfx\ascii\alphabet_light_8.c" 2>nul
del /q "gfx\ascii\alphabet_shadow_8.c" 2>nul
del /q "gfx\ascii\dungeon16_16.c" 2>nul
del /q "gfx\ascii\master.pal.c" 2>nul
del /q "gfx\ascii\mini16_16.c" 2>nul
del /q "gfx\ascii\minif16_16.c" 2>nul
del /q "gfx\ascii\sprite.pal.c" 2>nul
del /q "gfx\ascii\sprite16_16.c" 2>nul
del /q "gfx\classic\alphabet_brass_8.c" 2>nul
del /q "gfx\classic\alphabet_classic_8.c" 2>nul
del /q "gfx\classic\alphabet_heavy_8.c" 2>nul
del /q "gfx\classic\alphabet_light_8.c" 2>nul
del /q "gfx\classic\alphabet_shadow_8.c" 2>nul
del /q "gfx\classic\dungeon16_16.c" 2>nul
del /q "gfx\classic\master.pal.c" 2>nul
del /q "gfx\classic\mini16_16.c" 2>nul
del /q "gfx\classic\minif16_16.c" 2>nul
del /q "gfx\classic\sprite.pal.c" 2>nul
del /q "gfx\classic\sprite16_16.c" 2>nul
del /q "gfx\distorted\alphabet_brass_8.c" 2>nul
del /q "gfx\distorted\alphabet_classic_8.c" 2>nul
del /q "gfx\distorted\alphabet_heavy_8.c" 2>nul
del /q "gfx\distorted\alphabet_light_8.c" 2>nul
del /q "gfx\distorted\alphabet_shadow_8.c" 2>nul
del /q "gfx\distorted\dungeon16_16.c" 2>nul
del /q "gfx\distorted\master.pal.c" 2>nul
del /q "gfx\distorted\mini16_16.c" 2>nul
del /q "gfx\distorted\minif16_16.c" 2>nul
del /q "gfx\distorted\sprite.pal.c" 2>nul
del /q "gfx\distorted\sprite16_16.c" 2>nul
del /q "gfx\ibsongrey\alphabet_brass_8.c" 2>nul
del /q "gfx\ibsongrey\alphabet_classic_8.c" 2>nul
del /q "gfx\ibsongrey\alphabet_heavy_8.c" 2>nul
del /q "gfx\ibsongrey\alphabet_light_8.c" 2>nul
del /q "gfx\ibsongrey\alphabet_shadow_8.c" 2>nul
del /q "gfx\ibsongrey\dungeon16_16.c" 2>nul
del /q "gfx\ibsongrey\master.pal.c" 2>nul
del /q "gfx\ibsongrey\mini16_16.c" 2>nul
del /q "gfx\ibsongrey\minif16_16.c" 2>nul
del /q "gfx\ibsongrey\sprite.pal.c" 2>nul
del /q "gfx\ibsongrey\sprite16_16.c" 2>nul
del /q "gfx\icon_sdl.bmp.c" 2>nul
del /q "gfx\lomaka\alphabet_brass_8.c" 2>nul
del /q "gfx\lomaka\alphabet_classic_8.c" 2>nul
del /q "gfx\lomaka\alphabet_heavy_8.c" 2>nul
del /q "gfx\lomaka\alphabet_light_8.c" 2>nul
del /q "gfx\lomaka\alphabet_shadow_8.c" 2>nul
del /q "gfx\lomaka\dungeon16_16.c" 2>nul
del /q "gfx\lomaka\master.pal.c" 2>nul
del /q "gfx\lomaka\mini16_16.c" 2>nul
del /q "gfx\lomaka\minif16_16.c" 2>nul
del /q "gfx\lomaka\sprite.pal.c" 2>nul
del /q "gfx\lomaka\sprite16_16.c" 2>nul
del /q "gfx\nethack\alphabet_brass_8.c" 2>nul
del /q "gfx\nethack\alphabet_classic_8.c" 2>nul
del /q "gfx\nethack\alphabet_heavy_8.c" 2>nul
del /q "gfx\nethack\alphabet_light_8.c" 2>nul
del /q "gfx\nethack\alphabet_shadow_8.c" 2>nul
del /q "gfx\nethack\dungeon16_16.c" 2>nul
del /q "gfx\nethack\master.pal.c" 2>nul
del /q "gfx\nethack\mini16_16.c" 2>nul
del /q "gfx\nethack\minif16_16.c" 2>nul
del /q "gfx\nethack\sprite.pal.c" 2>nul
del /q "gfx\nethack\sprite16_16.c" 2>nul
del /q "gfx\tridude_goodbye_hires.bmp.c" 2>nul
del /q "gfx\tridude_goodbye.bmp.c" 2>nul
del /q "rooms\allrooms.cpp" 2>nul
del /q "rooms\allrooms.h" 2>nul
del /q "rooms\belweir.cpp" 2>nul
del /q "rooms\circle.cpp" 2>nul
del /q "rooms\circle2.cpp" 2>nul
del /q "rooms\crypt.cpp" 2>nul
del /q "rooms\crypt2.cpp" 2>nul
del /q "rooms\crypt3.cpp" 2>nul
del /q "rooms\crypt4.cpp" 2>nul
del /q "rooms\crypt5.cpp" 2>nul
del /q "rooms\daemon1.cpp" 2>nul
del /q "rooms\daemon2.cpp" 2>nul
del /q "rooms\forest.cpp" 2>nul
del /q "rooms\forest2.cpp" 2>nul
del /q "rooms\hall.cpp" 2>nul
del /q "rooms\hall2.cpp" 2>nul
del /q "rooms\hauntedisle.cpp" 2>nul
del /q "rooms\hruth.cpp" 2>nul
del /q "rooms\isle.cpp" 2>nul
del /q "rooms\isle2.cpp" 2>nul
del /q "rooms\kiwi.cpp" 2>nul
del /q "rooms\klaskov.cpp" 2>nul
del /q "rooms\kobold_barrack.cpp" 2>nul
del /q "rooms\kobold_hideout.cpp" 2>nul
del /q "rooms\lair.cpp" 2>nul
del /q "rooms\lair2.cpp" 2>nul
del /q "rooms\lava.cpp" 2>nul
del /q "rooms\lava2.cpp" 2>nul
del /q "rooms\lava3.cpp" 2>nul
del /q "rooms\lava4.cpp" 2>nul
del /q "rooms\minotaur.cpp" 2>nul
del /q "rooms\orc_lair.cpp" 2>nul
del /q "rooms\orc_lair2.cpp" 2>nul
del /q "rooms\pillar.cpp" 2>nul
del /q "rooms\pillar2.cpp" 2>nul
del /q "rooms\pillar3.cpp" 2>nul
del /q "rooms\poison.cpp" 2>nul
del /q "rooms\quizar.cpp" 2>nul
del /q "rooms\ratwarren.cpp" 2>nul
del /q "rooms\ratwarren2.cpp" 2>nul
del /q "rooms\river.cpp" 2>nul
del /q "rooms\river2.cpp" 2>nul
del /q "rooms\secret.cpp" 2>nul
del /q "rooms\slug.cpp" 2>nul
del /q "rooms\slug2.cpp" 2>nul
del /q "rooms\sokoban.cpp" 2>nul
del /q "rooms\sokoban2.cpp" 2>nul
del /q "rooms\spiral.cpp" 2>nul
del /q "rooms\temple.cpp" 2>nul
del /q "rooms\temple2.cpp" 2>nul
del /q "rooms\triceratops.cpp" 2>nul
del /q "rooms\tridude.cpp" 2>nul
del /q "rooms\tridude2.cpp" 2>nul
del /q "rooms\tridude3.cpp" 2>nul
del /q "rooms\tridude4.cpp" 2>nul
del /q "rooms\troll.cpp" 2>nul
del /q "rooms\troll2.cpp" 2>nul
del /q "rooms\troll3.cpp" 2>nul
del /q "rooms\turtloid_pond.cpp" 2>nul
del /q "rooms\turtloid_pond2.cpp" 2>nul
del /q "rooms\tutorial.cpp" 2>nul
del /q "rooms\vault.cpp" 2>nul
del /q "rooms\vault2.cpp" 2>nul
del /q "rooms\vault3.cpp" 2>nul
del /q "rooms\vault4.cpp" 2>nul
del /q "rooms\why.cpp" 2>nul
del /q "rooms\zoo.cpp" 2>nul
del /q "rooms\zoo2.cpp" 2>nul
del /q "rooms\zoo3.cpp" 2>nul
del /q "rooms\zoo4.cpp" 2>nul
del /q "rooms\zoo5.cpp" 2>nul
echo Generated files cleared.

if "%CLEAR_BUILT_TOOLS%"=="1" (
	echo Clearing built tools...
	del /q "support\bmp2c\bmp2c.exe" 2>nul
	del /q "support\bmp2c\bmp2c.o" 2>nul
	del /q "support\bmp2c\stdafx.o" 2>nul
	del /q "support\encyclopedia2c\encyclopedia2c.exe" 2>nul
	del /q "support\encyclopedia2c\encyclopedia2c.o" 2>nul
	del /q "support\encyclopedia2c\stdafx.o" 2>nul
	del /q "support\enummaker\enummaker.o" 2>nul
	del /q "support\enummaker\StdAfx.o" 2>nul
	del /q "support\map2c\map2c.o" 2>nul
	del /q "support\map2c\stdafx.o" 2>nul
	del /q "support\tile2c\bmp.o" 2>nul
	del /q "support\tile2c\tile2c.exe" 2>nul
	del /q "support\tile2c\tile2c.o" 2>nul
	del /q "support\txt2c\StdAfx.o" 2>nul
	del /q "support\txt2c\txt2c.exe" 2>nul
	del /q "support\txt2c\txt2c.o" 2>nul
	echo Built tools cleared.
)

echo Task completed.

:: Exit the batch file
exit /b 0