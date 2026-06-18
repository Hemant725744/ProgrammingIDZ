import java.util.Scanner;

public class task_1 {
    public static void main(String[] args) {
        Scanner s = new Scanner(System.in);
        int t = s.nextInt();
        
        boolean[] results = new boolean[t];
        
        for (int i = 0; i<t; i ++) {
            int x = s.nextInt();
            int y = s.nextInt();

            if (x > (10 * y)) {
                results[i] = true;  
            } else {
                results[i] = false; 
            }
        }
         
        for (int i = 0; i<t; i++) {
            if (results[i]) {
                System.out.println("YES");
            } else {
                System.out.println("NO");
            }
        }
        s.close();
    }
}