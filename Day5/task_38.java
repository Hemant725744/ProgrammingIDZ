package Day5;

import java.util.Scanner;

public class task_38 {
    public static void main(String[] args) {
        Scanner s= new Scanner(System.in);
        int t = s.nextInt();

        while (t-->0) {
            int size = s.nextInt();
            
            int maxCount=0;
            int arr[] = new int[size];
            boolean v[] = new boolean[size];
            for (int i = 0; i < v.length; i++) {
                arr[i]=s.nextInt();
            }

            for (int i = 0; i < arr.length; i++) 
            {
                int count=1;
                if(v[i])
                {
                    continue;
                }
                for (int j = i+1; j < v.length; j++) 
                {
                    if(arr[i]==arr[j])    
                    {
                    v[j]=true;
                    count++;
                    }    
                }        

                if(maxCount<count)
                    maxCount=count;
                
                
            }
            System.out.println(size-maxCount);

        }
        s.close();
    }
}
