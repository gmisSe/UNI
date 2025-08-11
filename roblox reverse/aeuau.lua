--[[
To find the datamodel we must complete this structure.

local baseaddress = getAddress("RobloxPlayerBeta")
local taskscheduler = baseaddress + taskscheduler_static
local tasksaddr = readPointer(taskscheduler + taskstart_static)
then you must do a loop through each task and check if the name is equal to "RenderJob(EarlyRendering;Ugc)"
If it is then the task that we are currently on is the renderjob
Find the fake datamodel in reclass
go to the pointer stored in that address
find the real datamodel
]]

--[[
to find this we dump roblox with vulkan
open dump in ida
rebase dump to 0x0
search string for AnimatorParallelManagerTaskQueue in ida
xref it and look for instructions like these:
cs:off_6F55720, rax
lea     rcx, dword_6F55718 ; Task Scheduler addr
call    sub_46B9A3C
and 0x6F55718 is our taskscheduler static offset
]]
local taskscheduler_static = 0x6F55718
--[[
we get taskscheduler by adding the base address + the static offset for taskscheduler
open up the taskscheduler address in reclass and look for a pointer to the heap with a bunch of pointers at its address
our taskstart is 
]]
local taskstart_static = 0x1E8
--[[
look at the pointers to the jobs and find out where the string to it usually starts in the jobs
you will get some garbage results
]]
local jobstringstart = 0x150
--[[
look for something under the renderjob task that we found that points to an address which 0x0 0x8 and 0x10 point to the data segment with rbxdatamodel
just look through them manually if needed u will figure it out
]]
local renderjob_to_fakedatamodel =0x208
--[[
it will be literally right under something that points to data rbx datamodel and points to a heap address
in that heap address ytou will find that 0x0 points to a data segment of rbx::datamodel
and to be sure there will be a guid somewhere
]]
local fakedatamodel_to_datamodel = 0x1C0
--[[
the name of our renderjob after we check the string of a job
]]
local renderjob_string = "RenderJob(EarlyRendering;Ugc)" 

local children_offset                    = 0x68
local children_end_offset                = 0x8
local classname_offset                   = 0x18
local name_offset                        = 0x88

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

local base = getAddress("RobloxPlayerBeta.exe")
print("base")
print(to_hex(base))

local taskscheduler = taskscheduler_static + base
print("taskscheduler")
print(to_hex(taskscheduler))

local taskstart = taskscheduler + taskstart_static
print("taskstart")
print(to_hex(taskstart))

local jobstart = ReadPointer(taskstart)
print("jobstart")
print(to_hex(jobstart))




function findRenderJob() 
    local njob = 0
    local jobname = ""
    local jobaddr = 0
    while (jobname ~= "RenderJob")
    do
        jobaddr = ReadPointer(jobstart + 0x8*njob) + 0x150
        jobname = ReadString(jobaddr,9)
        njob = njob + 1
    end
    return jobaddr - 0x150
end

print(to_hex(findRenderJob()))


function findServerIP()
    local ipoffset1 = 0x38
    local ipoffset2 = 0x7f8
    local renderjob = to_hex(findRenderJob())

    local asuahua = readPointer(renderjob + ipoffset1)
    local aueauaua = readPointer(asuahua + ipoffset2)
    local ip = readString(aueauaua)
    return ip
end

print(findServerIP())


function FindDataModel()
    local renderjob = findRenderJob()
    return readPointer(fakedatamodel_to_datamodel + readPointer(findRenderJob() + renderjob_to_fakedatamodel))
end

print(to_hex(FindDataModel()))

function FindClassName(addr)
    return read_string(ReadPointer(ReadPointer(addr + classname_offset) + 0x8))
end

print(FindClassName(FindDataModel()))

function FindName(addr)
    return read_string(ReadPointer(addr + name_offset))
end

print(FindName(FindDataModel()))

function FindChildren(addr)
    local start = ReadPointer(ReadPointer(addr + children_offset))
    local cEnd = ReadPointer(ReadPointer(addr + children_offset) + 0x8)
    local index = 0
    local e = 0
    local children = {}
    local indexMax = (cEnd - start)/0x10
    while (index < indexMax) do
        e = ReadPointer(start + index*0x10)
        index = index + 1
        children[index] = e
    end
    return children
end

local Datamodel = {
    adr = FindDataModel(),
    Classname = FindClassName(FindDataModel()),
    name = FindName(FindDataModel()),
    children = FindChildren(FindDataModel()),
}

function AddrPath(path)
    local addr = Datamodel.adr
    for i, dir in ipairs(path) do
        local childList = FindChildren(addr)
        for i, child in ipairs(childList) do
            if FindName(child) == dir then
                addr = child
                print(FindName(child))
                break
            end
        end
    end
    return addr
end

print(to_hex(AddrPath({"Workspace", "tiamv904", "Humanoid"})))
