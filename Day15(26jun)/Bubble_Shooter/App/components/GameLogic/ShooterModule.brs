sub init()

    m.angle = 0
    m.score = 0
    m.colors = ["0x0000FFFF", "0x808080FF", "0xFFFF00FF", "0x00FF00FF", "0xEE82EEFF"]
    m.keys = { left: false, right: false, ok: false }
    m.isShooting = false
    m.isGameOver = false
    ' The Treadmill Variables
    m.baseY = 20        ' The absolute starting position of the container
    m.scrollOffset = 0  ' Accumulates from 0 to 50
    m.timeElapsed = 0
    m.baseY = 20        
    m.scrollOffset = 0

    m.fallingBubbles = []
    m.frameCount = 0

end sub



sub handleInput(data as Object)
    if data.key = "left" then m.keys.right = data.press
    if data.key = "right" then m.keys.left = data.press
    if data.key = "OK" then m.keys.ok = data.press
end sub

sub setupUI(nodes as Object)
    m.ui = nodes
    m.nextColor = m.colors[Rnd(m.colors.count()) - 1]
    if m.ui.nextBall <> invalid then m.ui.nextBall.setField("blendColor", m.nextColor)
    if m.ui.ball <> invalid then m.ui.ball.setField("blendColor", m.colors[Rnd(m.colors.count()) - 1])
    m.vx = 0 : m.vy = 0

    m.timer = m.top.findNode("gameLoop")
    m.timer.observeField("fire", "onTimerFire")

    calculateAimLine()
end sub



sub calculateAimLine()
    m.ui.line.removeChildren(m.ui.line.getChildren(-1, 0))
    startX = 640
    startY = 620
    angleRad = m.angle * 0.0174533
    dirX = -(sin(angleRad))
    dirY = -(cos(angleRad))
    currX = startX
    currY = startY
    stepSize = 35

    gridManager = m.top.getScene().findNode("gridManager")
    if gridManager = invalid then return
    bubbles = gridManager.getChildren(-1, 0)
    for i = 1 to 75
        currX += (dirX * stepSize)
        currY += (dirY * stepSize)
        if currX <= 30 or currX >= 1250 then
            dirX = -dirX
            currX += (dirX * stepSize)
        end if
        ' --- -100 TRICK FIX: Allow line to go off-screen ---
        if currY <= (m.baseY + m.scrollOffset - 100) then exit for
        hit = false
        for each bubble in bubbles
            bTrans = bubble.translation
            bx = bTrans[0] + 40 + 30  
            by = bTrans[1] + m.baseY + m.scrollOffset + 30
            if sqr((currX - bx)^2 + (currY - by)^2) < 45 then
                hit = true
                exit for
            end if
        end for
        if hit then exit for
        dot = CreateObject("roSGNode", "Rectangle")
        dot.width = 6 : dot.height = 6 : dot.color = "0xFFFFFF99"
        dot.translation = [currX, currY]
        m.ui.line.appendChild(dot)
    end for
end sub

