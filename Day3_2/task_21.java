package Day3_2;

import java.util.Scanner;

public class task_21 {
    public static void main(String[] args)
    {
        Scanner s = new Scanner(System.in);
        int t = s.nextInt();
        
        while (t-->0)
        {
            double side = s.nextInt();
            double sum=0;
            for(int i = 1;i<=side;i++)
            {
                if(i%side!=2)
                {
                    sum = sum + Math.pow((side - i + 1), 2);
                }
            }
            System.out.println((int)sum);
            
        }
        s.close();
    }
}
