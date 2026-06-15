package Day4;

import java.util.Scanner;

public class task_26 {
    public static void main(String[] args) {

        Scanner sc = new Scanner(System.in);

        
        int T = sc.nextInt();

        while (T-- > 0) {

    
            int N = sc.nextInt();
            int M = sc.nextInt();
            int K = sc.nextInt();

        
            if (N == 1 || M == 1) {
              
                System.out.println(K);
            }

            else {
               
                int L = N + M - 3;

                int ans;
               
                if (K % L == 0) {
                    ans = K / L;
                } else {
                   
                    ans = (K / L) + 1;
                }

                System.out.println(ans);
            }
            
        }sc.close();
        
    }
}