sub onTimerFire()
    if m.isGameOver then return
    
    ' ---> 1. YOU MUST FIND THE GRIDMANAGER FIRST <---
    gridManager = m.top.getScene().findNode("gridManager")
    if gridManager = invalid then return
    
    ' --- FASTER BLINKING MATH ---
    m.frameCount += 1
    if m.frameCount > 30 then m.frameCount = 0
    
    ' Swaps state every 15 frames (4 times a second)
    blinkToggle = (m.frameCount > 15) 
    
    ' --- 1. SMOOTH ACCELERATING GRAVITY LOOP ---
    for i = m.fallingBubbles.count() - 1 to 0 step -1
        
        ' 1. Grab the whole data package
        dropData = m.fallingBubbles[i]
        
        ' 2. Extract the physical ball out of the package
        node = dropData.bubbleNode 
        
        ' 3. Gravity acceleration: Speed increases by 0.8 every frame
        dropData.vy += 0.8 
        
        oldPos = node.translation
        newY = oldPos[1] + dropData.vy 
        node.translation = [oldPos[0], newY]
        
        ' Delete permanently when completely off screen
        if newY > 720 then
            m.top.removeChild(node)
            m.fallingBubbles.delete(i)
        end if
    end for
    
    ' --- 2. Danger Zone Blinking (500 to 540) ---
    gridArray = gridManager.gridArray
    if gridArray <> invalid then
        for r = 0 to gridArray.count() - 1
            if gridArray[r] <> invalid then
                for c = 0 to gridArray[r].count() - 1
                    if gridArray[r][c] <> invalid and gridArray[r][c].node <> invalid then
                        node = gridArray[r][c].node
                        
                        ' Calculate exactly how far down this specific bubble is
                        bottomY = node.translation[1] + m.baseY + m.scrollOffset + 60
                        
                        ' ---> BLINK IF PAST 500 <---
                        if bottomY >= 500 then
                            if blinkToggle then node.opacity = 0.3 else node.opacity = 1.0
                        else
                            node.opacity = 1.0 ' Ensure safe balls remain completely solid
                        end if
                    end if
                end for
            end if
        end for
    end if
    ' --- END ANIMATION LOOP ---

    ' --- THE TREADMILL SCROLL LOGIC ---
    if not m.isShooting then
        m.timeElapsed += 0.016
        
        if m.timeElapsed >= 4.0 then
            ' Move the entire container dynamically
            m.scrollOffset += 0.1 
            gridManager.translation = [40, m.baseY + m.scrollOffset]
            
            ' When we hit exactly one row height (50px)
            if m.scrollOffset >= 50 then
                spawnNewRow(gridManager)
                ' Reset the accumulator. The container snaps back, but the 
                ' bubbles moved internally, creating a seamless endless loop!
                m.scrollOffset = 0 
                gridManager.translation = [40, m.baseY]
            end if
            
            if checkGameOver(gridManager, m.scrollOffset) then
                m.isGameOver = true
                print "GAME OVER"
                m.ui.line.visible = false
                return
            end if
        end if
    end if
    
    ' --- STATE 1: AIMING ---
    if not m.isShooting then
        moved = false
        rotationSpeed = 0.8 
        
        if m.keys.left then
            m.angle -= rotationSpeed
            moved = true
        else if m.keys.right then
            m.angle += rotationSpeed
            moved = true
        end if
        
        if m.angle < -80 then m.angle = -80
        if m.angle > 80 then m.angle = 80
        
        if moved or m.timeElapsed >= 4.0 then
            m.ui.group.rotation = m.angle * 0.0174533
            calculateAimLine()
        end if
        
        if m.keys.ok then
            m.keys.ok = false 
            shootBall()
        end if
        return
    end if
    
    ' --- STATE 2: SHOOTING (Ball in air) ---
    ballSize = 60
    hasCollided = false
    
    ballPos = m.ui.ball.translation
    newX = ballPos[0] + m.vx
    newY = ballPos[1] + m.vy
    m.ui.ball.translation = [newX, newY]
    
    ' Check if it hits the "roof"
    if newY <= (m.baseY + m.scrollOffset - 80) then 
        hasCollided = true
    else
        ' Bubble Collision
        for each bubble in gridManager.getChildren(-1, 0)
            bTrans = bubble.translation
            ' Correct Center Calculation:
            ' Grid bubbles are at translation + base offset + scrollOffset
            bubbleCenterX = bTrans[0] + 40 + 30
            bubbleCenterY = bTrans[1] + m.baseY + m.scrollOffset + 30
            
            ballCenterX = newX + 30
            ballCenterY = newY + 30
            
            dist = sqr((ballCenterX - bubbleCenterX)^2 + (ballCenterY - bubbleCenterY)^2)
            if dist <= 55 then
                hasCollided = true
                exit for
            end if
        end for
    end if
    
    if hasCollided then
        snapped = stickBallToGrid(newX, newY, m.ui.ball.blendColor, gridManager, 40, m.baseY + m.scrollOffset, ballSize)
        
        matches = []
        findMatches(snapped.r, snapped.c, m.ui.ball.blendColor, gridManager.gridArray, matches)
        
        if matches.count() >= 3 then
            gridArray = gridManager.gridArray
            for each item in matches
                if item.node <> invalid then gridManager.removeChild(item.node)
                gridArray[item.r][item.c] = invalid
            end for
            gridManager.gridArray = gridArray
            
            m.score += (matches.count() * 10)
            m.ui.scoreLabel.text = "SCORE: " + m.score.toStr()
            
            removeFloatingBubbles(gridManager)
        end if
        
        if checkGameOver(gridManager, m.scrollOffset) then
            m.isGameOver = true
            print "GAME OVER"
            m.ui.line.visible = false
            return
        end if
    
        resetBall()
        return
    end if
    
    ' Wall Bouncing    
    if newX <= 0 or newX >= 1220 then m.vx = -m.vx
