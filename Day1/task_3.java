import java.util.Scanner;

public class task_3 {
    public static void main(String[] args) {
        Scanner s =new Scanner(System.in);
        int t = s.nextInt();
        boolean[] results = new boolean[t];
        for (int i =0 ; i<t;i++)
        {
        
        int x = s.nextInt();
        int y = s.nextInt();
        boolean ismanu =false;
        if (x==y || x>y)
                ismanu = true;

        results[i]=ismanu;
        }
        for (int i = 0; i < t; i++) {
            if (results[i]) {
                System.out.println("YES"); // true = easy
            } else {
                System.out.println("NO");  // false = hard
            }
        }
        s.close();
    }
}
