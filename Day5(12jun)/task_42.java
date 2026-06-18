package Day5;
import java.util.Scanner;

public class task_42 {

    static final long MOD = 1000000007L;

    public static void main(String[] args) {

        Scanner s = new Scanner(System.in);

        int t = s.nextInt();

        while (t-- > 0) {

            int n = s.nextInt();

            int factorial = 1;

            // Calculate (N + 1)!
            for (int i = 2; i <= n + 1; i++) {
                factorial = factorial * i;
            }

            // Final Answer = (N + 1)! - 1
            int answer = factorial - 1;

            System.out.println(answer);
        }

        s.close();
    }
}