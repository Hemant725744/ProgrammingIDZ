package Day5;

import java.util.Scanner;

public class task_43 {
    public static void main(String[] args) {
        Scanner s = new Scanner(System.in);

        int t = s.nextInt();

        while (t-- > 0) {

            int n = s.nextInt();

            int arr[] = new int[n];

            for (int i = 0; i < n; i++) {
                arr[i] = s.nextInt();
            }

            int strong = 0;

            for (int i = 0; i < n; i++) {

                int gcd = 0;

                for (int j = 0; j < n; j++) {

                    if (i == j)
                        continue;

                    if (gcd == 0) {
                        gcd = arr[j];
                    } else {

                        int a = gcd;
                        int b = arr[j];

                        while (b != 0) {
                            int temp = b;
                            b = a % b;
                            a = temp;
                        }

                        gcd = a;
                    }
                }

                if (gcd > 1) {
                    strong++;
                }
            }

            System.out.println(strong);
        }
        s.close();
    }
}
