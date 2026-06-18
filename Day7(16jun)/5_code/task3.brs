sub Main()
    ' 1. Mock the test cases directly as [X, Y] integer pairs
    testCases = [
        [5, 7], ' Test Case 1: Max 5, but there are 7 guards
        [6, 6], ' Test Case 2: Max 6, and there are 6 guards
        [9, 1]  ' Test Case 3: Max 9, and there is only 1 guard
    ]

    ' 2. Loop through each test case dynamically
    for each case in testCases
        
        ' Extract X (Max guards Ezio can control) and Y (Actual guards present)
        X = case[0]
        Y = case[1]
        
        ' 3. Apply the logic: Can Ezio handle them?
        if X >= Y then
            print "YES"
        else
            print "NO"
        end if
        
    end for
end sub