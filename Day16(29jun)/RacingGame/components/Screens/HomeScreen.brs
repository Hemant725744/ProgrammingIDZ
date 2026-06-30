sub init()
    ' --- Component 3: Center Road & Player ---
    m.road1 = m.top.findNode("roadLoop1")
    m.road2 = m.top.findNode("roadLoop2")
    m.playerGroup = m.top.findNode("playerCarGroup")
    m.playerImage = m.top.findNode("playerCarImage")
    m.playerHitbox = m.top.findNode("playerHitbox")
    
    ' --- Component 2 & 4: Side Roads (THIS IS WHAT WAS MISSING!) ---
    m.leftStart = m.top.findNode("leftStart")
    m.leftLoop = m.top.findNode("leftObsLoop")
    m.rightStart = m.top.findNode("rightStart")
    m.rightLoop = m.top.findNode("rightObsLoop")
    
    ' --- Animations & UI ---
    m.spinAnim = m.top.findNode("spinAnim")
    m.explosionSprite = m.top.findNode("explosionSprite")
    m.gameOverLabel = m.top.findNode("gameOverLabel")
    m.startLabel = m.top.findNode("startLabel")
    m.speedLabel = m.top.findNode("speedLabel")
    m.fuelLabel = m.top.findNode("fuelLabel") ' Assuming you still have fuel!
    
    ' --- Obstacles ---
    m.obs1 = m.top.findNode("obs1")
    m.obs1Image = m.top.findNode("obs1Image")
    m.obs1Hitbox = m.top.findNode("obs1Hitbox")
    
    m.obs2 = m.top.findNode("obs2")
    m.obs2Image = m.top.findNode("obs2Image")
    m.obs2Hitbox = m.top.findNode("obs2Hitbox")
    
    ' --- Timers ---
    m.gameTimer = m.top.findNode("gameTimer")
    m.explosionTimer = m.top.findNode("explosionTimer")

    ' --- Game State Variables ---
    m.gameStarted = false
    m.speed = 0.0
    m.maxSpeed = 10.0
    m.playerX = 169
    m.carWidth = 40
    m.isExploded = false
    m.isSpinning = false
    m.distance = 0
    m.goalDistance = 10000 
    
    m.keys = { down: false, left: false, right: false }

    ' --- Observers ---
    m.gameTimer.observeField("fire", "gameLoop")
    m.explosionTimer.observeField("fire", "animateExplosion")

    m.top.setFocus(true)
end sub
' --- CONTROLS ---
function onKeyEvent(key as String, press as Boolean) as Boolean
    if key = "OK" and press and not m.gameStarted
        m.gameStarted = true
        m.startLabel.visible = false
        m.gameTimer.control = "start"
        return true
    end if

    if m.isExploded then return true 
    
    if key = "down" then m.keys.down = press
    if key = "left" then m.keys.left = press
    if key = "right" then m.keys.right = press
    return true
end function

' --- MAIN ENGINE LOOP ---
sub gameLoop()
    if m.isExploded or not m.gameStarted then return

    ' 1. Auto-Acceleration and Braking Logic
    if m.keys.down
        ' Gradually slow down when holding brake
        m.speed -= 0.2
        if m.speed < 0 then m.speed = 0
    else
        ' Gradually speed up if no brake is pressed
        m.speed += 0.1
        if m.speed > m.maxSpeed then m.speed = m.maxSpeed
    end if
    
    m.speedLabel.text = "Speed: " + Int(m.speed * 40).toStr()
    
    ' 2. Move Backgrounds (Center, Left, and Right)
    if m.speed > 0
        m.distance += m.speed
        
        ' Move Center Road
        m.road1.translation = [0, m.road1.translation[1] + m.speed]
        m.road2.translation = [0, m.road2.translation[1] + m.speed]
        
        ' FIXED: Actually move the side roads down by m.speed
        m.leftStart.translation = [0, m.leftStart.translation[1] + m.speed]
        m.leftLoop.translation = [0, m.leftLoop.translation[1] + m.speed]
        m.rightStart.translation = [0, m.rightStart.translation[1] + m.speed]
        m.rightLoop.translation = [0, m.rightLoop.translation[1] + m.speed]
        
        ' Loop road1
        if m.road1.translation[1] >= 720
            m.road1.translation = [0, m.road2.translation[1] - 720]
            ' If it was the starting strip, change it to normal road
            if m.distance < m.goalDistance then m.road1.uri = "pkg:/images/road/road.jpg"
            ' If we reached the end, change to the finish strip
            if m.distance >= m.goalDistance then m.road1.uri = "pkg:/images/road/Striproad.jpg"
        end if
        
        ' Loop road2
        if m.road2.translation[1] >= 720
            m.road2.translation = [0, m.road1.translation[1] - 720]
            if m.distance >= m.goalDistance then m.road2.uri = "pkg:/images/road/Striproad.jpg"
        end if
        
        ' Loop Side Roads
        if m.leftStart.translation[1] >= 720 then m.leftStart.translation = [0, m.leftLoop.translation[1] - 720]
        if m.leftLoop.translation[1] >= 720 then m.leftLoop.translation = [0, m.leftStart.translation[1] - 720]
        
        if m.rightStart.translation[1] >= 720 then m.rightStart.translation = [0, m.rightLoop.translation[1] - 720]
        if m.rightLoop.translation[1] >= 720 then m.rightLoop.translation = [0, m.rightStart.translation[1] - 720]
    end if ' <-- FIXED: This closes the speed block here, so you can still steer when stopped!

    ' 3. Move Player Smoothly
    if not m.isSpinning
        if m.keys.left then m.playerX -= 5
        if m.keys.right then m.playerX += 5
        m.playerGroup.translation = [m.playerX, 600]
    end if

    ' 4. Check Wall Collision (Using global car width so we don't go off screen)
    if m.playerX <= 0 or m.playerX >= (378 - m.carWidth)
        triggerWallCrash()
        return
    end if

    ' 5. Move Obstacles & Check Hitbox Collisions
    updateObstacle(m.obs1, m.obs1Image, m.obs1Hitbox)
    updateObstacle(m.obs2, m.obs2Image, m.obs2Hitbox)
