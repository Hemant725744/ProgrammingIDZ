package Day3_2;
import java.util.Scanner;

class task_22 {
    public static void main(String[] args) {
        Scanner sc = new Scanner(System.in);

        int t = sc.nextInt();

        while (t-- > 0) {

            int D = sc.nextInt();
            int d = sc.nextInt();
            int P = sc.nextInt();
            int Q = sc.nextInt();

            int blocks = D / d;
            int rem = D % d;

            int full = d * (blocks * P + Q * (blocks * (blocks - 1) / 2));
            int extra = rem * (P + blocks * Q);

            int ans = full + extra;

            System.out.println(ans);
        }

        sc.close();
    }
}