end sub

sub spawnNewRow(gridManager as Object)

    gridArray = gridManager.gridArray
    if gridArray = invalid then gridArray = []
   
    currentParity = getGridParity(gridArray)
    newRowOffset = 0
    if currentParity = 0 then newRowOffset = 30
   
    newRow = []
    for i = 0 to 21
        color = m.colors[Rnd(m.colors.count()) - 1]
        newBubble = CreateObject("roSGNode", "Poster")
        newBubble.uri = "pkg:/images/ball.jpg"
        newBubble.width = 60
        newBubble.height = 60
       
        if newBubble <> invalid then
            newBubble.setField("blendColor", color)
            xPos = (i * 60) + newRowOffset
           
            ' --- -100 TRICK FIX: Spawn the new row off-screen ---
            newBubble.translation = [xPos, -100]
           
            gridManager.appendChild(newBubble)
            newRow.push({ node: newBubble, color: newBubble.blendColor })
        end if
    end for
   
    gridArray.unshift(newRow)
   
    if gridArray.count() > 1 then
        for r = 1 to gridArray.count() - 1
            if gridArray[r] <> invalid then
                for c = 0 to gridArray[r].count() - 1
                    if gridArray[r][c] <> invalid and gridArray[r][c].node <> invalid then
                        oldTrans = gridArray[r][c].node.translation
                        gridArray[r][c].node.translation = [oldTrans[0], oldTrans[1] + 50]
                    end if
                end for
            end if
        end for
    end if

    gridManager.gridArray = gridArray

end sub

sub shootBall()
    angleRad = m.angle * 0.0174533
    speed = 15
    m.vx = -(speed * sin(angleRad))
    m.vy = -(speed * cos(angleRad))
    m.ui.line.removeChildren(m.ui.line.getChildren(-1, 0))
    m.top.getScene().appendChild(m.ui.ball)
    m.ui.ball.translation = [610, 590]
    m.isShooting = true
end sub

sub resetBall()
    ' STEP 1: The current throwing ball steals the color that the next ball was holding.
    m.ui.ball.setField("blendColor", m.nextColor)
   
    ' STEP 2: The system generates a brand new random color from the array.
    m.nextColor = m.colors[Rnd(m.colors.count()) - 1]
   
    ' STEP 3: The next ball indicator updates its visual color to show the new upcoming color.
    m.ui.nextBall.setField("blendColor", m.nextColor)
   
    ' STEP 4: The throwing ball is placed back into the "cannon" (m.ui.group)
    ' and its position is reset to the bottom center.
    m.ui.group.appendChild(m.ui.ball)
    m.ui.ball.translation = [-30, -30]
   
    ' STEP 5: Unlock the controls so the player can shoot again.
    m.isShooting = false
    calculateAimLine()
end sub


' --- HELPER: Checks physical grid parity to prevent shuffling ---

function getGridParity(gridArray as Object) as Integer

    if gridArray <> invalid and gridArray.count() > 0 then

        for c = 0 to gridArray[0].count() - 1
            if gridArray[0][c] <> invalid and gridArray[0][c].node <> invalid then
                if (Int(gridArray[0][c].node.translation[0]) mod 60) <> 0 then return 30
                return 0
            end if
        end for
    end if
    return 0