end sub

' --- OBSTACLE & HITBOX LOGIC ---
sub updateObstacle(obsGroup as Object, obsImage as Object, obsHitbox as Object)
    obsY = obsGroup.translation[1] + (m.speed * 0.6) 
    obsX = obsGroup.translation[0]
    
    if obsY > 870
        obsY = -150
        obsX = Rnd(338) 
        
        randCar = Rnd(3)
        if randCar = 1 
            obsImage.uri = "pkg:/images/cars/car1.jpg"
            obsHitbox.width = 30
            obsHitbox.height = 70
        else if randCar = 2
            obsImage.uri = "pkg:/images/cars/car2.jpg"
            obsHitbox.width = 30
            obsHitbox.height = 70
        else
            obsImage.uri = "pkg:/images/cars/truck.jpg"
            obsHitbox.width = 35
            obsHitbox.height = 80
        end if
    end if
    
    obsGroup.translation = [obsX, obsY]

    ' DEDICATED HITBOX COLLISION MATH
    if not m.isSpinning
        ' Calculate Absolute Position of Player Hitbox
        pLeft = m.playerX + m.playerHitbox.translation[0]
        pRight = pLeft + m.playerHitbox.width
        pTop = 600 + m.playerHitbox.translation[1]
        pBottom = pTop + m.playerHitbox.height
        
        ' Calculate Absolute Position of Obstacle Hitbox
        oLeft = obsX + obsHitbox.translation[0]
        oRight = oLeft + obsHitbox.width
        oTop = obsY + obsHitbox.translation[1]
        oBottom = oTop + obsHitbox.height
        
        if pLeft < oRight and pRight > oLeft and pTop < oBottom and pBottom > oTop
            triggerSpinOut()
        end if
    end if
end sub

' --- CASE 2: OBSTACLE SPIN OUT ---
sub triggerSpinOut()
    m.isSpinning = true
    
    if m.playerX < 189
        m.playerX = m.playerX - 50
    else
        m.playerX = m.playerX + 50
    end if
    
    ' FIXED: Now uses m.playerGroup instead of m.playerCar
    m.playerGroup.translation = [m.playerX, 600]
    
    if m.playerX <= 0 or m.playerX >= (378 - m.carWidth)
        triggerWallCrash()
    else
        m.spinAnim.control = "start"
    end if
end sub

sub onSpinComplete()
    if m.spinAnim.state = "stopped"
        m.isSpinning = false
        ' FIXED: Now uses m.playerImage instead of m.playerCar
        m.playerImage.rotation = 0
    end if
end sub

' --- CASE 1 & GAME OVER STATE ---
sub triggerWallCrash()
    m.isExploded = true
    m.speed = 0
    m.gameTimer.control = "stop"
    m.playerCar.visible = false
    m.explosionSprite.translation = [m.playerX - 20, 580]
    m.explosionSprite.visible = true
    m.explosionFrame = 1
    m.explosionTimer.control = "start"
end sub

sub animateExplosion()
    m.explosionFrame += 1
    if m.explosionFrame > 5
        m.explosionTimer.control = "stop"
        triggerGameOver("GAME OVER")
    else
        m.explosionSprite.uri = "pkg:/images/blasting/f" + m.explosionFrame.toStr() + ".jpg"
    end if
end sub

' NEW: Centralized Game Over function
sub triggerGameOver(message as String)
    m.gameOverLabel.text = message
    m.gameOverLabel.visible = true
    m.gameTimer.control = "stop"
    m.speed = 0
end sub