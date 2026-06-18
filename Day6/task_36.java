package Day6;
import java.util.Scanner;

public class task_36 {

    public static void main(String[] args) {
        Scanner sc = new Scanner(System.in);
        int T = sc.nextInt();

        
        for (int t = 0; t < T; t++) {
            int N = sc.nextInt(); 
            int M = sc.nextInt(); 
            
            // Read the cake grid as an array of strings
            String[] cake = new String[N];
            for (int i = 0; i < N; i++) {
                cake[i] = sc.next();
            }

            int costPattern1 = 0;
            int costPattern2 = 0; 

            
            for (int i = 0; i < N; i++) {
                for (int j = 0; j < M; j++) {
                    char currentCherry = cake[i].charAt(j);

                    // cost 1 start with red
                   
                    char expectedColor1;
                    if ((i + j) % 2 == 0) {
                        expectedColor1 = 'R';
                    } else {
                        expectedColor1 = 'G';
                    }

                   
                    if (currentCherry != expectedColor1) {
                        if (currentCherry == 'R' && expectedColor1 == 'G') {
                            costPattern1 += 5; 
                        } else if (currentCherry == 'G' && expectedColor1 == 'R') {
                            costPattern1 += 3; 
                        }
                    }

                    // cost 2 start with green
                    char expectedColor2;
                    if ((i + j) % 2 == 0) {
                        expectedColor2 = 'G';
                    } else {
                        expectedColor2 = 'R';
                    }

                   
                    if (currentCherry != expectedColor2) {
                        if (currentCherry == 'R' && expectedColor2 == 'G') {
                            costPattern2 += 5; 
                        } else if (currentCherry == 'G' && expectedColor2 == 'R') {
                            costPattern2 += 3; 
                        }
                    }
                }
            }

          
            int minCost = Math.min(costPattern1, costPattern2);
            System.out.println(minCost);
        }

        sc.close();
    }
}