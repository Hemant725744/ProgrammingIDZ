sub Main()
    ' 1. Mocking the input for both Test Case 1 and Test Case 2
    testCases = [
        [1, 2, 3, 4, 5], ' Test Case 1: 5 soldiers
        [2, 3, 4]        ' Test Case 2: 3 soldiers
    ]

    ' 2. Loop through each army (test case)
    for each army in testCases
        
        ' 3. Reset our counters for the current army
        luckyCount = 0
        unluckyCount = 0

        ' 4. Loop through every single soldier in this specific army
        for each weapons in army
            
            ' 5. Check if the number of weapons is Even or Odd
            if weapons MOD 2 = 0 then
                ' If it is even, they are lucky
                luckyCount = luckyCount + 1
            else
                ' If it is odd, they are unlucky
                unluckyCount = unluckyCount + 1
            end if
            
        end for

        ' 6. Final Battle Logic: Are there strictly more lucky soldiers?
        if luckyCount > unluckyCount then
            print "READY FOR BATTLE"
        else
            print "NOT READY"
        end if
        
        ' 7. Print a dashed line to separate the test case outputs cleanly
        print "-------------------"
        
    end for
end sub