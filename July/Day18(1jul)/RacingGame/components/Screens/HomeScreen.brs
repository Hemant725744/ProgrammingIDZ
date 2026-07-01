sub init()
    ' --- Component 3: Center Road & Player ---
    m.road1 = m.top.findNode("roadLoop1")
    m.road2 = m.top.findNode("roadLoop2")
    m.playerGroup = m.top.findNode("playerCarGroup")
    m.playerImage = m.top.findNode("playerCarImage")
    m.playerHitbox = m.top.findNode("playerHitbox")
    
    ' --- NEW: Dynamic Collision Boundaries ---
    m.foot1 = m.top.findNode("foot1")
    m.foot2 = m.top.findNode("foot2")
    
    ' --- Animations & UI ---
    m.spinAnim = m.top.findNode("spinAnim")
    m.explosionSprite = m.top.findNode("explosionSprite")
    m.gameOverLabel = m.top.findNode("gameOverLabel")
    m.startLabel = m.top.findNode("startLabel")
    m.speedLabel = m.top.findNode("speedLabel")
    m.timeLabel = m.top.findNode("timeLabel") 
    
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
    m.maxSpeed = 4.0
    m.playerX = 250 ' Absolute x=385 (199 + 186)
    m.carWidth = 78
    m.isExploded = false
    m.isSpinning = false
    m.distance = 0
    m.goalDistance = 10000 
    m.timeLeft = 60.0
    
    ' --- Sequence State for image_bb301e.png logic ---
    m.currentSequence = "straight"
    m.straightCounter = 0
    
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

    ' 1. The Timer Logic
    m.timeLeft -= 0.016
    if m.timeLeft <= 0
        m.timeLeft = 0
        m.timeLabel.text = "Time: 0"
        triggerGameOver("TIME UP!")
        return
    end if
    m.timeLabel.text = "Time: " + Int(m.timeLeft).toStr()

    ' 2. Auto-Acceleration and Braking
    if m.keys.down
        m.speed -= 0.08
        if m.speed < 0 then m.speed = 0
    else
        m.speed += 0.03
        if m.speed > m.maxSpeed then m.speed = m.maxSpeed
    end if
    
    m.speedLabel.text = "Speed: " + Int(m.speed * 10).toStr()
    
    ' 3. Move Road Backgrounds
    if m.speed > 0
        m.distance += m.speed
        
        ' MOVE ROADS
    m.road1.translation = [0, m.road1.translation[1] + m.speed]
    m.road2.translation = [0, m.road2.translation[1] + m.speed]
    
    ' FORCE BOUNDARY UPDATE EVERY FRAME
    updateBoundaries(m.road1)
    updateBoundaries(m.road2)

       
        
        
        ' --- CENTER ROAD LOOP & SEQUENCE LOGIC ---
        ' --- CENTER ROAD LOOP & SEQUENCE LOGIC ---
        if m.road1.translation[1] >= 720
            m.road1.translation = [0, m.road2.translation[1] - 720]
            
            if m.distance >= m.goalDistance
                m.road1.uri = "pkg:/images/road/Striproad.jpg"
            else
                if m.currentSequence = "straight"
                    m.straightCounter += 1
                    if m.straightCounter >= 4
                        m.straightCounter = 0
                        if Rnd(2) = 1 then m.currentSequence = "rightTilt" else m.currentSequence = "leftTilt"
                    end if
                    m.road1.uri = "pkg:/images/road/road.jpg"
                else if m.currentSequence = "rightTilt"
                    m.road1.uri = "pkg:/images/road/straighttoright.jpg"
                    m.currentSequence = "rightReturn"
                else if m.currentSequence = "rightReturn"
                    m.road1.uri = "pkg:/images/road/righttoleft.jpg"
                    m.currentSequence = "straight"
                else if m.currentSequence = "leftTilt"
                    m.road1.uri = "pkg:/images/road/straighttoleft.jpg"
                    m.currentSequence = "leftReturn"
                else if m.currentSequence = "leftReturn"
                    m.road1.uri = "pkg:/images/road/lefttoright.jpg"
                    m.currentSequence = "straight"
                end if
            end if
        end if
        
        if m.road2.translation[1] >= 720
            m.road2.translation = [0, m.road1.translation[1] - 720]
            
            if m.distance >= m.goalDistance
                m.road2.uri = "pkg:/images/road/Striproad.jpg"
            else
                if m.currentSequence = "straight"
                    m.straightCounter += 1
                    if m.straightCounter >= 4
                        m.straightCounter = 0
                        if Rnd(2) = 1 then m.currentSequence = "rightTilt" else m.currentSequence = "leftTilt"
                    end if
                    m.road2.uri = "pkg:/images/road/road.jpg"
                else if m.currentSequence = "rightTilt"
                    m.road2.uri = "pkg:/images/road/straighttoright.jpg"
                    m.currentSequence = "rightReturn"
                else if m.currentSequence = "rightReturn"
                    m.road2.uri = "pkg:/images/road/righttoleft.jpg"
                    m.currentSequence = "straight"
                else if m.currentSequence = "leftTilt"
                    m.road2.uri = "pkg:/images/road/straighttoleft.jpg"
                    m.currentSequence = "leftReturn"
                else if m.currentSequence = "leftReturn"
                    m.road2.uri = "pkg:/images/road/lefttoright.jpg"
                    m.currentSequence = "straight"
                end if
            end if
        end if
        
        if m.distance >= m.goalDistance
            triggerGameOver("YOU WIN!")
            return
        end if
    end if

    ' 4. Move Player Smoothly
    if not m.isSpinning
        if m.keys.left then m.playerX -= 5
        if m.keys.right then m.playerX += 5
        m.playerGroup.translation = [m.playerX, 500]
    end if

    ' 5. Check Dynamic Wall Collision (using feet positions)
    f1X = m.foot1.translation[0]
    f2X = m.foot2.translation[0]
    if m.playerX <= f1X or (m.playerX + m.carWidth) >= f2X
        triggerWallCrash()
        return
    end if

    ' 6. Move Obstacles & Check Hitbox Collisions
    updateObstacle(m.obs1, m.obs1Image, m.obs1Hitbox)
    updateObstacle(m.obs2, m.obs2Image, m.obs2Hitbox)
