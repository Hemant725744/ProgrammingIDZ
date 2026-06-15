package Day5;

import java.util.Scanner;

public class task_33 {
    public static void main(String[] args) {
        Scanner s = new Scanner(System.in);
        int t = s.nextInt();

        while (t-- > 0) {
            int N = s.nextInt();
            int M = s.nextInt();

            int count = 0;

            for (int i = 1; i <= N; i++) {
                for (int j = 1; j <= M; j++) {
                    if ((i + j) % 2 != 0) {
                        count++;
                    }
                }
            }

            System.out.println(count + "/" + (N * M));
        }
    }
}