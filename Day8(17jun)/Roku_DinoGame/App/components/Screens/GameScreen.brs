sub init()
    ' 1. Grab all the UI elements from the XML
    m.player = m.top.findNode("playerBox")
    m.obstacle = m.top.findNode("obstacleBox")
    m.timer = m.top.findNode("gameTimer")
    m.popup = m.top.findNode("popup")
    
    ' 2. Setup physics variables (using explicit decimals for safety)
    m.gravity = 1.2
    m.yVelocity = 0.0
    m.isJumping = false
    
    ' 3. Attach listeners
    m.timer.observeField("fire", "gameLoop")
    m.popup.observeField("action", "handlePopupAction")
    
    ' Start the game automatically when the screen loads
    startGame()
end sub

' Resets the board and starts the engine
sub startGame()
    ' Reset positions
    m.player.translation = [200, 500]
    m.obstacle.translation = [1280, 500] ' CHANGED FROM 400 to 500
    
    ' Reset physics state
    m.yVelocity = 0.0
    m.isJumping = false
    
    m.popup.visible = false
    m.top.setFocus(true)
    m.timer.control = "start"
end sub

' Listens for the remote control to jump
function onKeyEvent(key as String, press as Boolean) as Boolean
    handled = false 
    
    if press = true then
        ' Jump if they press UP or OK, but only if they aren't already jumping
        if key = "up" or key = "OK" then
            if m.isJumping = false then
                m.yVelocity = -22.0 ' Initial upward burst of speed
                m.isJumping = true
                handled = true
            end if
        end if
    end if
    
    return handled
end function

' THE ENGINE: Runs 60 times a second
sub gameLoop()
    ' --- 1. PLAYER PHYSICS ---
    pX = m.player.translation[0]
    pY = m.player.translation[1]
    
    if m.isJumping = true then
        ' Gravity constantly pulls the velocity down
        m.yVelocity = m.yVelocity + m.gravity 
        pY = pY + m.yVelocity
        
        ' Check if we hit the floor (Y = 500)
        if pY >= 500 then
            pY = 500
            m.yVelocity = 0.0
            m.isJumping = false
        end if
        
        ' Apply the new position
        m.player.translation = [pX, pY]
    end if
    
    ' --- 2. OBSTACLE MOVEMENT ---
    oX = m.obstacle.translation[0]
    oY = m.obstacle.translation[1]
    
    ' Move the obstacle left by 12 pixels every frame
    oX = oX - 12 
    
    ' If the obstacle goes completely off the left side of the screen, reset it to the right
    if oX < -100 then 
        oX = 1280
    end if
    
    ' Apply the new position
    m.obstacle.translation = [oX, oY]
    
    ' --- 3. COLLISION DETECTION (AABB) ---
    ' Calculate the exact boundaries of both shapes
    playerRight = pX + 100
    playerBottom = pY + 100
    obsRight = oX + 100
    obsBottom = oY + 100 ' CHANGED FROM + 200 to + 100
    
    if pX < obsRight and playerRight > oX and pY < obsBottom and playerBottom > oY then
        ' CRASH OCCURRED!
        m.timer.control = "stop" 
        m.popup.visible = true   
        m.popup.setFocus(true)   
    end if
end sub

' Listens for clicks coming from the Game Over popup menu
sub handlePopupAction(event as Object)
    action = event.getData()
    
    if action = "restart" then
        startGame()
    else if action = "home" then
        m.top.activeScreen = "home" ' Tell the MainScene router to take us back to the blue menu
    end if
end sub