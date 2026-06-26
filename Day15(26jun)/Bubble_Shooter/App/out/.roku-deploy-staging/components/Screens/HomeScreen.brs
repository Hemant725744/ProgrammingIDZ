sub init()
    uiNodes = {
        group: m.top.findNode("shooterGroup"),
        arrow: m.top.findNode("arrow"),
        ball: m.top.findNode("ball"),
        line: m.top.findNode("lineContainer"),
        scoreLabel: m.top.findNode("scoreLabel"),
        nextBall: m.top.findNode("nextBall")
    }
    
    m.shooter = m.top.createChild("ShooterModule")
    m.shooter.callFunc("setupUI", uiNodes)
    
    m.grid = m.top.findNode("gridManager")
    m.grid.callFunc("generateGrid", "")
    
    m.top.setFocus(true)
end sub

sub onKeyEvent(key as String, press as Boolean) as Boolean
    ' Pass both the key and whether it is currently being held down or released
    if key = "left" or key = "right" or key = "OK" then
        m.shooter.callFunc("handleInput", {key: key, press: press})
        return true 
    end if
    
    return false
end sub