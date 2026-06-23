sub init()
    m.btnRestart = m.top.findNode("btnRestart")
    m.btnHome = m.top.findNode("btnHome")
    m.finalScoreLabel = m.top.findNode("finalScoreLabel")
    m.selectedIndex = 0
    
    m.top.observeField("hasFocus", "onFocusChange")
    
    ' Listen for the score update
    m.top.observeField("finalScore", "onFinalScoreUpdate")
    
    updateColors()
end sub

sub onFinalScoreUpdate()
    ' Update the text when the game crashes
    m.finalScoreLabel.text = "SCORE: " + m.top.finalScore.toStr()
end sub

sub onFocusChange()
    if m.top.hasFocus() = true then
        m.selectedIndex = 0
        updateColors()
    end if
end sub

sub updateColors()
    if m.selectedIndex = 0 then
        m.btnRestart.color = "0xFF4D4DFF" 
        m.btnHome.color = "0x1E5631FF"    
    else
        m.btnRestart.color = "0x8B0000FF" 
        m.btnHome.color = "0x32CD32FF"    
    end if
end sub

function onKeyEvent(key as String, press as Boolean) as Boolean
    handled = false 
    if m.top.visible = false then return false
    
    if press = true then
        if key = "up" or key = "down" then
            if m.selectedIndex = 0 then m.selectedIndex = 1 else m.selectedIndex = 0
            updateColors()
            handled = true
        else if key = "OK" then
            if m.selectedIndex = 0 then
                m.top.action = "restart"
            else
                m.top.action = "home"
            end if
            handled = true
        end if
    end if
    return handled
end function