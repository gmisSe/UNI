#Requires AutoHotkey v2.0
#SingleInstance Force
SetMouseDelay(-1)
SendMode("Event")
global mouse := 0
global devorakOn := 1
global insertMode := 0
global normalMode := 0
global visualMode := 0

global vimProcesses := Map()
global previousDetected := ""
global textObjects := "p,w,s,[,(,{,<,`',`",``,b,B,t"

class Process {
    __New(name) {
        this.name := name
        this.insert := 0
        this.devorak := 0 
        this.normal := 1
        this.visual := 0
    }
}

for name in ["Code.exe", "devenv.exe", "Obsidian.exe", "nvim.exe"] {
    vimProcesses[name] := Process(name)
}

GetCurrentKeyboardLayout() {
    threadID := DllCall("GetWindowThreadProcessId", "ptr", WinActive("A"), "uint*", 0, "uint")
    hkl := DllCall("GetKeyboardLayout", "uint", threadID, "ptr")
    return Format("0x{:04X}", hkl & 0xFFFF)
}

modeCheck() {
    global previousDetected, insertMode, devorakOn, normalMode, visualMode
    try {
        activeProcess := WinGetProcessName("A")
    } 
    catch {
        return
    }

    if activeProcess = previousDetected
        return

    if vimProcesses.Has(previousDetected) {
        p := vimProcesses[previousDetected]
        p.insert := insertMode
        p.devorak := devorakOn
        p.normal := normalMode
        p.visual := visualMode
    }

    if vimProcesses.Has(activeProcess) {
        p := vimProcesses[activeProcess]
        insertMode := p.insert
        devorakOn := p.devorak
        normalMode := p.normal
        visualMode := p.visual
    }
    else {
        insertMode := 0
        devorakOn := 1
        normalMode := 0
        visualMode := 0
    }

    previousDetected := activeProcess
}

insertModeF(){
    global insertMode := 1
    global devorakOn := 1 
    global normalMode := 0
    global visualMode := 0
}

normalModeF(){
    global insertMode := 0
    global devorakOn := 0
    global normalMode := 1
    global visualMode := 0
}

visualModeF(){
    global insertMode := 0
    global devorakOn := 0
    global normalMode := 0
    global visualMode := 1
}


SetTimer(modeCheck, 50)
#HotIf (GetCurrentKeyboardLayout() = 0x0409)
RAlt & j::
{
    global mouse := 1
}

RAlt & q::
{
    global devorakOn := !devorakOn
}
#HotIf

#HotIf normalMode and !mouse 
#InputLevel 3
; Editing
~i::
{
    insertModeF()
}

~+i::
{
    insertModeF()
}

~a::
{
    insertModeF()
}

~+a::
{
    insertModeF()
}

~o::
{
    insertModeF()

}
~+o::
{
    insertModeF()
}

~s::
{
    insertModeF()
}

~+s::
{
    insertModeF()
}

~+c::
{
    insertModeF()
}

~r::
{
    insertModeF()
    ih := InputHook("L1 V")
    ih.Start()
    ih.Wait(6)
    normalModeF()
}

~+r::
{
    insertModeF()
}

; Enter Visual Mode
~v::
{
    visualModeF()
}

~+v::
{
    visualModeF()
}

; Navigation
~f::
{
    insertModeF()
    ih := InputHook("L1 V")
    ih.Start()
    ih.Wait(6)
    normalModeF()
}

~+f::
{
    insertModeF()
    ih := InputHook("L1 V")
    ih.Start()
    ih.Wait(6)
    normalModeF()
}

~t::
{
    insertModeF()
    ih := InputHook("L1 V")
    ih.Start()
    ih.Wait(6)
    normalModeF()
}

~+t::
{
    insertModeF()
    ih := InputHook("L1 V")
    ih.Start()
    ih.Wait(6)
    normalModeF()
}

; Operators
~c::
{
    global normalMode := 0
    ih := InputHook("V", textObjects)
    ih.Start()
    ih.Wait(2)
    ih.Stop()
    global normalMode := 1
    try if ih.EndReason = "EndKey"
        insertModeF()
}

~d::
{
    global normalMode := 0
    ih := InputHook("V", textObjects)
    ih.Start()
    ih.Wait(2)
    ih.Stop()
    global normalMode := 1
}

~y::
{
    global normalMode := 0
    ih := InputHook("V", textObjects)
    ih.Start()
    ih.Wait(2)
    ih.Stop()
    global normalMode := 1
}

~<::
{
    global normalMode := 0
    ih := InputHook("V", textObjects)
    ih.Start()
    ih.Wait(2)
    ih.Stop()
    global normalMode := 1
}

~>::
{
    global normalMode := 0
    ih := InputHook("V", textObjects)
    ih.Start()
    ih.Wait(2)
    ih.Stop()
    global normalMode := 1
}

~=::
{
    global normalMode := 0
    ih := InputHook("V", textObjects)
    ih.Start()
    ih.Wait(2)
    ih.Stop()
    global normalMode := 1
}

~g::
{
    global normalMode := 0
    ih := InputHook("V", textObjects "g")
    ih.Start()
    ih.Wait(2)
    ih.Stop()
    global normalMode := 1
}

; Folds and more
~z::
{
    global normalMode := 0
    ih := InputHook("V",, "z,t,b,f,d,a,o,c,r,m,i,Backspace")
    ih.Start()
    ih.Wait(2)
    ih.Stop()
    global normalMode := 1
}

