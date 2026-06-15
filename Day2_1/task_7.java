package Day2_1;

import java.util.Scanner;

public class task_7 {
    public static void main(String[] args) {
        Scanner input = new Scanner(System.in);
        int testcase = input.nextInt();

        for(int i =0; i<testcase;i++)
        {
            int firstCount= input.nextInt();
            int secondCount= input.nextInt();
            System.out.println(firstCount +" "+(firstCount+secondCount));
        }
        input.close();
    }
}
