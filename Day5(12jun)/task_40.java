package Day5;
import java.util.Scanner;

public class task_40 {
    public static void main(String[] args) {

        Scanner s = new Scanner(System.in);

       
        int t = s.nextInt();

        while (t-- > 0) {

            
            int n = s.nextInt();

           
            if (n % 2 == 0) {
                System.out.println("NO");
                continue;
            }

            System.out.println("YES");

            for (int i = 0; i < n; i++) 
            {

                StringBuilder row = new StringBuilder();

                for (int j = 0; j < n; j++) 
                {

                    if (i == j) 
                        row.append('0');
                    
                    else 
                    {    
                        int diff = (j - i + n) % n;
                        if (diff > 0 && diff <= (n - 1) / 2)
                            row.append('1'); 
                        else 
                            row.append('0'); // i loses to j
                        
                    }
                }

                System.out.println(row);
            }
        }

        s.close();
    }
}