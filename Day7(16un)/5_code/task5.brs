sub Main()
    testCases = [
        "apple",
        "schtschurowskia",
        "polish",
        "tryst",
        "cry"
    ]

    
    for each word in testCases
        
      
        consonantStreak = 0
        isEasy = true '
        
       
        for i = 1 to Len(word)   
            letter = Mid(word, i, 1)
            
           
            if letter = "a" or letter = "e" or letter = "i" or letter = "o" or letter = "u" then
             
                consonantStreak = 0
            else
             
                consonantStreak = consonantStreak + 1
            end if
            
            if consonantStreak >= 4 then
                isEasy = false
                exit for 
            end if
            
        end for
        
       
        if isEasy = true then
            print "YES"
        else
            print "NO"
        end if
        
    end for
end sub