
I wanna make a function to be able to index all the existing children of DataModel 

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
---------------------------------------------------
local job_Offset = 0x1E8
local job_Address = readPointer(taskScheduler_Address + job_Offset)
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
---------------------------------------------------
local fakeDataModel_Offset = 0x208
local fakeDataModel_Address = readPointer(fakeDataModel_Offset + renderJob_Address)
---------------------------------------------------
local dataModel_Offset = 0x1C0
local dataModel_Address = readPointer(dataModel_Offset + fakeDataModel_Address)
---------------------------------------------------
local children_Offset = 0x68
function findChildren(addr)
	local childrenStart_Address = readPointer(readPointer(addr + children_Offset))
	print(to_hex(childrenStart_Address))
	local childrenEnd_Address = readPointer(readPointer(addr + children_Offset) + 0x8)
	print(to_hex(childrenEnd_Address))
	local index = 0
    local e = 0
    local children = {}
    local indexMax = (childrenEnd_Address - childrenStart_Address)/0x10
    while (index < indexMax) do
        e = ReadPointer(childrenStart_Address + index*0x10)
        index = index + 1
        children[index] = e
    end
    return children
end
--------------------------------------------------


```
