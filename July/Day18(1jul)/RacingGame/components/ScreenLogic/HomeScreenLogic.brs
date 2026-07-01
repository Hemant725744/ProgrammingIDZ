' sub showhomeScreen()
'     m.homeScreen = CreateObject("roSGNode", "homescreen")
'     ShowScreen(m.homeScreen)   
'     m.homeScreen.ObserveField("activeScreen", "homeScreen_onActiveScreenChanged") 
' end sub

' sub homeScreen_onActiveScreenChanged(field as object)
'     nxt = field.getData() 
'     CloseScreen(m.homeScreen)
'     if nxt = "reset" then
'         showhomeScreen()
'     end if
' end sub

sub showhomeScreen()
    m.homeScreen = CreateObject("roSGNode", "HomeScreen")   
    ' bs:disable-next-line: 1140
    ShowScreen(m.homeScreen)   
    m.homeScreen.ObserveField("activeScreen", "homeScreen_onActiveScreenChanged") 
end sub

sub homeScreen_onActiveScreenChanged(field as object)
    nxt = field.getData() 
    ' bs:disable-next-line: 1140
    CloseScreen(m.homeScreen)
    
    ' --- NEW ROUTING LOGIC ---
    if nxt = "reset" or nxt = "home" then
        showhomeScreen()
    else if nxt = "play" then
        showGameScreen()
    else if nxt = "shop" then
        showShopScreen()
    end if
end sub

' --- ADD THESE TWO NEW SUBROUTINES ---
sub showGameScreen()
    m.gameScreen = CreateObject("roSGNode", "GameScreen")
    ' bs:disable-next-line: 1140
    ShowScreen(m.gameScreen)
    m.gameScreen.ObserveField("activeScreen", "homeScreen_onActiveScreenChanged")
end sub

sub showShopScreen()
    m.shopScreen = CreateObject("roSGNode", "ShopScreen")
    ' bs:disable-next-line: 1140
    ShowScreen(m.shopScreen)
    m.shopScreen.ObserveField("activeScreen", "homeScreen_onActiveScreenChanged")
end sub

