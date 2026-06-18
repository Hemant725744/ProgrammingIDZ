package Day3_2;
import java.util.Scanner;

class task_25 {
    public static void main(String[] args) {
        Scanner sc = new Scanner(System.in);

        int t = sc.nextInt();

        while (t-- > 0) {
            String time1 = sc.next();
            String time2 = sc.next();
            int dist = sc.nextInt();

            int h1 = Integer.parseInt(time1.substring(0, 2));
            int m1 = Integer.parseInt(time1.substring(3, 5));

            int h2 = Integer.parseInt(time2.substring(0, 2));
            int m2 = Integer.parseInt(time2.substring(3, 5));

            int total1 = h1 * 60 + m1;
            int total2 = h2 * 60 + m2;

            int wait = total1 - total2;

            double plan1 = wait + dist;
            double plan2;

            if (wait >= 2 * dist) {
                plan2 = wait;
            } else {
                plan2 = dist + wait / 2.0;
            }

            System.out.printf("%.1f %.1f%n", plan1, plan2);
        }

        sc.close();
    }
}