; Enter Command mode
~<+SC027::
{
    #InputLevel 1
    insertModeF()
    ih := InputHook("V")
    ih.KeyOpt("{Enter}", "E")
    ih.Start()
    ih.Wait(40)
    normalModeF()
}
; Enter Search
~/::
{
    #InputLevel 1
    insertModeF()
    ih := InputHook("V")
    ih.KeyOpt("{Enter}", "E")
    ih.Start()
    ih.Wait(40)
    normalModeF()
}
#HotIf visualMode and !mouse 

#HotIf

#HotIf WinActive("ahk_exe Code.exe") or WinActive("ahk_exe devenv.exe") or WinActive("ahk_exe Obsidian.exe") or WinActive("ahk_exe nvim.exe")
~Esc::
{
    normalModeF()
}

~^c::
{
    normalModeF()
}

CapsLock::
{
    Send("{Escape}")
    normalModeF()
}
#HotIf 

#HotIf ((GetCurrentKeyboardLayout() = 0x0409) and devorakOn and !mouse)
#InputLevel 2
; -----------------------row 1-----------------------
; -----------------------row 2-----------------------
`::Send("$")  
1::Send("&")
2::Send("[")
3::Send("{{}")
4::Send("{}}")    
5::Send("(")
6::Send("=")
7::Send("*")
8::Send(")")
9::Send("{+}")
0::Send("]")         
-::Send("{!}")
=::Send("{#}")  

+`::SendText("~")
+1::Send("%")
+2::Send("7")
+3::Send("5")
+4::Send("3")
+5::Send("1")
+6::Send("9")
+7::Send("0")
+8::Send("2")
+9::Send("4")
+0::Send("6")
+-::Send("8")
+=::SendText("``")   
; -----------------------row 3-----------------------
q::Send(":")
w::Send(",")   
e::Send(".")
r::Send("p")
t::Send("y")
y::Send("f")
u::Send("g")
i::Send("c")
o::Send("r")
p::Send("l")       
[::Send("/")
]::SendText("^")
 
+q::Send(';')
+w::Send("<")          
+e::Send(">")
+r::Send("P")
+t::Send("Y")
+y::Send("F")
+u::Send("G")
+i::Send("C")
+o::Send("R")            
+p::Send("L")
+[::Send("?")
+]::Send("@")
; -----------------------row 4-----------------------
a::Send("a")
s::Send("o")
d::Send("e")
f::Send("u")             
g::Send("i")
h::Send("d")
j::Send("h")
k::Send("t")
l::Send("n")
SC027::Send("s")
'::Send("-")
SC02B::Send("\")

+a::Send("A")
+s::Send("O")
+d::Send("E")
+f::Send("U")
+g::Send("I")
+h::Send("D")
+j::Send("H")
+k::Send("T")
+l::Send("N")
+SC027::Send("S")
+'::Send("_")
+SC02B::Send("|")

RAlt & a::Send("é")
RAlt & s::Send("è")
RAlt & d::Send("à")
RAlt & f::Send("ç")
RAlt & g::Send("ù")
; -----------------------row 5-----------------------
SC056::Send("")
z::Send("'")
x::Send("q")
c::Send("j")
v::Send("k")
b::Send("x")
n::Send("b")
m::Send("m")
,::Send("w")
.::Send("v")
/::Send("z")

+SC056::Send("")
+z::Send('"')
+x::Send("Q")
+c::Send("J")
+v::Send("K")
+b::Send("X")
+n::Send("B")
+m::Send("M")
+,::Send("W")
+.::Send("V")
+/::Send('Z')
#HotIf

#HotIf ((GetCurrentKeyboardLayout() = 0x0409) and mouse) 
#InputLevel 2
q::
{
    global mouse := 0
}

v::Send("{LButton}")
n::Send("{RButton}")

a::
{
    while (GetKeyState("a","P")){
        Send("{WheelDown}")
        Sleep(100)
    }
}

SC027::
{
    while (GetKeyState("SC027","P")){
        Send("{WheelUp}")
        Sleep(100)
    }
}

g::
{
    if GetKeyState("LButton","P")
        Send("{LButton Up}")
    else
        Send("{LButton Down}")
}

h::
{
    if GetKeyState("RButton","P")
        Send("{RButton Up}")
    else
        Send("{RButton Down}")
}



e::
{
    while (GetKeyState("e", "P")) {
        MouseMove(0,-5,0,"R")
        Sleep(10.1)
    }
}

d::
{
    while (GetKeyState("d", "P")) {
        MouseMove(0,5,0,"R")
        Sleep(10.1)
    }
}

s::
{
    while (GetKeyState("s", "P")) {
        MouseMove(-5,0,0,"R")
        Sleep(10.1)
    }
}

f::
{
    while (GetKeyState("f", "P")) {
        MouseMove(5,0,0,"R")
        Sleep(10.1)
    }
}



i::
{
    moveDecrease("i",, -60,)
}

k::
{
    moveDecrease("k",, 60,)
}

j::
{
    moveDecrease("j", -60,,)
}

l::
{
    moveDecrease("l", 60,,)
}


moveDecrease(key,speed:=0,speed2:=0,delay:=10.1){
    val := speed
    val2 := speed2
    while (GetKeyState(key, "P")) {
        if !Mod(A_index,"3") and (Abs(val) > 15 or Abs(val2) > 15){
            if val > 0 {
                val -= 2
            }
            if val < 0 {
                val += 2
            }
            if val2 > 0 {
                val2 -= 4
            }
            if val2 < 0 {
                val2 += 4 
            }
        }
        MouseMove(val,val2,0,"R")
        Sleep(delay)
    }
}
#HotIf 