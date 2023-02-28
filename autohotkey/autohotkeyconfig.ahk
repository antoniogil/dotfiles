
; CapsLock always off
;---------------------------------------------------------------------o
SetCapsLockState, AlwaysOff



; CapsLock Switcher
;---------------------------------o-----------------------------------o
CapsLock & `::   
GetKeyState, CapsLockState, CapsLock, T   
if CapsLockState = D  
    SetCapsLockState, AlwaysOff
else  
    SetCapsLockState, AlwaysOn 
KeyWait, ``
return



; CapsLock Escaper:
;----------------------------------o----------------------------------o
CapsLock::Send, {ESC} 


; CapsLock Direction Navigator (LEFT) 
;-----------------------------------o---------------------------------o

CapsLock & h::   
if GetKeyState("control") = 0  
{
    if GetKeyState("alt") = 0  
   Send, {Left}  
    else   
   Send, +{Left} 
    return 
}
else 
{
    if GetKeyState("alt") = 0  
   Send, ^{Left} 
    else   
   Send, +^{Left}
    return 
}
return   

; CaspLock Direction Navigator (Down)
;-----------------------------------o---------------------------------o
CapsLock & j::   
if GetKeyState("control") = 0  
{
    if GetKeyState("alt") = 0  
   Send, {Down}  
    else   
   Send, +{Down} 
    return 
}
else {
    if GetKeyState("alt") = 0  
   Send, ^{Down} 
    else   
   Send, +^{Down}
    return 
}
return  

; CapsLock Direction Navigator (Up)
;-----------------------------------o---------------------------------o
CapsLock & k::   
if GetKeyState("control") = 0  
{
    if GetKeyState("alt") = 0  
   Send, {Up}    
    else   
   Send, +{Up}   
    return 
}
else {
    if GetKeyState("alt") = 0  
   Send, ^{Up}   
    else   
   Send, +^{Up}  
    return 
}
return 

;CapsLock Direction Navigator (Right)
;-----------------------------------o---------------------------------o  
CapsLock & l::   
if GetKeyState("control") = 0  
{
    if GetKeyState("alt") = 0  
   Send, {Right} 
    else   
   Send, +{Right}
    return 
}
else {
    if GetKeyState("alt") = 0  
   Send, ^{Right}
    else   
   Send, +^{Right}  
    return 
}
return


; CapsLock Home/End Navigator (Home)    
;-----------------------------------o---------------------------------o
CapsLock & i::   
if GetKeyState("control") = 0  
{
    if GetKeyState("alt") = 0  
   Send, {Home}  
    else   
   Send, +{Home} 
    return 
}
else {
    if GetKeyState("alt") = 0  
   Send, ^{Home} 
    else   
   Send, +^{Home}
    return 
}
return 

; CapsLock Home/End Navigator (End)
;-----------------------------------o---------------------------------o
CapsLock & o::   
if GetKeyState("control") = 0  
{
    if GetKeyState("alt") = 0  
   Send, {End}   
    else   
   Send, +{End}  
    return 
}
else {
    if GetKeyState("alt") = 0  
   Send, ^{End}  
    else   
   Send, +^{End} 
    return 
}
return  

; CapsLock Page Navigator (PageUp)  
;-----------------------------------o---------------------------------o
CapsLock & u::   
if GetKeyState("control") = 0  
{
    if GetKeyState("alt") = 0  
   Send, {PgUp}  
    else   
   Send, +{PgUp} 
    return 
}
else {
    if GetKeyState("alt") = 0  
   Send, ^{PgUp} 
    else   
   Send, +^{PgUp}
    return 
}
return  

; CapsLock Page Navigator (PageDown)  
;-----------------------------------o---------------------------------o
CapsLock & p::   
if GetKeyState("control") = 0  
{
    if GetKeyState("alt") = 0  
   Send, {PgDn}  
    else   
   Send, +{PgDn} 
    return 
}
else {
    if GetKeyState("alt") = 0  
   Send, ^{PgDn} 
    else   
   Send, +^{PgDn}
    return 
}
return



; CapsLock Deletor    
;-----------------------------------o---------------------------------o
CapsLock & ,:: Send, {Del}
CapsLock & .:: Send, ^{Del}    
CapsLock & m:: Send, {BS}
CapsLock & n:: Send, ^{BS}


;Function Key Emulator    
;-----------------------------------o---------------------------------o
LAlt & 2:: Send !{F2}

LAlt & 4:: Send !{F4}
Ctrl & 4:: Send ^{F4}

CapsLock & 5:: Send {F5}

CapsLock & 7:: Send {F7}

CapsLock & 8:: Send {F8}

CapsLock & 0:: Send {F10}

CapsLock & ':: Send {F11}

CapsLock & ¡:: Send !{F12}

;Other functions
;---------------------------------------------------------------------o
RAlt & Esc:: Send {\}
