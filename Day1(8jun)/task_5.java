import java.util.Scanner;

public class task_5 {
    public static void main(String[] args) {
        
        Scanner s = new Scanner(System.in);
        int t = s.nextInt();

        boolean[] results = new boolean[t];

        for (int i = 0; i < t; i++) {
            int n = s.nextInt();
    
            
            String input = s.next();
            if (input.length() > n) {
                input = input.substring(0, n);
            }

            char[] arr = input.toCharArray();
            int count = 0;
            boolean isHard = false;

            for (int j = 0; j < arr.length; j++) {
                if (arr[j] != 'a' && arr[j] != 'e' && arr[j] != 'i' && arr[j] != 'o' && arr[j] != 'u') {
                    count++;
                    if (count >= 4) {
                        isHard = true;
                    }
                } else {
                    count = 0;
                }
            }
            
 
            results[i] = !isHard; 
        }
        
        for (int i = 0; i < t; i++) {
            if (results[i]) {
                System.out.println("YES"); 
            } else {
                System.out.println("NO");
            }
        }
        
        s.close();
    }
}