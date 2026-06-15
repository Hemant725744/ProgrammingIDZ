

package Day4;

import java.util.Scanner;
public class task_28 {
    public static void main(String[] args) 
    {
        
    Scanner s = new Scanner(System.in);
    int t = s.nextInt();
    
    while(t-->0)
    {
        int size = s.nextInt();
        String[] arr = new String[size];
        int scount=1;
        int vcount=1;

        for (int i = 0 ; i<arr.length ; i ++)
        {
            arr[i] = s.next();
        }

        for  (int i = 0 ; i<arr.length ; i ++)
        {
            String str= arr[i];
            if(str.endsWith("man") || str.endsWith("woman"))
                scount++;
            else
                vcount++; 
            
            
        }
        if(scount>vcount)
                System.out.println("Superhero");
            else if (vcount>scount)
                System.out.println("Villan");
            else
                System.out.println("draw"); 
        
       
    }
     s.close();
}
    }
