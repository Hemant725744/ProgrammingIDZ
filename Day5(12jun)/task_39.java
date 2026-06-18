package Day5;

import java.util.Scanner;

public class task_39 {
    public static void main(String[] args) {
        Scanner s= new Scanner(System.in);
        int t = s.nextInt();

        while (t-->0) {
            int size =s.nextInt();
            int a = s.nextInt();
            int b = s.nextInt();
            int bobCount = 0 ;
            int aliceCount = 0;
            int common =0 ;

            int arr[] = new int[size];

            for (int i = 0; i < arr.length; i++) 
            {
                arr[i] = s.nextInt();
            }

            for (int i = 0; i < arr.length; i++) 
            {
                if((arr[i]%a==0) && (arr[i]%b==0))
                    common++;
                else if (arr[i]%a==0)
                    bobCount++;
                else if (arr[i]%b==0)
                    aliceCount++;
            }

            if(common>0)
                bobCount++;
              
            if (bobCount > aliceCount) {
                System.out.println("BOB");
            } else {
                System.out.println("ALICE");
            }
        }
        s.close();
    }
}
