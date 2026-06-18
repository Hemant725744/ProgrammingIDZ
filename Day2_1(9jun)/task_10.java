package Day2_1;
import java.util.Scanner;

public class task_10 {
    public static void main(String[] args) {

        Scanner input = new Scanner(System.in);
        int testcase = input.nextInt();

        for (int i = 1; i <= testcase; i++) {
            int start = input.nextInt();
            int end = input.nextInt();
            int totalCount = 0; 

            
            
            for (int j = start; j <= end; j++) {

                int num = j;
                
                
                int root = 1;
                while ((root) * (root) <= num) {
                    root++;
                }
                
             
                if (root * root != num) {
                    continue; 
                }
             

                int tempNum = num;      
                int tempRoot = root;    
                int revNum = 0;
                int count = 0; 

                
                while (tempNum > 0) {
                    int rem = tempNum % 10;
                    revNum = revNum * 10 + rem;
                    tempNum /= 10;
                }
                if (revNum == num) {
                    count++;
                }

               
                revNum = 0; 
                while (tempRoot > 0) {
                    int rem = tempRoot % 10;
                    revNum = revNum * 10 + rem;
                    tempRoot /= 10;
                }
                if (revNum == root) {
                    count++;
                }

                
                if (count == 2) {
                    totalCount++;
                }
            }

          
            System.out.println("Case #" + i + ": " + totalCount);
        }
        input.close();
    }
}