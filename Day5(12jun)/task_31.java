package Day5;
import java.util.Scanner;

public class task_31 {
    public static void main(String[] args) {

        Scanner s = new Scanner(System.in);

        int t = s.nextInt();

        while (t-- > 0) {

            int n = s.nextInt();
            int k = s.nextInt();

            String str = s.next();

            int mismatch = 0;

          
            for (int i = 0; i < n / 2; i++) {
                if (str.charAt(i) != str.charAt(n - i - 1)) {
                    mismatch++;
                }
            }

            if (k < mismatch) {
                System.out.println("NO");
            }
            else if ((k - mismatch) % 2 == 0) {
                System.out.println("YES");
            }
            else {
                System.out.println("NO");
            }
        }s.close();
    }
}