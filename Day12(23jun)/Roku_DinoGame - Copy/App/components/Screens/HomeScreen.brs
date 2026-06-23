sub init()
    uiNodes = {
        group: m.top.findNode("shooterGroup"),
        arrow: m.top.findNode("arrow"),
        ball: m.top.findNode("ball"),
        line: m.top.findNode("lineContainer")
    }
    m.shooter = m.top.createChild("ShooterModule")
    m.shooter.callFunc("setupUI", uiNodes)
    m.top.setFocus(true)
end sub

sub onKeyEvent(key as String, press as Boolean) as Boolean
    if press and (key = "left" or key = "right")
        m.shooter.callFunc("rotateShooter", key)
        return true
    end if
    return false
end sub