package Day2_2;

import java.util.Scanner;

public class task_15 {
    public static void main(String[] args) {
        Scanner sc = new Scanner(System.in);
             
                int N = sc.nextInt(); 
                int X = sc.nextInt();
                    
                if (N % 2 == 0) {
                    System.out.println("YES");
                } 
               
                else {
                    if (X % 2 != 0) {
                        System.out.println("YES");
                    } else {
                        System.out.println("NO");
                    }
                }
        sc.close();
    }
    }
