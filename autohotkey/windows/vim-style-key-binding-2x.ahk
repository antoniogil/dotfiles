#Requires AutoHotkey v2.0

InitOverlay()
SetCapsLockState "AlwaysOff"
global capsHeld := false
global capsUsed := false
global fkeysEnabled := false

; =========================
; CAPLOCK TAP vs HOLD
; =========================

*CapsLock::
{
    global capsHeld
    global capsUsed

    capsUsed := false

    ; Espera a ver si se mantiene pulsado
    if !KeyWait("CapsLock", "T0.2")  ; 200 ms
    {
        ; HOLD
        capsHeld := true
	; TurnCapsLED(true)
        ; ShowIndicator("Modo NORMAL / NAV")
	ShowOverlay()

        ; Espera a que se suelte
        KeyWait("CapsLock")

        capsHeld := false
	; TurnCapsLED(false)
        ; HideIndicator()
	HideOverlay()
    }
    else
    {
        ; TAP
        if (!capsUsed)
        {
            Send("{Esc}")
        }
    }
}

; =========================
; INDICADOR
; =========================

ShowIndicator(text)
{
    ToolTip(text, 10, 10)
}

HideIndicator()
{
    ToolTip()
}

;==========================
; TurnCapsLED
;==========================
TurnCapsLED(on := true)
{
	if (on)
		SetCapsLockState "AlwaysOn"
	else
		SetCapsLockState "AlwaysOff"
}

;==========================
; Overlay
;==========================
InitOverlay()
{
    global overlayGui
    global overlayText

    overlayGui := Gui("+AlwaysOnTop -Caption +ToolWindow +E0x20")
    overlayGui.BackColor := "000000"

    ; Fuente (tamaño + color)
    overlayGui.SetFont("s14", "Segoe UI")
    overlayGui.SetFont("cFFFFFF")

    overlayText := overlayGui.AddText("Center", "NORMAL / NAV MODE")

    WinSetTransparent(180, overlayGui.Hwnd)
}

ShowOverlay(text := "NORMAL / NAV MODE")
{
    global overlayGui, overlayText

    overlayText.Value := text

    ; Centrado horizontalmente, parte superior de la pantalla
    screenCenterX := (A_ScreenWidth / 2) - 150
    screenCenterY := 40

    overlayGui.Show("x" screenCenterX " y" screenCenterY " NoActivate")
}

HideOverlay()
{
    global overlayGui
    overlayGui.Hide()
}

; =========================
; TOGGLE F-KEYS HOTKEY
; =========================

#+F::
{
    global fkeysEnabled
    fkeysEnabled := !fkeysEnabled
    
    if (fkeysEnabled)
    {
        ShowOverlay("60% KEYBOARD MODE")
    }
    else
    {
        ShowOverlay("FULL KEYBOARD MODE")
    }
    
    SetTimer(() => HideOverlay(), 2000)
}

; =========================
; F-KEYS (DEFAULT) - sin modificadores
; =========================

#HotIf (!capsHeld && fkeysEnabled)

;º::Send("{F1}")
1::Send("{Blind}{F1}")
2::Send("{Blind}{F2}")
3::Send("{Blind}{F3}")
4::Send("{Blind}{F4}")
5::Send("{Blind}{F5}")
6::Send("{Blind}{F6}")
7::Send("{Blind}{F7}")
8::Send("{Blind}{F8}")
9::Send("{Blind}{F9}")
0::Send("{Blind}{F10}")
'::Send("{Blind}{F11}")
¡::Send("{Blind}{F12}")

; =========================
; F-KEYS CON ALT
; =========================

!1::Send("{Blind}{F1}")
!2::Send("{Blind}{F2}")
!3::Send("{Blind}{F3}")
!4::Send("{Blind}{F4}")
!5::Send("{Blind}{F5}")
!6::Send("{Blind}{F6}")
!7::Send("{Blind}{F7}")
!8::Send("{Blind}{F8}")
!9::Send("{Blind}{F9}")
!0::Send("{Blind}{F10}")
!'::Send("{Blind}{F11}")
!¡::Send("{Blind}{F12}")

; =========================
; F-KEYS CON CTRL
; =========================

^1::Send("{Blind}{F1}")
^2::Send("{Blind}{F2}")
^3::Send("{Blind}{F3}")
^4::Send("{Blind}{F4}")
^5::Send("{Blind}{F5}")
^6::Send("{Blind}{F6}")
^7::Send("{Blind}{F7}")
^8::Send("{Blind}{F8}")
^9::Send("{Blind}{F9}")
^0::Send("{Blind}{F10}")
^'::Send("{Blind}{F11}")
^¡::Send("{Blind}{F12}")

