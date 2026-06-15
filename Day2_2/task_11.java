package Day2_2;

import java.util.Scanner;

public class task_11 {
    public static void main(String[] args) {
        Scanner s = new Scanner(System.in);
        
            int T = s.nextInt();
            
            while (T-- > 0) {
                int p = s.nextInt();
                int count = 0;
                int[] price = {2048, 1024, 512, 256, 128, 64, 32, 16, 8, 4, 2, 1};
                
                for (int i = 0; i < price.length; i++) {
                    
                    if (p >= price[i]) { 
                        count = count + (p / price[i]);
                        p = p % price[i];
                    }

                    if (p == 0) {
                        break;
                    }
                }
                System.out.println(count);
            }
             s.close();
        }
    }
       
    
