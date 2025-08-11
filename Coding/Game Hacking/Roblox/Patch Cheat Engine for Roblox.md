#Roblox 
#tool/CheatEngine 
#tool/HxD 
#tool/ResoureHacker 
# 1- Remove the icon asset 
- open [[Resource Hacker]] as *admin*
- in [[Resource Hacker]] open *cheatengine-x86_64.exe* which you can find in `C:\Program Files\Cheat Engine` 
- delete it's *icon*
- *save as* a different name than the original
# 2- Modify specific strings
## A )

- open [[HxD]] as *admin*
- in [[HxD]] open the previously made iconless.exe file 
- go to `search > Replace`
![[image.png|279x230]]
- set `search direction > All`
- set `Option > Case sensitive`
## B ) 

- `Search for: Cheat Engine`
- inverse letters  
- `Reaplace with: Eheat Cngine`
- Repeat the process with :
	- CheatEngine
	- cheat engine
	- cheatengine
	- Dark Byte
	- DarkByte
	- dark byte
	- darkbyte
	- 00007fffffffffff
