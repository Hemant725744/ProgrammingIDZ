package Day5;
import java.util.Scanner;

public class task_41 {

    public static void main(String[] args) {

        Scanner s = new Scanner(System.in);

        int t = s.nextInt();

        while (t-- > 0) {

            long A = s.nextLong();
            long B = s.nextLong();
            long N = s.nextLong();

            
            long target = A ^ B;

            
            if (target == 0) {
                System.out.println(0);
            }

            else if (target < N) {
                System.out.println(1);
            }

            else if ((target ^ 1) < N) {
                System.out.println(2);
            }

            // Case 4:
            // Not possible
            else {
                System.out.println(-1);
            }
        }

        s.close();
    }
}