package Day5;

import java.util.*;

public class task_32 {
    public static void main(String[] args) {
        Scanner s = new Scanner(System.in);
        int t = s.nextInt();
        while (t-->0) 
        {
            int size = s.nextInt();
            int arr[]= new int[size];
            for (int i = 0; i < arr.length; i++) 
            {
                arr[i]=s.nextInt();   
            }
            
            for (int i = 0; i < arr.length; i++) 
            {
                
                for (int j = i+1; j < arr.length; j++) 
                {
                    if (arr[i]<=arr[j])
                    {
                        int temp =  arr[i];
                        arr[i] = arr[j];
                        arr[j] = temp;
                    }
                }
            }
            int sum=0;
            for (int i = 0; i < arr.length; i=i+2) 
            {
                sum = sum + arr[i];
            }
            
            System.out.println(sum);
        }
        s.close();
    }
}
