sub init()
    m.playBtn = m.top.findNode("playBtn")
    m.shopBtn = m.top.findNode("shopBtn")
    m.selectedIndex = 0 
    m.top.setFocus(true)
    
    ' Set initial colors when the screen loads
    updateColors()
end sub

sub updateColors()
    if m.selectedIndex = 0 then
        m.playBtn.color = "0x32CD32FF" ' Bright Lime Green (Focused)
        m.shopBtn.color = "0x1E5631FF" ' Dark Forest Green (Unfocused)
    else
        m.playBtn.color = "0x1E5631FF" ' Dark Forest Green (Unfocused)
        m.shopBtn.color = "0x32CD32FF" ' Bright Lime Green (Focused)
    end if
end sub

function onKeyEvent(key as String, press as Boolean) as Boolean
    handled = false 
    if press = true then
        if key = "down" or key = "up" then
            
            ' 1. Toggle the index between 0 and 1
            if m.selectedIndex = 0 then m.selectedIndex = 1 else m.selectedIndex = 0
            
            ' 2. Trigger the theme colors! 
            ' (Because we call the sub, the white glitch is gone forever)
            updateColors()
            handled = true
            
        else if key = "OK" then
            
            ' 3. Trigger the router
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