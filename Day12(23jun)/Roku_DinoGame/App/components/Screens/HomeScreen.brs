sub init()
    m.playBtn = m.top.findNode("playBtn")
    m.shopBtn = m.top.findNode("shopBtn")
    m.selectedIndex = 0 
    m.top.setFocus(true)
    updateColors()
end sub

sub updateColors()
    if m.selectedIndex = 0 then
        m.playBtn.color = "0xFFD700FF" ' Retro Yellow (Highlighted)
        m.shopBtn.color = "0x4B0082FF" ' Synth Purple (Dimmed)
    else
        m.playBtn.color = "0x4B0082FF" ' Synth Purple (Dimmed)
        m.shopBtn.color = "0xFFD700FF" ' Retro Yellow (Highlighted)
    end if
end sub

function onKeyEvent(key as String, press as Boolean) as Boolean
    handled = false 
    if press = true then
        if key = "down" or key = "up" then
            if m.selectedIndex = 0 then m.selectedIndex = 1 else m.selectedIndex = 0
            updateColors()
            handled = true
        else if key = "OK" then
            if m.selectedIndex = 0 then
                m.top.activeScreen = "play"
            else
                m.top.activeScreen = "shop"
            end if
            handled = true
        end if
    end if
    return handled
end function