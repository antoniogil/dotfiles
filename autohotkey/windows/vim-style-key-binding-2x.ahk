SetCapsLockState('AlwaysOff')

; Main Navigation
CAPSLOCK & j::SendKey("{DOWN}")
CAPSLOCK & l::SendKey("{RIGHT}")
CAPSLOCK & k::SendKey("{UP}")
CAPSLOCK & h::SendKey("{LEFT}")
CAPSLOCK & i::SendKey("{PGUP}")
CAPSLOCK & o::SendKey("{PGDN}")
CAPSLOCK & u::SendKey("{HOME}")
CAPSLOCK & p::SendKey("{END}")
CAPSLOCK & n::SendKey("{BACKSPACE}")
CAPSLOCK & m::SendKey("{DELETE}")
 
; Navigation Combos
SendKey(myKey) {
    shift := GetKeyState("SHIFT","P")
    control := GetKeyState("CONTROL","P")
    controlShift := control && shift
 
    if controlShift {
        Send "^+" myKey
    }
    else if shift {
        Send "+" myKey
    }
    else if control {
        Send "^" myKey
    }
    else {
        Send myKey
    }
}