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
    global monitorTimer

    capsUsed := false

    ; Espera a ver si se mantiene pulsado
    if !KeyWait("CapsLock", "T0.1")  ; 100 ms
    {
        ; HOLD
        capsHeld := true
		ShowOverlay()

        ; Monitor loop para mantener el overlay visible
        monitorTimer := SetTimer(MonitorOverlay, 100)

        ; Espera a que se suelte
        KeyWait("CapsLock")

        capsHeld := false
        
        ; Detiene el monitor de forma segura
        if (monitorTimer)
        {
            monitorTimer.Stop()
        }
        
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

MonitorOverlay()
{
    global capsHeld, overlayGui
    
    ; Si capsHeld es false, no hacer nada
    if (!capsHeld)
        return
    
    ; Fuerza la visibilidad del overlay
    if (!WinExist(overlayGui.Hwnd " ahk_id"))
    {
        ShowOverlay()
    }
    
    ; Asegura que siempre esté en el frente
    WinSetAlwaysOnTop(1, overlayGui.Hwnd)
}

;==========================
; Overlay
;==========================
InitOverlay()
{
    global overlayGui
    global overlayText
    global hideTimer
    global monitorTimer

    overlayGui := Gui("+AlwaysOnTop -Caption +ToolWindow +E0x20")
    overlayGui.BackColor := "000000"

    ; Fuente (tamaño + color)
    overlayGui.SetFont("s14", "Segoe UI")
    overlayGui.SetFont("cFFFFFF")

    overlayText := overlayGui.AddText("Center", "NORMAL / NAV MODE")

    WinSetTransparent(180, overlayGui.Hwnd)
    hideTimer := 0
    monitorTimer := 0
}

ShowOverlay(text := "NORMAL / NAV MODE")
{
    global overlayGui, overlayText, hideTimer

    overlayText.Value := text

    ; Centrado horizontalmente, parte superior de la pantalla
    screenCenterX := (A_ScreenWidth / 2) - 150
    screenCenterY := 40

    overlayGui.Show("x" screenCenterX " y" screenCenterY " NoActivate")
    WinSetAlwaysOnTop(1, overlayGui.Hwnd)
    
    ; Cancela cualquier timer pendiente de ocultamiento
    if (hideTimer)
    {
        SetTimer(hideTimer, 0)
        hideTimer := 0
    }
}

HideOverlay()
{
    global overlayGui, hideTimer
    overlayGui.Hide()
    hideTimer := 0
}

; =========================
; TOGGLE F-KEYS HOTKEY
; =========================

#+F::
{
    global fkeysEnabled, hideTimer
    fkeysEnabled := !fkeysEnabled
    
    if (fkeysEnabled)
    {
        ShowOverlay("60% KEYBOARD MODE")
    }
    else
    {
        ShowOverlay("FULL KEYBOARD MODE")
    }
    
    ; Cancela timer anterior si existe
    if (hideTimer)
    {
        SetTimer(hideTimer, 0)
    }
    
    ; Crea nuevo timer para ocultar después de 2 segundos
    hideTimer := () => HideOverlay()
    SetTimer(hideTimer, 2000)
}

; =========================
; F-KEYS (DEFAULT) - sin modificadores
; =========================

#HotIf (!capsHeld && fkeysEnabled)

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
; F-KEYS CON SHIFT (Spanish keyboard)
; =========================

+1::Send("{Blind}{!}")
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
+2::Send('"')

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

+h::
{
    global capsUsed
    capsUsed := true
    Send("{Blind}+{Left}")
}

+j::
{
    global capsUsed
    capsUsed := true
    Send("{Blind}+{Down}")
}

+k::
{
    global capsUsed
    capsUsed := true
    Send("{Blind}+{Up}")
}

+l::
{
    global capsUsed
    capsUsed := true
    Send("{Blind}+{Right}")
}

+u::
{
    global capsUsed
    capsUsed := true
    Send("{Blind}+{PgUp}")
}

+o::
{
    global capsUsed
    capsUsed := true
    Send("{Blind}+{End}")
}

+i::
{
    global capsUsed
    capsUsed := true
    Send("{Blind}+{Home}")
}

+p::
{
    global capsUsed
    capsUsed := true
    Send("{Blind}+{PgDn}")
}

+Backspace::
{
    global capsUsed
    capsUsed := true
    Send("{Blind}+{Delete}")
}

u::
{
    global capsUsed
    capsUsed := true
    Send("{Blind}{PgUp}")
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
    Send("{Blind}{Home}")
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

!+h::
{
    global capsUsed
    capsUsed := true
    Send("{Blind}!+{Left}")
}

!+j::
{
    global capsUsed
    capsUsed := true
    Send("{Blind}!+{Down}")
}

!+k::
{
    global capsUsed
    capsUsed := true
    Send("{Blind}!+{Up}")
}

!+l::
{
    global capsUsed
    capsUsed := true
    Send("{Blind}!+{Right}")
}

!+u::
{
    global capsUsed
    capsUsed := true
    Send("{Blind}!+{PgUp}")
}

!+o::
{
    global capsUsed
    capsUsed := true
    Send("{Blind}!+{End}")
}

!+i::
{
    global capsUsed
    capsUsed := true
    Send("{Blind}!+{Home}")
}

!+p::
{
    global capsUsed
    capsUsed := true
    Send("{Blind}!+{PgDn}")
}

!+Backspace::
{
    global capsUsed
    capsUsed := true
    Send("{Blind}!+{Delete}")
}

!u::
{
    global capsUsed
    capsUsed := true
    Send("{Blind}{PgUp}")
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
    Send("{Blind}{Home}")
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

^+h::
{
    global capsUsed
    capsUsed := true
    Send("{Blind}^+{Left}")
}

^+j::
{
    global capsUsed
    capsUsed := true
    Send("{Blind}^+{Down}")
}

^+k::
{
    global capsUsed
    capsUsed := true
    Send("{Blind}^+{Up}")
}

^+l::
{
    global capsUsed
    capsUsed := true
    Send("{Blind}^+{Right}")
}

^+u::
{
    global capsUsed
    capsUsed := true
    Send("{Blind}^+{PgUp}")
}

^+o::
{
    global capsUsed
    capsUsed := true
    Send("{Blind}^+{End}")
}

^+i::
{
    global capsUsed
    capsUsed := true
    Send("{Blind}^+{Home}")
}

^+p::
{
    global capsUsed
    capsUsed := true
    Send("{Blind}^+{PgDn}")
}

^+Backspace::
{
    global capsUsed
    capsUsed := true
    Send("{Blind}^+{Delete}")
}

^u::
{
    global capsUsed
    capsUsed := true
    Send("{Blind}{PgUp}")
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
    Send("{Blind}{Home}")
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
