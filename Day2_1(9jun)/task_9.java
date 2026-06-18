package Day2_1;

import java.util.Scanner;

public class task_9 {
    public static void main(String[] args) {
        Scanner input = new Scanner(System.in);
        int testcase = input.nextInt();
        int[] arr = new int[6];
        for (int i = 0 ; i <testcase;i++){
            for (int j = 0 ; j < arr.length;j++)
            {
                arr[j]=input.nextInt();
            }
            
            if ((arr[2] == arr[0] && arr[3] == arr[1]) || (arr[2] == arr[1] && arr[3] == arr[0])) {
                System.out.println(1);
            } 
       
            else if ((arr[4] == arr[0] && arr[5] == arr[1]) || (arr[4] == arr[1] && arr[5] == arr[0])) {
                System.out.println(2);
            } 
            
            else {
                System.out.println(0);
            }

        }
        input.close();
    }
}
// a b a1 b1 a2 b2
// 0 1 2  3  4  5