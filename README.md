<h1>those .obj and .exe is a must!</h1>

<p>if .asm is modified, run on x64 Native Tools Command Prompt Terminal:</p>

<p>-- this creates an object</p>
<p>"nasm -f win64 filename.asm -o filename.asm"</p>

<p>-- this links and creates an .exe</p>
<p>"link filename.obj kernel32.lib /subsystem:console /entry:main"</p>

<p>-- run</p>
<p>pfilename.exe</p>
