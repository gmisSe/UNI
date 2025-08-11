#Roblox
#Reverse
#External
#tool/IDA 
#tool/ReClass 
#tool/CheatEngine 
#tool/Vulkan 
#lua 
#Cpp
# If not done yet 
[[Patch Reclass for Roblox]]
[[Patch Cheat Engine for Roblox]]
# 1- Dump Roblox 

To be able to reverse roblox, we first need to dump it from the memory.
To do so we're gonna use a dumper called [[Vulkan]] :
- start roblox
- open cmd
- navigate to the dir of Vulkan executable 
- run the command : `vulkan.exe -p RobloxPlayerBeta.exe`
- join random games on roblox until the progress is above 50% 
- press ctrl + c 
You should be able to find your dump in the same folder as the vulkan executable

# 2- Find the Task scheduler offset in IDA

This offset is the base from where we'll be able to slowly progress to the DataModel, to find it we're gonna use a [[Disassembler]] named [[IDA]] :
- Load the roblox dump in IDA 
- Wait until "idle" is displayed in the bottom left corner
- go to `view > open subviews > strings` or do `shift + F12`
- search for the string *"AnimatorParallelManagerTaskQueue"* (`ctrl + f`)

![[idastring.png|608x118]]

- double click on it 
- press x on *"aAnimatorparall"* 

![[xrefto.png|583x181]]

- click `ok` 
- right click then select `Text view`

![[textview.png|375x225]]

- rebase the program `Edit > Segments > Rebase Program`

![[rebase.png|365x103]]

- set `value > 0x0`

![[rebane2.png|161x214]]

- Look for this structure : 

![[offsettaskscheduler.png|510x97]]

You now have your *Task scheduler offset* 
``` lua title:taskSchedulerOffset.lua
taskScheduler_static = 0x6F55718
```

# 3- Find DataModel from the task scheduler

In this part we're gonna need [[Cheat Engine]] and [[ReClass]] to navigate to the datamodel
- start Roblox, Cheat Engine and ReClass
- open Roblox in Cheat Engine and ReClass
- in Cheat Engine open Memory View
- in Memory View open `Tools > Lua Engine` (`ctrl + L`) 
- *to create a new class in ReClass, right click class*
Here is a list of function we'll use : 
``` lua
---------------------------------------------------
local function to_hex(num)
    if num == nil then return "" end
    return string.format("0x%X", num)
end

local function read_string(address)
    local str_length = readInteger(address + 0x18)
    if str_length >= 16 then
        local str_ptr = readPointer(address)
        return readString(str_ptr)
    else
        return readString(address)
    end
end
---------------------------------------------------
```
Other function used are Cheat Engine / Lua integrated functions 
## A ) Find | Task scheduler ---> Job | Offset 

- first we need to navigate to the Task scheduler address, to do so we add the Task scheduler *offset* to the base address of Roblox :
``` lua
local base = getAddress("RobloxPlayerBeta.exe")
local taskScheduler_Offset = 0x6F55718
local taskScheduler_Address = base + taskScheduler_Offset
print("taskScheduler_Address")
print(to_hex(taskScheduler_Address))
```

- Create a new class with the returned value (make sure to remove the 0x or it will crash)
- Name the class TaskSheduler

![[Getting to Roblox DataModel-1754887432936.png|457x110]]

- Right click on the class then add bytes to expand it 
- Now look through all the HEAP addresses until you find one that leads to a huge list of HEAP addresses :

![[Getting to Roblox DataModel-1754888547567.png]]

- Note it's Offset 

![[Getting to Roblox DataModel-1754888621611.png]]

``` lua
local job_Offset = 0x1E8
local job_Address = readPointer(taskScheduler_Address + job_Offset)
print("job_Address")
print(to_hex(job_Address))
```

## B ) Find | Job ---> RenderJob | Offset

If you check these HEAP addresses, you will find some "Jobs" :

![[Getting to Roblox DataModel-1754891907000.png]]

