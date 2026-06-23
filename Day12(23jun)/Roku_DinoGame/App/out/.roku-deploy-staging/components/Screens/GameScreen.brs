sub init()
    ' Nodes
    m.cloud1a = m.top.findNode("cloud1a")
    m.cloud1b = m.top.findNode("cloud1b")
    m.cloud2a = m.top.findNode("cloud2a")
    m.cloud2b = m.top.findNode("cloud2b")
    
    m.shakeOffset = 0
    m.shakeTimer = 0

    m.ground1 = m.top.findNode("ground1")
    m.ground2 = m.top.findNode("ground2")
    
    m.player = m.top.findNode("playerCollider")
    m.playerImage = m.top.findNode("playerBox")
    
    m.obstacle = m.top.findNode("obstacleCollider")
    m.obs1 = m.top.findNode("obstacleBox1")
    m.obs2 = m.top.findNode("obstacleBox2")
    m.obs3 = m.top.findNode("obstacleBox3")
    m.obs4 = m.top.findNode("obstacleBox4")
    
    m.coin = m.top.findNode("coinBox")
    m.scoreLabel = m.top.findNode("scoreLabel")
    m.timer = m.top.findNode("gameTimer")
    m.popup = m.top.findNode("popup")
    
    ' Physics & State
    m.gravity = 0.9
    m.yVelocity = 0.0
    m.isJumping = false
    m.animFrameCount = 0
    m.runFrameIndex = 1
    m.crashFrameIndex = 1
    m.gameState = "running"
    m.score = 0
    m.obsCounter = 0
    
    m.timer.observeField("fire", "gameLoop")
    m.popup.observeField("action", "handlePopupAction")


    
    startGame()
end sub

sub startGame()
    ' Explicitly ensure nodes are visible
    m.player.visible = true
    m.playerImage.visible = true
    m.player.translation = [200, 440]
    
    ' Reset Obstacle Collider
    m.obs1.translation = [-20, 0]
    m.obstacle.width = 60
    m.obstacle.height = 180
    m.obstacle.translation = [1280, 420]

    ' Reset Obstacle parent and children
    m.obstacle.translation = [1280, 400]
    m.obs1.visible = true
    m.obs2.visible = false
    m.obs3.visible = false
    m.obs4.visible = false
    
    ' Reset Coin
    m.coin.translation = [1600, 400]
    m.coin.visible = true 
    
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
    
    ' Target the Poster child, not the parent collider
    m.playerImage.uri = "pkg:/images/dinorun/f" + m.runFrameIndex.toStr() + ".jpg"
end if

        ' --- PARALLAX CLOUDS ---
        c1aX = m.cloud1a.translation[0] - 2
        c1bX = m.cloud1b.translation[0] - 2
        if c1aX <= -250 then c1aX = 1280
        if c1bX <= -250 then c1bX = 1280
        m.cloud1a.translation = [c1aX, 30]
        m.cloud1b.translation = [c1bX, 30]
        
        c2aX = m.cloud2a.translation[0] - 1 
        c2bX = m.cloud2b.translation[0] - 1
        if c2aX <= -350 then c2aX = 1280
        if c2bX <= -350 then c2bX = 1280
        m.cloud2a.translation = [c2aX, 120]
        m.cloud2b.translation = [c2bX, 120]

' --- GROUND PARALLAX ---
groundWidth = 1280 
g1X = m.ground1.translation[0] - 8 
g2X = m.ground2.translation[0] - 8

if g1X <= -groundWidth then g1X = groundWidth
if g2X <= -groundWidth then g2X = groundWidth

' Apply the shake effect only if the timer is active
currentGroundY = 520
if m.shakeTimer > 0 then
    currentGroundY = 520 + m.shakeOffset
    m.shakeTimer = m.shakeTimer - 1
    if m.shakeTimer = 0 then m.shakeOffset = 0
end if

m.ground1.translation = [g1X, currentGroundY]
m.ground2.translation = [g2X, currentGroundY]


' --- COIN MOVEMENT ---
' Get current position, subtract speed, and update as a full vector
currPos = m.coin.translation
newX = currPos[0] - 8

' Reset if off-screen (spawn to the right of the screen)
if newX <= -50 then
    ' Spawn at ground height (450) or jump height (350)
    newY = 450
    if Rnd(2) = 1 then newY = 350
    
    m.coin.translation = [1280 + Rnd(500), newY]
    m.coin.visible = true
