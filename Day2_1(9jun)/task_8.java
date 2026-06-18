package Day2_1;

import java.util.Scanner;

public class task_8 {
    public static void main(String[] args) {
        Scanner input = new Scanner(System.in);
        int testcase = input.nextInt();

        for (int i = 0; i < testcase; i++) {

            int apples = input.nextInt();
            int oranges = input.nextInt();
            int k = input.nextInt();

            // Step 1: find absolute difference
            int diff = Math.abs(apples - oranges);

            // Step 2: use gold coins one by one
            for (int j = 0; j < k; j++) {
                if (diff == 0) break;
                diff--;
            }

            // Step 3: print final result
            System.out.println(diff);
        }

        input.close();
    }
}