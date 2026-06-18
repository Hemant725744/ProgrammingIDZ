package Day3_1;

import java.util.Scanner;

public class task_17 {
    public static void main(String[] args) {
        Scanner s = new Scanner(System.in);
        int t = s.nextInt(); 
        
        while (t-->0) {
            int XA = s.nextInt();
            int XB = s.nextInt();
            int XC = s.nextInt();

            System.out.println((XA > XB && XA > XC) ? "A" : (XB > XA && XB > XC) ? "B" : (XC > XA && XC > XB) ? "C" : "NOTA");
        }
        s.close();
    }
}
