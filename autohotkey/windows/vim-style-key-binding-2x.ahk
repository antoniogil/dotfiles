
; Main Navigation
CAPSLOCK & j::MoveCursor("{DOWN}")
CAPSLOCK & l::MoveCursor("{RIGHT}")
CAPSLOCK & k::MoveCursor("{UP}")
CAPSLOCK & h::MoveCursor("{LEFT}")
 
; Navigation Combos
MoveCursor(myKey) {
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