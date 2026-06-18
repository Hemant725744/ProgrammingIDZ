sub init()
    ' 1. Grab the rectangle from the XML so it is NOT invalid/null
    m.myRedBox = m.top.findNode("myRedBox")
    
    ' 2. Tell the Roku to send remote control clicks to this screen
    m.top.setFocus(true) 
end sub

function onKeyEvent(key as String, press as Boolean) as Boolean
    handled = false 
    
    if press = true then 
        
        currentX = m.myRedBox.translation[0]
        currentY = m.myRedBox.translation[1]
        
        moveSpeed = 50
        
        ' --- YOUR NEW EXACT LIMITS ---
        maxRightPos = 1180 ' (1280 screen width - 100 box width)
        maxBottomPos = 620 ' (720 screen height - 100 box height)
        
        ' MOVE RIGHT
        if key = "right" then
            newX = currentX + moveSpeed
            
            ' If it tries to go past 1180, snap it back to 1180
            if newX > maxRightPos then 
                newX = maxRightPos
            end if
            
            m.myRedBox.translation = [newX, currentY]
            handled = true 
            
        ' MOVE LEFT
        else if key = "left" then
            newX = currentX - moveSpeed
            
            ' If it tries to go past 0, snap it back to 0
            if newX < 0 then 
                newX = 0
            end if
            
            m.myRedBox.translation = [newX, currentY]
            handled = true
            
        ' MOVE DOWN
        else if key = "down" then
            newY = currentY + moveSpeed
            
            ' If it tries to drop past 620, snap it back to 620
            if newY > maxBottomPos then 
                newY = maxBottomPos
            end if
            
            m.myRedBox.translation = [currentX, newY]
            handled = true
            
        ' MOVE UP
        else if key = "up" then
            newY = currentY - moveSpeed
            
            ' If it tries to fly past 0, snap it back to 0
            if newY < 0 then 
                newY = 0
            end if
            
            m.myRedBox.translation = [currentX, newY]
            handled = true
            
        end if
        
    end if
    
    return handled
end function