end function

function stickBallToGrid(ballX, ballY, ballColor, gridManager, gridX, gridY, ballSize) as Object  
    relX = ballX - gridX
    relY = ballY - gridY

    ' --- -100 TRICK FIX: Map the physical Y back to the Array Row ---
    row = Int((relY + 100 + (ballSize / 2)) / 50)
    if row < 0 then row = 0
   
    gridArray = gridManager.gridArray
    if gridArray = invalid then gridArray = []
   
    baseOffset = getGridParity(gridArray)
    rowOffset = baseOffset
    if (row mod 2 <> 0) then
        if baseOffset = 0 then rowOffset = 30 else rowOffset = 0
    end if
   
    col = Int((relX - rowOffset + (ballSize / 2)) / ballSize)
    if col < 0 then col = 0
    if col > 20 then col = 20
   
    while gridArray.count() <= row
        gridArray.push([])
    end while
    while gridArray[row].count() <= col
        gridArray[row].push(invalid)
    end while
   
    if gridArray[row][col] <> invalid then
        row = row + 1
        rowOffset = baseOffset
        if (row mod 2 <> 0) then

            if baseOffset = 0 then rowOffset = 30 else rowOffset = 0
        end if
        while gridArray.count() <= row
            gridArray.push([])
        end while
        while gridArray[row].count() <= col
            gridArray[row].push(invalid)
        end while
    end if

    snapX = (col * ballSize) + rowOffset
   
    ' --- -100 TRICK FIX: Re-apply offset when snapping visually ---
    snapY = (row * 50) - 100
   
    newBubble = CreateObject("roSGNode", "Poster")
    newBubble.uri = "pkg:/images/ball.jpg"
    newBubble.width = ballSize
    newBubble.height = ballSize
    newBubble.setField("blendColor", ballColor)
    newBubble.translation = [snapX, snapY]

    gridManager.appendChild(newBubble)
    gridArray[row][col] = { node: newBubble, color: ballColor }
    gridManager.gridArray = gridArray
   
    return { r: row, c: col }
end function

sub findMatches(r as Integer, c as Integer, targetColor as Dynamic, gridArray as Object, matches as Object)
    if r < 0 or r >= gridArray.count() then return
    if c < 0 or c >= gridArray[r].count() then return
    cell = gridArray[r][c]
    if cell = invalid then return
    if cell.color <> targetColor then return
   
    for each matchItem in matches
        if matchItem.r = r and matchItem.c = c then return
    end for
   
    matches.push({ r: r, c: c, node: cell.node })
   
    baseOffset = getGridParity(gridArray)
    isOddRow = false
    if (r mod 2 <> 0) then isOddRow = true
    if baseOffset = 30 then isOddRow = not isOddRow
   
    findMatches(r, c - 1, targetColor, gridArray, matches)
    findMatches(r, c + 1, targetColor, gridArray, matches)
   
    if isOddRow then
        findMatches(r - 1, c, targetColor, gridArray, matches)
        findMatches(r - 1, c + 1, targetColor, gridArray, matches)
        findMatches(r + 1, c, targetColor, gridArray, matches)
        findMatches(r + 1, c + 1, targetColor, gridArray, matches)
    else
        findMatches(r - 1, c - 1, targetColor, gridArray, matches)
        findMatches(r - 1, c, targetColor, gridArray, matches)
        findMatches(r + 1, c - 1, targetColor, gridArray, matches)
        findMatches(r + 1, c, targetColor, gridArray, matches)
    end if
end sub


