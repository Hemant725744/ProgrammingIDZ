package Day3_1;

import java.util.Scanner;

public class task_19 {
    public static void main(String[] args) {
        Scanner s = new Scanner(System.in);
        int t = s.nextInt();

        while(t-->0)
        {
            int size = s.nextInt();
            int[] arr = new int[size]; 
            for(int i =0;i<arr.length;i++)
            {
                arr[i]=s.nextInt();
            }
            int maxCount=0;
            boolean[] frequency = new boolean[size];
            for(int i =0;i<arr.length;i++)
            {
                int count=1;
                if(frequency[i])
                    continue;

                for(int j=i+1; j<arr.length;j++)
                {
                    if (arr[i] == arr[j]){
                        frequency[j]=true;
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
