SetCapsLockState('AlwaysOff')

; Capslock as Escape
Capslock::Escape

; Main Navigation
CAPSLOCK & j::SendKey("{DOWN}")
CAPSLOCK & l::SendKey("{RIGHT}")
CAPSLOCK & k::SendKey("{UP}")
CAPSLOCK & h::SendKey("{LEFT}")
CAPSLOCK & u::SendKey("{PGUP}")
CAPSLOCK & p::SendKey("{PGDN}")
CAPSLOCK & i::SendKey("{HOME}")
CAPSLOCK & o::SendKey("{END}")
CAPSLOCK & n::SendKey("{BACKSPACE}")
CAPSLOCK & m::SendKey("{DELETE}")
 
; Navigation Combos
SendKey(myKey) {
    shift := GetKeyState("SHIFT","P")
    control := GetKeyState("CONTROL","P") || GetKeyState("ALT", "P")
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
