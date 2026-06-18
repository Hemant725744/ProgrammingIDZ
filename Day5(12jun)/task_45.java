package Day5;
import java.util.Scanner;

public class task_45{

    public static void main(String[] args) {
        Scanner sc = new Scanner(System.in);
        
        
        int N = sc.nextInt();

        int count = 0;

        
        int startRange;
        
        if (N > 150) {
            startRange = N - 150; 
        } else {
            startRange = 1;      
        }

        for (int x = startRange; x <= N; x++) {
            
            
            int tempX = x;
            int sX = 0;
            while (tempX > 0) {
                sX += tempX % 10;
                tempX = tempX / 10;
            }

        
            int tempSx = sX;
            int ssX = 0;
            while (tempSx > 0) {
                ssX += tempSx % 10;
                tempSx = tempSx / 10;
            }

          
            if (x + sX + ssX == N) {
                count++;
            }
        }

        System.out.println(count);
        sc.close();
    }
}