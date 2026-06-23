sub init()
    m.angle = 0
    m.colors = ["0x0000FFFF", "0x808080FF", "0xFFFF00FF", "0x00FF00FF", "0xEE82EEFF"]
end sub

sub setupUI(nodes as Object)
    m.ui = nodes
    m.ui.ball.blendColor = m.colors[2] ' Set initial yellow color
end sub

sub rotateShooter(dir as String)
    ' 1. Calculate the new angle
    if dir = "right" then m.angle -= 5 else m.angle += 5
    if m.angle < -80 then m.angle = -80
    if m.angle > 80 then m.angle = 80
    
    ' 2. Rotate ONLY the parent group. Everything inside (arrow, line, ball) rotates with it.
    if m.ui <> invalid
        m.ui.group.rotation = m.angle * 0.0174533
        
        ' 3. Redraw dots only if they need to be refreshed (e.g., if you change length)
        ' Otherwise, keep the dots static inside the container
    end if
end sub

sub drawDottedLine()
    ui = m.ui
    ui.line.removeChildren(ui.line.getChildren(-1, 0))
    
    for i = 1 to 10
        dot = CreateObject("roSGNode", "Rectangle")
        ' MAKE THEM LARGE AND RED FOR DEBUGGING
        dot.width = 20 
        dot.height = 20 
        dot.color = "0xFF0000FF" 
        
        ' Position them
        dot.translation = [0, -(i * 60)]
        ui.line.appendChild(dot)
    end for
end sub