else
    m.coin.translation = [newX, currPos[1]]
end if
        ' --- PHYSICS ---
        pX = m.player.translation[0]
        pY = m.player.translation[1]
        
        ' --- PHYSICS ---
' --- PHYSICS (In gameLoop) ---
if m.isJumping = true then
    m.yVelocity = m.yVelocity + m.gravity
    pY = pY + m.yVelocity
    
    if pY >= 440 then
        pY = 440
        m.yVelocity = 0.0
        m.isJumping = false
        
        ' TRIGGER THE SHAKE HERE!
        m.shakeOffset = 10 ' How many pixels to shake
        m.shakeTimer = 5   ' How many frames the shake lasts
    end if
    m.player.translation = [pX, pY]
end if
        
' --- DYNAMIC OBSTACLE SPAWNER ---
oX = m.obstacle.translation[0] - 8
if oX < -150 then 
    oX = 1280
    m.obsCounter = m.obsCounter + 1
    
    ' Hide all
    m.obs1.visible = false : m.obs2.visible = false : m.obs3.visible = false : m.obs4.visible = false
    
    if m.obsCounter >= 3 then
        m.obs4.visible = true
        ' Parent hit-box dimensions for Bird
        m.obs4.translation = [-20, -20]
        m.obstacle.width = 60
        m.obstacle.height = 65
        m.obstacle.translation = [oX, 300]
        m.obsCounter = 0
    else
        ' Spawn a random ground obstacle (1, 2, or 3)
            randType = Rnd(3)
            if randType = 1 then
                ' Tree (ob1) - Parent Y: 465, Width: 60
                m.obs1.visible = true
                m.obs1.translation = [-20, -20] ' Poster translation
                m.obstacle.width = 60
                m.obstacle.height = 140
                m.obstacle.translation = [oX, 400]
            else if randType = 2 then
                ' Cactus (ob2) - Parent Y: 485, Width: 90
                m.obs2.visible = true
                m.obs2.translation = [-20, -40] ' Poster translation
                m.obstacle.width = 60
                m.obstacle.height = 130
                m.obstacle.translation = [oX, 435]
            else
                ' Rock/Rabbit (ob3) - Parent Y: 495, Width: 110
                m.obs3.visible = true
                m.obs3.translation = [-25, -20] ' Poster translation
                m.obstacle.width = 70
                m.obstacle.height = 110
                m.obstacle.translation = [oX, 435]
            end if
    end if
else
    m.obstacle.translation = [oX, m.obstacle.translation[1]]
end if
        
        ' --- COLLISION MATH ---
        ' (Uses m.obstacle parent dimensions for collision)
        ' --- TIGHTENED HITBOX MATH ---
        ' Use the Rectangle Collider dimensions [90 wide, 70 high]
        ' --- TIGHTENED HITBOX MATH ---
' Player dimensions: width 70, height 70
playerLeft = pX
playerRight = pX + 70
playerTop = pY
playerBottom = pY + 70

' Obstacle dimensions: Parent width/height
obsLeft = m.obstacle.translation[0] + 10
obsRight = m.obstacle.translation[0] + m.obstacle.width - 10
obsTop = m.obstacle.translation[1] + 10
obsBottom = m.obstacle.translation[1] + m.obstacle.height - 10

' --- COIN COLLECTION (Paste this here) ---
    if m.coin.visible = true then
        coinLeft = m.coin.translation[0]
        coinRight = m.coin.translation[0] + 40
        coinTop = m.coin.translation[1]
        coinBottom = m.coin.translation[1] + 40

        if playerLeft <= coinRight and playerRight >= coinLeft and playerTop <= coinBottom and playerBottom >= coinTop then
            m.coin.visible = false
            m.score = m.score + 10
            m.scoreLabel.text = "SCORE: " + m.score.toStr()
        end if
    end if  

' 2. Check Fatal Obstacle Collision
if playerLeft < obsRight and playerRight > obsLeft and playerTop < obsBottom and playerBottom > obsTop then
    m.gameState = "crashing"
    m.crashFrameIndex = 1
    ' Target the Poster child node for the crash image
    m.playerImage.uri = "pkg:/images/dinocrash/f1.png"
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
                m.playerImage.uri = "pkg:/images/dinocrash/f" + m.crashFrameIndex.toStr() + ".png"
            end if
        end if
    end if
end sub