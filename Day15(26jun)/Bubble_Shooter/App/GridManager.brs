
sub init()
    m.colors = ["0x0000FFFF", "0x808080FF", "0xFFFF00FF", "0x00FF00FF", "0xEE82EEFF"]
    generateGrid()
end sub

sub generateGrid()
    m.top.removeChildren(m.top.getChildren(-1, 0))
    rows = 6 
    cols = 21 
    ballSize = 60
    newGridArray = []
    for row = 0 to rows - 1
        tempRow = []
        for col = 0 to cols - 1
            ball = CreateObject("roSGNode", "Poster")
            ball.uri = "pkg:/images/ball.jpg"
            ball.width = ballSize : ball.height = ballSize
            ball.setField("blendColor", m.colors[Rnd(m.colors.count()) - 1])
            
            ' Positioning: Row 0 is at -100, so it starts off-screen
            xPos = (col * ballSize) + (row mod 2 * 30)
            yPos = (row * 50) - 100
            ball.translation = [xPos, yPos]
            
            m.top.appendChild(ball)
            tempRow.push({node: ball, color: ball.blendColor})
        end for
        newGridArray.push(tempRow)
    end for
    m.top.gridArray = newGridArray
end sub