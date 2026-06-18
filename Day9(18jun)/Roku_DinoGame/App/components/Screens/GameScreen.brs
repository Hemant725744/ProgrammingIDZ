sub init()
    m.cloud1a = m.top.findNode("cloud1a")
    m.cloud1b = m.top.findNode("cloud1b")
    m.cloud2a = m.top.findNode("cloud2a")
    m.cloud2b = m.top.findNode("cloud2b")
    
    m.player = m.top.findNode("playerBox")
    m.obstacle = m.top.findNode("obstacleBox")
    m.coin = m.top.findNode("coinBox")
    m.scoreLabel = m.top.findNode("scoreLabel")
    m.timer = m.top.findNode("gameTimer")
    m.popup = m.top.findNode("popup")
    
    m.gravity = 1.2
    m.yVelocity = 0.0
    m.isJumping = false
    
    ' Game State Tracking
    m.animFrameCount = 0
    m.runFrameIndex = 1
    m.crashFrameIndex = 1
    m.gameState = "running"
    
    ' New Logic Variables
    m.score = 0
    m.obsCounter = 0 ' Tracks how many ground obstacles have passed
    
    m.timer.observeField("fire", "gameLoop")
    m.popup.observeField("action", "handlePopupAction")
    
    startGame()
end sub

sub startGame()
    m.player.translation = [200, 470]
    
    ' Reset Obstacle to Tree
    m.obstacle.uri = "pkg:/images/ob1.jpg"
    m.obstacle.width = 90
    m.obstacle.height = 150
    m.obstacle.translation = [1280, 450]
    
    ' Reset Coin
    m.coin.translation = [1600, 400]
    m.coin.visible = true ' Ensure it is visible on restart!
    
    m.cloud1a.translation = [100, 30]
    m.cloud1b.translation = [850, 30]
    m.cloud2a.translation = [400, 120]
    m.cloud2b.translation = [1100, 120]
    
    m.yVelocity = 0.0
    m.isJumping = false
    m.score = 0
    m.obsCounter = 0
    m.scoreLabel.text = "SCORE: 0"
    m.popup.visible = false
    
    m.gameState = "running"
    m.runFrameIndex = 1
    m.crashFrameIndex = 1
    m.animFrameCount = 0
    m.player.uri = "pkg:/images/dinorun/f1.jpg"
    
    m.timer.control = "start"
    m.top.setFocus(true)
end sub

sub handlePopupAction(event as Object)
    action = event.getData()
    if action = "restart" then
        startGame()
    else if action = "home" then
        m.top.activeScreen = "home"
    end if
end sub

function onKeyEvent(key as String, press as Boolean) as Boolean
    handled = false 
    if press = true then
        if (key = "up" or key = "OK") and m.gameState = "running" then
            if m.isJumping = false then
                m.yVelocity = -22.0
                m.isJumping = true
            end if
            handled = true
        end if
    end if
    return handled
end function

