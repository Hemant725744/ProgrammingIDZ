sub showhomeScreen()
    m.homeScreen = CreateObject("roSGNode", "homescreen")
    ShowScreen(m.homeScreen)   
    m.homeScreen.ObserveField("activeScreen", "homeScreen_onActiveScreenChanged") 
end sub

sub homeScreen_onActiveScreenChanged(field as object)
    nxt = field.getData() 
    CloseScreen(m.homeScreen)
    if nxt = "reset" then
        showhomeScreen()
    end if
end sub

