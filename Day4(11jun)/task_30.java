package Day4;

import java.util.Scanner;

public class task_30 {
    public static void main(String[] args) {
        Scanner s = new Scanner(System.in);
        int t = s.nextInt();
        while (t-->0) {
            int n = s.nextInt();
        int sum =0;
        for(int i =1 ; i<=n ;i++)
        {
            if (n%i==0)
                sum+=i;
        }
        System.out.println(sum);
        }s.close();
        
    }
}