![[Getting to Roblox DataModel-1754891928160.png]]

if we note these job addresses down, we start to see a pattern :

![[Getting to Roblox DataModel-1754891804987.png]]
the jobs at 0x30 are always the same as the job on the previous job at 0x18
jobs at 0x18 are consistent while the copy at 0x30 can be missing
so we'll look for the 0x18 jobs only

they all seem to appear in a pointer at a multiple of 16 bytes from the job address, so will only check these pointers at their offset 0x18 for job names until we find the *RenderJob*

``` lua
function findRenderJob() 
	local jobName = ""
	local index = 0
	while (jobName ~= "RenderJob") do
		index = index + 1
		jobName = readString(readPointer(job_Address + index*0x10) + 0x18,9)
	end
	return readPointer(job_Address + index*0x10)
end
renderJob_Address = findRenderJob()
print("renderJob_Address")
print(to_hex(renderJob_Address))
```


## C ) Find | RenderJob --->  Fake DataModel | Offset

First we need to get to the *Fake DataModel*
To do so from RenderJob, check every HEAP for DATA, then check if this DATA is followed by `RBX::DataModel` like this : `<DATA>RobloxPlayerBeta.exe.7FF686705EC8 RBX::DataModel :`

![[Getting to Roblox DataModel-1754900732453.png]]
2nd HEAP of this pattern should be the Fake DataModel 
- note it's offset
``` lua
local fakeDataModel_Offset = 0x208
local fakeDataModel_Address = readPointer(fakeDataModel_Offset + renderJob_Address)
print("fakeDataModel_Address")
print(to_hex(fakeDataModel_Address))
```

## D ) Find | Fake DataModel ---> DataModel | Offset

We simply have to repeat the same process as the previous step, check all the HEAP for`<DATA>RobloxPlayerBeta.exe.7FF686705EC8 RBX::DataModel :`

![[Getting to Roblox DataModel-1754903781729.png]]
2nd HEAP of this pattern should be the DataModel 
- note it's offset 
``` lua
local dataModel_Offset = 0x1C0
local dataModel_Address = readPointer(dataModel_Offset + fakeDataModel_Address)
print("dataModel_Address")
print(to_hex(dataModel_Address))
```


# Final script 

``` lua
--------------------Functions----------------------
local function to_hex(num)
    if num == nil then return "" end
    return string.format("0x%X", num)
end

local function read_string(address)
    local str_length = readInteger(address + 0x18)
    if str_length >= 16 then
        local str_ptr = readPointer(address)
        return readString(str_ptr)
    else
        return readString(address)
    end
end
---------------------------------------------------
local base = getAddress("RobloxPlayerBeta.exe")
local taskScheduler_Offset = 0x6F55718
local taskScheduler_Address = base + taskScheduler_Offset
print("taskScheduler_Address")
print(to_hex(taskScheduler_Address))
---------------------------------------------------
local job_Offset = 0x1E8
local job_Address = readPointer(taskScheduler_Address + job_Offset)
print("job_Address")
print(to_hex(job_Address))
---------------------------------------------------
function findRenderJob() 
	local jobName = ""
	local index = 0
	while (jobName ~= "RenderJob") do
		index = index + 1
		jobName = readString(readPointer(job_Address + index*0x10) + 0x18,9)
	end
	return readPointer(job_Address + index*0x10)
end
renderJob_Address = findRenderJob()
print("renderJob_Address")
print(to_hex(renderJob_Address))
---------------------------------------------------
local fakeDataModel_Offset = 0x208
local fakeDataModel_Address = readPointer(fakeDataModel_Offset + renderJob_Address)
print("fakeDataModel_Address")
print(to_hex(fakeDataModel_Address))
---------------------------------------------------
local dataModel_Offset = 0x1C0
local dataModel_Address = readPointer(dataModel_Offset + fakeDataModel_Address)
print("dataModel_Address")
print(to_hex(dataModel_Address))
---------------------------------------------------
```