sub gameLoop()
    m.animFrameCount = m.animFrameCount + 1

    if m.gameState = "running" then
        
        ' --- RUNNING ANIMATION ---
        if m.animFrameCount MOD 5 = 0 then
            m.runFrameIndex = m.runFrameIndex + 1
            if m.runFrameIndex > 6 then m.runFrameIndex = 1
            m.player.uri = "pkg:/images/dinorun/f" + m.runFrameIndex.toStr() + ".jpg"
        end if

        ' --- PARALLAX CLOUDS ---
        c1aX = m.cloud1a.translation[0] - 4 
        c1bX = m.cloud1b.translation[0] - 4
        if c1aX <= -250 then c1aX = 1280
        if c1bX <= -250 then c1bX = 1280
        m.cloud1a.translation = [c1aX, 30]
        m.cloud1b.translation = [c1bX, 30]
        
        c2aX = m.cloud2a.translation[0] - 2 
        c2bX = m.cloud2b.translation[0] - 2
        if c2aX <= -350 then c2aX = 1280
        if c2bX <= -350 then c2bX = 1280
        m.cloud2a.translation = [c2aX, 120]
        m.cloud2b.translation = [c2bX, 120]

        ' --- PHYSICS ---
        pX = m.player.translation[0]
        pY = m.player.translation[1]
        
        if m.isJumping = true then
            m.yVelocity = m.yVelocity + m.gravity
            pY = pY + m.yVelocity
            if pY >= 470 then
                pY = 470
                m.yVelocity = 0.0
                m.isJumping = false
            end if
            m.player.translation = [pX, pY]
        end if
        
        ' --- DYNAMIC OBSTACLE SPAWNER ---
        oX = m.obstacle.translation[0]
        oY = m.obstacle.translation[1]
        oX = oX - 12
        
        if oX < -150 then 
            oX = 1280
            m.obsCounter = m.obsCounter + 1
            
            ' If 3 ground obstacles have passed, spawn the Bird!
            if m.obsCounter >= 3 then
                m.obstacle.uri = "pkg:/images/ob4.jpg"
                m.obstacle.width = 70
                m.obstacle.height = 80
                m.obstacle.translation = [oX, 400] ' High in the sky
                m.obsCounter = 0 ' Reset counter
            else
                ' Spawn a random ground obstacle (1, 2, or 3)
                randType = Rnd(3)
                if randType = 1 then
                    ' Tree
                    m.obstacle.uri = "pkg:/images/ob1.jpg"
                    m.obstacle.width = 90
                    m.obstacle.height = 150
                    m.obstacle.translation = [oX, 450]
                else if randType = 2 then
                    ' Cactus
                    m.obstacle.uri = "pkg:/images/ob2.jpg"
                    m.obstacle.width = 60
                    m.obstacle.height = 130
                    m.obstacle.translation = [oX, 500]
                else if randType = 3 then
                    ' Rock/Rabbit
                    m.obstacle.uri = "pkg:/images/ob3.jpg"
                    m.obstacle.width = 80
                    m.obstacle.height = 110
                    m.obstacle.translation = [oX, 510]
                end if
            end if
        else
            m.obstacle.translation = [oX, oY]
        end if
        
        ' --- COIN SPAWNER & LOGIC ---
        cX = m.coin.translation[0] - 12
        cY = m.coin.translation[1]
        
        if cX < -50 then
            ' Respawn coin at a random distance behind the obstacle
            cX = oX + Rnd(400) + 200
            ' Randomize height: Either Jump level (400) or Ground level (530)
            if Rnd(2) = 1 then cY = 400 else cY = 530
            
            ' Make the coin visible again for the new spawn!
            m.coin.visible = true 
        end if
        m.coin.translation = [cX, cY]

        ' --- TIGHTENED HITBOX MATH ---
        playerLeft = pX + 70 
        playerRight = pX + 160 
        playerTop = pY + 20
        playerBottom = pY + 120
        
        obsLeft = oX + 10
        obsRight = oX + m.obstacle.width - 10
        obsTop = oY + 10
        obsBottom = oY + m.obstacle.height - 10
        
        coinLeft = cX
        coinRight = cX + 40
        coinTop = cY
        coinBottom = cY + 40
        
        ' 1. Check Coin Collision
        if playerLeft < coinRight and playerRight > coinLeft and playerTop < coinBottom and playerBottom > coinTop then
            ' Only collect the score if the coin is currently visible
            if m.coin.visible = true then
                m.score = m.score + 10
                m.scoreLabel.text = "SCORE: " + m.score.toStr()
                
                ' Turn it invisible instead of teleporting it
                m.coin.visible = false 
            end if
        end if
        
        ' 2. Check Fatal Obstacle Collision
        if playerLeft < obsRight and playerRight > obsLeft and playerTop < obsBottom and playerBottom > obsTop then
            m.gameState = "crashing"
            m.crashFrameIndex = 1
            m.player.uri = "pkg:/images/dinocrash/f1.png"
        end if

    else if m.gameState = "crashing" then
        
        ' --- CRASH ANIMATION ---
        if m.animFrameCount MOD 6 = 0 then
            m.crashFrameIndex = m.crashFrameIndex + 1
            
            if m.crashFrameIndex > 8 then
                m.gameState = "gameover"
                m.timer.control = "stop"
                ' Send the final score to the popup!
                m.popup.finalScore = m.score
                m.popup.visible = true
                m.popup.setFocus(true)
            else
                m.player.uri = "pkg:/images/dinocrash/f" + m.crashFrameIndex.toStr() + ".png"
            end if
        end if

    end if
end sub