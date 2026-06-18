sub init()
    m.top.setFocus(true)
end sub

function onKeyEvent(key as String, press as Boolean) as Boolean
    handled = false
    if press = true then
        if key = "back" then
            ' Go back to home
            m.top.activeScreen = "home"
            handled = true
        end if
    end if
    return handled
end function