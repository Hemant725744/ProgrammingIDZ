package Day3_2;
import java.util.Scanner;

public class task_24 {
    public static void main(String[] args) {
        Scanner sc = new Scanner(System.in);
        
        
        int t = sc.nextInt();
        
        while (t-- > 0) {
    
            int n = sc.nextInt();
            
            
            int[] a = new int[n];
            

            for (int i = 0; i < n; i++) 
            {
                a[i] = sc.nextInt();
            }
            
        
            int left = 0;
            int right = n - 1;
            int expected = 1; // We start looking for 1s
            boolean isValidRainbow = true;

            while (left <= right) 
            {
                
                if (a[left] != a[right] || a[left] > 7 || a[left] < 1) {
                    isValidRainbow = false;
                    break;
                }
                
              
                if (a[left] == expected) {
                   
                } else if (a[left] == expected + 1) {
            
                    expected++;
                } else {
                  
                    isValidRainbow = false;
                    break;
                }
                
                left++;
                right--;
            }
            
            
            if (expected != 7) {
                isValidRainbow = false;
            }

           
            if (isValidRainbow) {
                System.out.println("yes");
            } else {
                System.out.println("no");
            }
        }
        
        sc.close();
    }
}