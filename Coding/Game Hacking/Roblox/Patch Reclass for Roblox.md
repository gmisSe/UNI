#Roblox 
#tool/ReClass 
#tool/HxD 
#tool/ResoureHacker 
# 1- Remove the icon asset 
- open [[Resource Hacker]] as *admin*
- in [[Resource Hacker]] open *ReClass.NET* 
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

- `Search for: ReClass`
- inverse letters  
- `Reaplace with: CeRlass`
- set `Text encoding > Unicode(UTF-16 little endian)`
- Repeat the process with :
	- ReClass.NET