sub removeFloatingBubbles(gridManager as Object)

    gridArray = gridManager.gridArray
    if gridArray = invalid or gridArray.count() = 0 then return

    baseOffset = getGridParity(gridArray)

    visited = []
    for r = 0 to gridArray.count() - 1
        rowVisited = []
        if gridArray[r] <> invalid then
            for c = 0 to gridArray[r].count() - 1
                rowVisited.push(false)
            end for
        end if
        visited.push(rowVisited)
    end for
    queue = []
    if gridArray[0] <> invalid then
        for c = 0 to gridArray[0].count() - 1
            if gridArray[0][c] <> invalid then
                queue.push({r: 0, c: c})
            end if
        end for
    end if
    while queue.count() > 0
        curr = queue.shift()
        r = curr.r
        c = curr.c
        if not visited[r][c] then
            visited[r][c] = true
            isOddRow = false
            if (r mod 2 <> 0) then isOddRow = true
            if baseOffset = 30 then isOddRow = not isOddRow
            offsets = []
            offsets.push({dr: 0, dc: -1})
            offsets.push({dr: 0, dc: 1})
            if isOddRow then
                offsets.push({dr: -1, dc: 0})
                offsets.push({dr: -1, dc: 1})
                offsets.push({dr: 1, dc: 0})
                offsets.push({dr: 1, dc: 1})
            else
                offsets.push({dr: -1, dc: -1})
                offsets.push({dr: -1, dc: 0})
                offsets.push({dr: 1, dc: -1})
                offsets.push({dr: 1, dc: 0})
            end if
            for each offset in offsets
                nr = r + offset.dr
                nc = c + offset.dc
                if nr >= 0 and nr < gridArray.count() then
                    if gridArray[nr] <> invalid and nc >= 0 and nc < gridArray[nr].count() then
                        if gridArray[nr][nc] <> invalid and not visited[nr][nc] then
                            queue.push({r: nr, c: nc})
                        end if
                    end if
                end if
            end for
        end if
    end while
    for r = 0 to gridArray.count() - 1
        if gridArray[r] <> invalid then
            for c = 0 to gridArray[r].count() - 1
                if gridArray[r][c] <> invalid and not visited[r][c] then
                    if gridArray[r][c].node <> invalid then
                        ' ---> ONLY DROP THE FLOATING ONES <---
                        triggerDrop(gridArray[r][c].node, gridManager)
                    end if
                    gridArray[r][c] = invalid
                end if
            end for
        end if
    end for
    gridManager.gridArray = gridArray
end sub

function checkGameOver(gridManager, scrollOffset) as Boolean
    ' Add this safety net:
    if scrollOffset = invalid then scrollOffset = 0
    gridArray = gridManager.gridArray
    if gridArray = invalid then return false
    for r = 0 to gridArray.count() - 1
        if gridArray[r] <> invalid then
                for c = 0 to gridArray[r].count() - 1
                if gridArray[r][c] <> invalid and gridArray[r][c].node <> invalid then
                    bubbleBottomY = gridArray[r][c].node.translation[1] + 20 + scrollOffset + 60                   
                    ' ---> END GAME AT 540 <---
                    if bubbleBottomY >= 540 then
                        return true
                    end if
                end if
            end for
        end if
    end for
    return false
end function


' sub triggerDrop(node as Object, gridManager as Object)
'     if node = invalid then return
'     ' Calculate exact screen position
'     globalX = node.translation[0] + 40
'     globalY = node.translation[1] + m.baseY + m.scrollOffset
'     ' Detach from grid, attach to main scene
'     gridManager.removeChild(node)
'     m.top.appendChild(node)
'     node.translation = [globalX, globalY]
'     ' ---> NEW: Track the node AND its gravity speed <---
'     m.fallingBubbles.push({
'         bubbleNode: node,
'         vy: 3 ' Starts falling at 0 speed for a smooth takeoff
'     })
' end sub
sub triggerDrop(node as Object, gridManager as Object)
    if node = invalid then return
    
    ' Calculate absolute screen coordinates using sceneBoundingRect
    ' This is the most reliable way to position a node after detaching
    rect = node.sceneBoundingRect()
    
    gridManager.removeChild(node)
    m.top.appendChild(node)
    node.translation = [rect.x, rect.y]
    
    ' --- THE JUMP EFFECT ---
    ' A negative value (e.g., -5) makes the bubble jump UP 
    ' before the gravity loop pulls it DOWN.
    m.fallingBubbles.push({
        bubbleNode: node,
        vy: -5 
    })
end sub