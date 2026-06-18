package Day6;
import java.util.Scanner;

public class task_37 {

    public static void main(String[] args) {
        Scanner sc = new Scanner(System.in);

        int T = sc.nextInt();

        for (int t = 0; t < T; t++) {
            int N = sc.nextInt();
            String S = sc.next();
            
            int initialOnes = 0;
            while (initialOnes < N && S.charAt(initialOnes) == '1') {
                initialOnes++;
            }
            
            int maxInRemainder = 0;
            int currentRun = 0;
            
            for (int i = initialOnes + 1; i < N; i++) {
                if (S.charAt(i) == '1') {
                    currentRun++;
                    if (currentRun > maxInRemainder) {
                        maxInRemainder = currentRun;
                    }
                } else {
                    currentRun = 0; 
                }
            }

            
            System.out.println(initialOnes + maxInRemainder);
        }

        sc.close();
    }
}