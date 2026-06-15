package Day2_2;

import java.util.Scanner;

public class task_12 {
    public static void main(String[] args) {
        Scanner sc = new Scanner(System.in);
        int N = sc.nextInt();
        int K = sc.nextInt();
        int protein = 0;

        int[] arr = new int[N];
        for (int i = 0; i < arr.length; i++) 
        {
                    arr[i] = sc.nextInt(); 
        }
        boolean failed=false;
        for(int i =0 ; i<arr.length;i++)
        {
            protein = protein + arr[i];
            if(protein<K)
            {
                System.out.println("No" +(i+1));
                failed=true;
                break;

            }
            protein = protein-K;
        }
       
        if(!failed)
            System.out.println("yes");
        sc.close();
    }
}