; =========================
; F-KEYS CON SHIFT
; =========================

+1::Send("{Blind}!")
+2::Send('{Blind}"')
+3::Send("{Blind}·")
+4::Send("{Blind}$")
+5::Send("{Blind}%")
+6::Send("{Blind}&")
+7::Send("{Blind}/")
+8::Send("{Blind}(")
+9::Send("{Blind})")
+0::Send("{Blind}=")
+'::Send("{Blind}?")
+¡::Send("{Blind}¿")


#HotIf

; =========================
; MODO CAPS (NÚMEROS)
; =========================

#HotIf (capsHeld)

º::Send("º")
+º::Send("ª")

1::Send("1")
+1::Send("!")

2::Send("2")
+2::Send('\"')

3::Send("3")
+3::Send("·")

4::Send("4")
+4::Send("$")

5::Send("5")
+5::Send("%")

6::Send("6")
+6::Send("&")

7::Send("7")
+7::Send("/")

8::Send("8")
+8::Send("(")

9::Send("9")
+9::Send(")")

0::Send("0")
+0::Send("=")

'::Send("'")
+'::Send("?")

¡::Send("¡")
+¡::Send("¿")

; =========================
; NAVEGACIÓN TIPO NVIM (sin modificadores)
; =========================

#HotIf (capsHeld)

h::
{
    global capsUsed
    capsUsed := true
    Send("{Blind}{Left}")
}

j::
{
    global capsUsed
    capsUsed := true
    Send("{Blind}{Down}")
}

k::
{
    global capsUsed
    capsUsed := true
    Send("{Blind}{Up}")
}

l::
{
    global capsUsed
    capsUsed := true
    Send("{Blind}{Right}")
}

u::
{
    global capsUsed
    capsUsed := true
    Send("{Blind}{Home}")
}

o::
{
    global capsUsed
    capsUsed := true
    Send("{Blind}{End}")
}

i::
{
    global capsUsed
    capsUsed := true
    Send("{Blind}{PgUp}")
}

p::
{
    global capsUsed
    capsUsed := true
    Send("{Blind}{PgDn}")
}

Backspace::
{
    global capsUsed
    capsUsed := true
    Send("{Blind}{Delete}")
}

; =========================
; NAVEGACIÓN CON ALT (CapsLock hold)
; =========================

!h::
{
    global capsUsed
    capsUsed := true
    Send("{Blind}{Left}")
}

!j::
{
    global capsUsed
    capsUsed := true
    Send("{Blind}{Down}")
}

!k::
{
    global capsUsed
    capsUsed := true
    Send("{Blind}{Up}")
}

!l::
{
    global capsUsed
    capsUsed := true
    Send("{Blind}{Right}")
}

!u::
{
    global capsUsed
    capsUsed := true
    Send("{Blind}{Home}")
}

!o::
{
    global capsUsed
    capsUsed := true
    Send("{Blind}{End}")
}

!i::
{
    global capsUsed
    capsUsed := true
    Send("{Blind}{PgUp}")
}

!p::
{
    global capsUsed
    capsUsed := true
    Send("{Blind}{PgDn}")
}

!Backspace::
{
    global capsUsed
    capsUsed := true
    Send("{Blind}{Delete}")
}

; =========================
; NAVEGACIÓN CON CTRL (CapsLock hold)
; =========================

^h::
{
    global capsUsed
    capsUsed := true
    Send("{Blind}{Left}")
}

^j::
{
    global capsUsed
    capsUsed := true
    Send("{Blind}{Down}")
}

^k::
{
    global capsUsed
    capsUsed := true
    Send("{Blind}{Up}")
}

^l::
{
    global capsUsed
    capsUsed := true
    Send("{Blind}{Right}")
}

^u::
{
    global capsUsed
    capsUsed := true
    Send("{Blind}{Home}")
}

^o::
{
    global capsUsed
    capsUsed := true
    Send("{Blind}{End}")
}

^i::
{
    global capsUsed
    capsUsed := true
    Send("{Blind}{PgUp}")
}

^p::
{
    global capsUsed
    capsUsed := true
    Send("{Blind}{PgDn}")
}

^Backspace::
{
    global capsUsed
    capsUsed := true
    Send("{Blind}{Delete}")
}

#HotIf
