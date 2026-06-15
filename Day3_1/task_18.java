package Day3_1;

import java.util.Scanner;

public class task_18 {
    public static void main(String[] args) {
        Scanner s = new Scanner(System.in);
        int t = s.nextInt();
        

        while(t-->0)
        {
            int N = s.nextInt();
            int B = s.nextInt();
            int max = 0;

            for(int i =0 ;i<N;i++)
            {
                int H = s.nextInt();
                int W = s.nextInt();
                int P = s.nextInt();
             

                if(P<=B)
                {
                    int currentMax = H*W;

                    if (currentMax>max)
                        max=currentMax;

                }

            }

            if(max==0)
                System.out.println("No Tablet");
            else
                System.out.println(max);
        }
        s.close();
    }

}
