package Day3_2;
import java.util.Scanner;

public class task_23 
{
    public static void main(String[] args) 
    {
        Scanner s = new Scanner(System.in);
        int t = s.nextInt();
        // Read the total number of queries
        while(t-->0) {
            int n = s.nextInt();
            
            // Process each query
            for (int iteration = 0; iteration < n; iteration++) {
                int i = s.nextInt();
                int j = s.nextInt();
                
                int distance = 0;
            
                while (i != j) {
                    if (i > j) {
                        i /= 2; 
                    } else {
                        j /= 2;
                    }
                    distance++;
                }
                
                
                System.out.println(distance);
            }
        }
        
        s.close();
    }
}