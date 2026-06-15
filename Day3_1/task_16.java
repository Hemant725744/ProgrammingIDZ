package Day3_1;

import java.util.Scanner;

public class task_16 {
    public static void main(String[] args) {
         Scanner s = new Scanner(System.in);
        int t = s.nextInt();
        while (t-->0) {
            
            int limak = s.nextInt();
            int bob = s.nextInt();

            int count = 1;
            for(int i = 1; i>0 ; i++)
            {

                if(count>limak)
                {
                    System.out.println("Bob");
                   
                    break;
                }
                limak -= count;
                count++;
                if(count>bob)
                {
                    System.out.println("Limak");
                    
                    break;
                }
                bob -= count;  
                count++;
               
            }
            
        }
        s.close();
    }
}