end sub

sub updateBoundaries(roadNode as Object)
    y = roadNode.translation[1]
    
    ' Only animate if the road is visible on screen (y is between 0 and 720)
    if y >= 0 and y <= 720
        progress = y / 720.0 ' Linear progression 0.0 to 1.0
        
        uri = roadNode.uri
        if uri = "pkg:/images/road/straighttoright.jpg"
            ' Smoothly interpolate using the progress variable
            m.foot1.translation = [186 + (142 * progress), 0]
            m.foot2.translation = [558 + (168 * progress), 0]
        else if uri = "pkg:/images/road/righttoleft.jpg"
            m.foot1.translation = [328 - (142 * progress), 0]
            m.foot2.translation = [726 - (168 * progress), 0]
        else if uri = "pkg:/images/road/straighttoleft.jpg"
            m.foot1.translation = [186 - (124 * progress), 0]
            m.foot2.translation = [558 - (129 * progress), 0]
        else if uri = "pkg:/images/road/lefttoright.jpg"
            m.foot1.translation = [62 + (124 * progress), 0]
            m.foot2.translation = [429 + (129 * progress), 0]
        else
            ' Reset when straight
            m.foot1.translation = [186, 0]
            m.foot2.translation = [558, 0]
        end if
    end if
end sub
' --- OBSTACLE & HITBOX LOGIC ---
sub updateObstacle(obsGroup as Object, obsImage as Object, obsHitbox as Object)
    aiSpeed = 6.0 
    obsY = obsGroup.translation[1] + (m.speed - aiSpeed) 
    obsX = obsGroup.translation[0]
    
    if obsY > 720
        obsY = -150
        
        ' Get the current dynamic bounds of the road 
        ' These values change whenever updateBoundaries() runs
        laneLeft = m.foot1.translation[0]
        laneRight = m.foot2.translation[0]
        
        ' Calculate the width currently available
        laneWidth = laneRight - laneLeft
        
        ' Clamp the spawn to be between the CURRENT foot positions
        ' 80 is the width of the obstacle car
        obsX = laneLeft + Rnd(laneWidth - 80)
        
        randCar = Rnd(3)
        if randCar = 1 
            obsImage.uri = "pkg:/images/cars/car1.jpg"
            obsImage.width = 80 : obsImage.height = 105
            obsHitbox.width = 55 : obsHitbox.height = 96
            obsHitbox.translation = [9, 5]
        else if randCar = 2
            obsImage.uri = "pkg:/images/cars/car2.jpg"
            obsImage.width = 73 : obsImage.height = 100
            obsHitbox.width = 60 : obsHitbox.height = 92
            obsHitbox.translation = [6, 5]
        else
            obsImage.uri = "pkg:/images/cars/truck.jpg"
            obsImage.width = 73 : obsImage.height = 143
            obsHitbox.width = 60 : obsHitbox.height = 137
            obsHitbox.translation = [5, 5]
        end if
    end if
    
    obsGroup.translation = [obsX, obsY]

    ' DEDICATED HITBOX COLLISION MATH
    if not m.isSpinning
        pLeft = m.playerX + m.playerHitbox.translation[0]
        pRight = pLeft + m.playerHitbox.width
        pTop = 500 + m.playerHitbox.translation[1]
        pBottom = pTop + m.playerHitbox.height
        
        oLeft = obsX + obsHitbox.translation[0]
        oRight = oLeft + obsHitbox.width
        oTop = obsY + obsHitbox.translation[1]
        oBottom = oTop + obsHitbox.height
        
        ' Collision detection now respects the dynamic boundaries of the feet
        ' Obstacle only triggers if it hits the player within the valid road area
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

    ' FIXED: Update 600 to 500 to match your new car height
    m.playerGroup.translation = [m.playerX, 500]
    
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
    
    ' FIXED: Changed m.playerCar to m.playerGroup
    m.playerGroup.visible = false 
    
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