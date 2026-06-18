package Day4;

import java.util.Scanner;

public class task_27 {
    public static void main(String[] args) {
        Scanner s = new Scanner(System.in);
        int t = s.nextInt();

        while (t-->0) {

            String str = s.next();
            char[] arr = str.toCharArray();
            int count = 0;
            for(int i = 0 ; i < arr.length ; i++)
            {
                if (arr[i]== '0')
                {
                    if((arr[i-1] == '0' ) && (arr[i+1] == '0' ))
                    {
                        count++;
                    }
                }
            }
            System.out.println(count);
            
        }
        s.close();
    }

}
