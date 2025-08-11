In this note we'll see how to get DataModel's *children*, *class name* and *name*.
And then apply the same things with the children. 

# 1- Find children, class name and name address

Navigate to DataModel's address

## A ) Find | DataModel ---> name | Offset

Read through the HEAP addresses until you find the *name* of the DataModel which is *"Ugc"* 
![[Navigate through children from DataModel-1754921785934 1.png]]
- note the offset 

``` lua
local name_Offset = 0x88
function findName(addr)
	return read_string(readPointer(addr + name_Offset))
end
print("dataModel_name")
print(findName(dataModel_Address))
```

## B ) Find | DataModel ---> class name | Offset

Read through the HEAP addresses until you find the *class name* of the DataModel which remains *"DataModel"* 
![[Navigate through children from DataModel-1754923439300 1.png]]

We can see that it's offset by `0x8` from the pointer we just read, there is actually 2 Offset here 

``` lua
className_Offset1 = 0x18
className_Offset2 = 0x8
function findClassName(addr)
	return read_string(readPointer(readPointer(addr + className_Offset1) + className_Offset2))
end

print("dataModel_ClassName")
print(findClassName(dataModel_Address))
```

## C ) Find | DataModel --> children | Offset

Read through the HEAP until you find one that points to a HEAP that point to a huge amount of HEAP

First HEAP points to second 
![[Navigate through children from DataModel-1754924787612 1.png]]

Second HEAP points to a list of HEAP 
![[Navigate through children from DataModel-1754924874836 1.png]]

You can confirm by checking some of those to see if they include name of children of DataModel.

As you can see the first one leads to Workspace 
![[Navigate through children from DataModel-1754925348488 1.png]]

When checking for child, we see that not all of those HEAP leads to a child, but only one every 2 HEAP, we need to consider this while making our function which will return an array of children 

We can also see that this list of children ends at the address given by the HEAP that follows the HEAP that leads to the children

This means that actually the first one leads to the start of the list, and the second one to the end of the list
![[Navigate through children from DataModel-1754924787612 1.png]]

With all these information we can now make our function :

``` lua
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
print("dataModel_Children")
for i, child in ipairs(findChildren(dataModel_Address)) do
	print(findName(child))
end
```
 