sub Main()
    screen = CreateObject("roSGScreen")
    port = CreateObject("roMessagePort")
    screen.setMessagePort(port)
    'ADD Globals here------
    ' m.global = screen.getGlobalnode()
    ' m.global.addfields()
    '-------------------
    scene = screen.CreateScene("MainScene")
    screen.show()
    'vscode_rdb_on_device_component_entry


    while true
        msg = wait(0, port)
        if type(msg) = "roSGScreenEvent"    
            if msg.isScreenClosed()
                exit while
            end if
        endif 
    end while

end sub

' In short, source/Main.brs is the "On Switch" for your app.

' It does exactly three things:

' Creates the blank TV screen.

' Tells the TV: "Go find MainScene and draw it."

' Traps the app in a loop so it stays open until the user actively presses the Back button to leave.

' That is its entire job. Once it loads MainScene, it hands over all control to your SceneGraph UI and just sits in the background keeping the lights on.