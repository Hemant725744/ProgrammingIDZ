
package Day2_1;

import java.util.Scanner;
public class task_6 {
    public static void main(String[] args) {
        Scanner input = new Scanner(System.in);
        int testcase = input.nextInt();

        for(int i =0 ;i<testcase;i++){
            int n = input.nextInt();
            System.out.println((n/2) + 1);
        }
        input.close();
    }
}
