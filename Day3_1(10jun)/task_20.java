package Day3_1;

import java.util.Scanner;

public class task_20 {
    public static void main(String[] args) {
        Scanner s = new Scanner(System.in);
        int t = s.nextInt();
        
        while (t-->0) {
            int N = s.nextInt();
            int X = s.nextInt();
            int K = s.nextInt();
            int count=0;
                int[] ross = new int[N];
                int[] russ = new int[N];

                for(int j = 0 ; j<N;j++)
                {
                    ross[j]=s.nextInt();
                }
                for(int j = 0 ; j<N;j++)
                {
                    russ[j]=s.nextInt();
                }
                for(int j = 0 ; j<N;j++)
                {
                    if (Math.abs(ross[j]-russ[j]) <= K)
                        count++;
                }
            
            System.out.println((count>=X)?"YES":"NO");
            
        }
        s.close();
    }
}
