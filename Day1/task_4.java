import java.util.Scanner;

public class task_4 {
    public static void main(String[] args) {
        Scanner s = new Scanner(System.in);
        int t = s.nextInt();
        
        String[] results = new String[t]; 
        
        for (int z = 0; z < t; z++) {
            int n = s.nextInt();
            int k = s.nextInt();
            int[] money = new int[n];

            
            for (int i = 0; i< n; i++) {
                money[i] = s.nextInt();
            } 

           
            String result = "";

            
            for (int j = 0; j< money.length; j++) {
                if (k >= money[j]) {
                    k = k - money[j];
                    result = result+"1"; 
                } else {
                    result = result + "0"; 
                }
            }
            
           
            results[z] = result; 
        }
        
        
        for (int i = 0; i < t; i++) {
            System.out.println(results[i]);
        }
        s.close();
    }
}