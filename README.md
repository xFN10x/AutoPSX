# AutoPSX
A simple way to make EBOOTS

[AutoPSX on GBATemp](https://gbatemp.net/threads/new-eboot-making-program.661196/)

### Features

 - Create M3Us right in the program
 - Barly any user input needed! 
 - No setup or bloatware!
 - No image editing nessecary

## So... how does it work?
AutoPSX uses a custom build of [PSXPackager](https://github.com/RupertAvery/PSXPackager), which fixes bugs that would occur in the program. AutoPSX runs its programs by command line. 
The programs it uses are:

 - [PSXPackager](https://github.com/RupertAvery/PSXPackager)
 - [ChdMan](https://github.com/charlesthobe/chdman)
 - [ImageMagick](https://github.com/ImageMagick)
(I DONT OWN ANY OF THESE PROGRAMS!!) 
The feature  ***- No image editing nessecary*** refers to how this program downloads the covers from this database

## Building (From Source)
*skip if you aren't a nerd... and if you arn't trying to build it...*

**To build the program from source,** you need [LuaRT](https://luart.org/index.html)
###### *(not to brag or anything... but i RUN AND OWN the [LuaRT discord server](https://discord.gg/WRwDMnQR4d).... you should join :) )*
### Instructions
After you get the [version of LuaRT that the program uses](https://github.com/samyeyo/LuaRT/releases/tag/v1.8.0), and install it, you need to head to where you installed it, and then get the following files: (in the /bin folder)

![files](https://github.com/xFN10x/AutoPSX/blob/main/doc/img/Screenshot%202024-09-28%20175755.png?raw=true)

Now copy them into here

![enter image description here](https://github.com/xFN10x/AutoPSX/blob/main/doc/img/Screenshot%202024-09-28%20175923.png?raw=true)

Also copy the dlls from these folders:

![enter image description here](https://github.com/xFN10x/AutoPSX/blob/main/doc/img/Screenshot%202024-09-28%20182629.png?raw=true)


Also into here:

![enter image description here](https://github.com/xFN10x/AutoPSX/blob/main/doc/img/Screenshot%202024-09-28%20183029.png?raw=true)


Now do the following command, (inside the directory)

    rtc.exe -w -lnet -ljson -i icon.ico main.wlua
***Now just launch main.exe!***
(Tip: you can also uninstall LuaRT by running the uninstall.)
