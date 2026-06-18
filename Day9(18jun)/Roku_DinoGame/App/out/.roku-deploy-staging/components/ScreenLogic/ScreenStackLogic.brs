sub InitScreenStack()
    m.screenStack = []
    m.cacheScreen = []
end sub

sub ShowScreen(node as object)
    print "in showScreen"
    prev = m.screenStack.Peek() ' take current screen from screen stack but don't delete it

    if prev <> invalid
        prev.visible = false ' hide current screen if it exist
    end if
    m.top.AppendChild(node) ' add new screen to scene
    ' show new screen
    node.visible = true
    node.SetFocus(true)
    m.screenStack.Push(node) ' add new screen to the screen stack

    print m.screenStack "screenStack1"
end sub

sub CloseScreen(node as object)
    print m.screenStack "screenStack2"
    if node = invalid or (m.screenStack.Peek() <> invalid and m.screenStack.Peek().IsSameNode(node))
        last = m.screenStack.Pop() ' remove screen from screenStack
        last.visible = false ' hide screen
        m.top.RemoveChild(last)
        ' take previous screen and make it visible
        prev = m.screenStack.Peek()
        if prev <> invalid
            prev.visible = true
            prev.SetFocus(true)
        end if
    end if

end sub

function GetCurrentScreen()
    return m.screenStack.Peek()
end function

function storeScreenIndex()
    Screenindex = m.screenStack.Count() - 1
    m.cacheScreen.Push(Screenindex)
end function

