sub Main()
    ' 1. Mocking the input data exactly as the problem described
    inputData = [
        "4",
        "1 10",
        "10 1",
        "11 1",
        "97 7"
    ]

   
    T = inputData[0].ToInt()

 
    for i = 1 to T
  
        line = inputData[i]
        
   
        values = line.Split(" ")
   
        X = values[0].ToInt()
        Y = values[1].ToInt()
        
        
        if X > (10 * Y) then
            print "YES"
        else
            print "NO"
        end if
        
    end for
end sub