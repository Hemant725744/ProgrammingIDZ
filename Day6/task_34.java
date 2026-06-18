package Day6;

import java.util.Scanner;

public class task_34 {
    public static void main(String[] args) {
        Scanner sc = new Scanner(System.in);
        int T = sc.nextInt();
        for (int t = 0; t < T; t++) {
            
            int N = sc.nextInt();

            
            int[] goals = new int[N];
            for (int i = 0; i < N; i++) {
                goals[i] = sc.nextInt();
            }

            
            if (N < 2) {
                System.out.println("UNFIT");
                continue; // Move to the next test case
            }

            
            int minGoalsSoFar = goals[0];
            
            
            int maxImprovement = -1;

           
            for (int i = 1; i < N; i++) {
                
                if (goals[i] > minGoalsSoFar) {
                    int currentImprovement = goals[i] - minGoalsSoFar;
                    
                    
                    if (currentImprovement > maxImprovement) {
                        maxImprovement = currentImprovement;
                    }
                }

                
                if (goals[i] < minGoalsSoFar) {
                    minGoalsSoFar = goals[i];
                }
            }

            
            if (maxImprovement == -1) {
                System.out.println("UNFIT");
            } else {
                System.out.println(maxImprovement);
            }
        }

        sc.close();
    }
}
