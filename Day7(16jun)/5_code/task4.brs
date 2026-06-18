sub Main()
    
    testCases = [
        { initialMoney: 10, withdrawals: [3, 5, 3, 2, 1] },
        { initialMoney: 6,  withdrawals: [10, 8, 6, 4] }
    ]

   
    for each case in testCases
        
        K = case.initialMoney
        requests = case.withdrawals
    
        resultString = ""
        
        for each amount in requests
            
            if K >= amount then
             
                K = K - amount
              
                resultString = resultString + "1"
            else
             
                resultString = resultString + "0"
            end if
            
        end for
        
        print resultString
        
    end for
end sub