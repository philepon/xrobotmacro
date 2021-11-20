# xrobotmacro
A X11 Mouse/Keyboard recorder/playback tool. This basically does the same thing as TinyTask or GhostMouse on Windows. AFAIK, this is the only automatic mouse/keyboard recorder program that works on Linux (automatic meaning that you don't have to specify delays, coordinates, or keys manually).

This program does not work on Wayland. XWayland should work fine.

`xrobotmacro` is almost completely based on `xmacro`. I just modified it so that the delay between each mouse/keyboard event can be recorded and played back. For previous `xmacro` users, note that it is no longer necessary (and not recommended) to specify a manual delay between keyboard/mouse events, although the option is still available. However, note that specifying a manual delay will prepend that delay before the playback of every event. Delays that are read from stdin will not be affected and will be played back as normal.

Compiling
---------
Run the included makefile. You will need to have `libxtst-dev` (Ubuntu) or `libXtst-devel` (Fedora) installed.

Usage
-----
The usage of `xrobotmacro` is identical to `xmacro`. `xrobotmacrorec` records mouse and keyboard events and prints them to stdout, while `xrobotmacroplay` takes mouse and keyboard events as text from stdin, parses them, and plays them back.

An easy way to use `xrobotmacrorec` would be to use bash to redirect the output to a file.

__Recording:__

	xrobotmacrorec >> [outputFile]
	
Example:
	
	xrobotmacrorec >> recordFile.txt
	
At the start of recording you must select a key to command `xrobotmacrorec` to stop recording. This key can be selected when starting `xrobotmacrorec` or as an argument with the `-k` flag.

It is not recommended to stop `xrobotmacrorec` within the terminal with `Ctrl-C`, as the combination will be saved to the output file and executed during playback. You can manually open the recorded file and delete those lines if you used `Ctrl-C` on accident.

__Playback:__

Input can be redirected from a file into xrobotmacroplay:

	xrobotmacroplay [display] < [outputFile]
	
Example:

	xrobotmacroplay :0 < recordFile.txt

__Known Quirks:__

The format of the output is not optimized for storage, and thus the file size can grow quite large for extended recordings. This can be changed in the future if it becomes a major inconvenience.

I don't know whether redirecting the output to a file in bash is a speed bottleneck. If it becomes an issue manual file output functionality can be added later.

Note that `xrobotmacrorec` may record multiple events where only a single event would suffice. E.g. consecutive mouse move events with the same coordinates, or consecutive keyboard events resulting from holding down a key. This is completely intentional and not a bug. AFAIK, these superflous events are reported to X11 during real human input, and since simulating human input is one of the primary goals of `xrobotmacro`, this is the desired behavior.

__Known bugs:__

When pressing and holding a key, `xrobotmacrorec` does not pick up on or send the instant keyup events. This should not be a problem though, as those events seem to be recreated by X11 during playback. 

`xrobotmacro` uses the deprecated X11 function XKeysymToString. I think it has something to do with mapping keycodes to their expected keyboard keys, or vise-versa. Problems might occur when using keyboards with non-English layouts, or even English keyboards with a different layout.

__FAQ:__

Why do I get a `Skipping stale KeyRelease event` message right after the recording starts?
The first time this message appears whenever you start xrobotmacroplay is normal and can be ignored.


__Licencing:__

	xrobotmacro is licensed under GPLv2.
	The original xmacro is written by Gabor Keresztfalvi and licensed under GPLv2 or any later version. 
