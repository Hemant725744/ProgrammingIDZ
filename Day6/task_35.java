package Day6;
import java.util.Scanner;

public class task_35 {

    public static void main(String[] args) {
        Scanner sc = new Scanner(System.in);
       
        int T = sc.nextInt();

        for (int t = 0; t < T; t++) 
        {
            int N = sc.nextInt();

            int[] knightX = new int[N];
            int[] knightY = new int[N];
            for (int i = 0; i < N; i++) 
            {
                knightX[i] = sc.nextInt();
                knightY[i] = sc.nextInt();
            }

            int A = sc.nextInt();
            int B = sc.nextInt();

            // is king check or not
            boolean isKingInCheck = false;
            for (int i = 0; i < N; i++) 
            {
                int diffX = Math.abs(knightX[i] - A);
                int diffY = Math.abs(knightY[i] - B);

                
                if ((diffX == 1 && diffY == 2) || (diffX == 2 && diffY == 1)) 
                {
                    isKingInCheck = true;
                    break; 
                }
            }

           
            if (!isKingInCheck) 
            {
                System.out.println("NO");
                continue; 
            }

            //  Checkhe neighbours
     
            int[] dX = {0, 0, 1, -1, 1, -1, 1, -1};
            int[] dY = {1, -1, 0, 0, 1, 1, -1, -1};

            boolean canEscape = false;


            for (int i = 0; i < 8; i++) 
            {
                
                int neighborX = A + dX[i];
                int neighborY = B + dY[i];

                boolean neighborIsSafe = true;

               
                for (int j = 0; j < N; j++) 
                {
                    int diffX = Math.abs(knightX[j] - neighborX);
                    int diffY = Math.abs(knightY[j] - neighborY);

                    
                    if ((diffX == 1 && diffY == 2) || (diffX == 2 && diffY == 1))
                    {
                        neighborIsSafe = false;
                        break; 
                    }
                }

                
                if (neighborIsSafe) 
                {
                    canEscape = true;
                    break; 
                }
            }

            // Can escape or not
            
            if (!canEscape) 
            {
                System.out.println("YES"); // Checkmate!
            } else 
            {
                System.out.println("NO");  
            }
        }
        
        sc.close();
    }
}