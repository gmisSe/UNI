#Roblox
#Reverse
#External
#tool/ReClass 
#tool/CheatEngine  
#lua 

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
local name_Offset = 0x88
function findName(addr)
	return read_string(readPointer(addr + name_Offset))
end
---------------------------------------------------
className_Offset1 = 0x18
className_Offset2 = 0x8
function findClassName(addr)
	return read_string(readPointer(readPointer(addr + className_Offset1) + className_Offset2))
end
---------------------------------------------------
local children_Offset = 0x68
function findChildren(addr)
    if not addr then return {} end
    local childrenTablePtr = readPointer(addr + children_Offset)
    if not childrenTablePtr then return {} end
    local childrenStart_Address = readPointer(childrenTablePtr)
    local childrenEnd_Address = readPointer(childrenTablePtr + 0x8)
    if not childrenStart_Address or not childrenEnd_Address then return {} end
    local children = {}
    local indexMax = (childrenEnd_Address - childrenStart_Address) / 0x10

    for i = 0, indexMax - 1 do
        local e = readPointer(childrenStart_Address + i * 0x10)
        if e then
            table.insert(children, e)
        end
    end

    return children
end
--------------------------------------------------
function getAllChild(addr, parentPath)
    local results = {}
    local name = findName(addr) or "Unknown"
    
    -- Build current path
    local currentPath
    if parentPath ~= nil and parentPath ~= "" then
        currentPath = parentPath .. "/" .. name
    else
        currentPath = name
    end

    -- Get children
    local children = findChildren(addr)

    if #children == 0 then
        -- No more children -> leaf node
        table.insert(results, currentPath)
    else
        -- Recursively process each child
        for _, childAddr in ipairs(children) do
            local childResults = getAllChild(childAddr, currentPath)
            for _, path in ipairs(childResults) do
                table.insert(results, path)
            end
        end
    end
    return results
end

local allLeaves = getAllChild(dataModel_Address, "")
for _, path in ipairs(allLeaves) do
    print(path)
end
--------------------------------------------------
```

With this list of all the child we can simply retrieve their address with another function :

``` lua
function AddrPath(path)
	local addr = dataModel_Address
    for i, dir in ipairs(path) do
        local childList = findChildren(addr)
        for i, child in ipairs(childList) do
            if findName(child) == dir then
                addr = child
                print(findName(child))
                break
            end
        end
    end
    return addr
end

print(to_hex(AddrPath({"Workspace", "tiamv904", "Humanoid"})))
```
