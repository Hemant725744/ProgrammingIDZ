package Day2_2;

import java.util.Scanner;

public class task_13 {
    public static void main(String[] args) {
         Scanner scanner = new Scanner(System.in);

       
        double a = scanner.nextDouble();
        double b = scanner.nextDouble();
        
        
        String operator = scanner.next();

        
        switch (operator) {
            case "+":
                System.out.println(a + b);
                break;
                
            case "-":
                System.out.println(a - b);
                break;
                
            case "*":
                System.out.println(a * b);
                break;
                
            case "/":
               
                if (b == 0) {
                    System.out.println("Error: Division by zero");
                } else {
                    System.out.println(a / b);
                }
                break;
                
            default:
                System.out.println("Invalid Operator");
                break;
        }

        scanner.close();
    }
}
