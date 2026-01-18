those .obj and .exe is a must!

if .asm is modified, run on x64 Native Tools Command Prompt Terminal:

-- this creates an object
"nasm -f win64 filename.asm -o filename.asm"

-- this links and creates an .exe
link filename.obj kernel32.lib /subsystem:console /entry:main

-- run
filename.exe
