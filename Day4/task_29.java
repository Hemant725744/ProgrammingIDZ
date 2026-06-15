package Day4;

import java.util.Scanner;

public class task_29 {
    public static void main(String[] args) 
    {

    Scanner s = new Scanner(System.in);
    int t = s.nextInt();
    
    while(t-->0)
    {
        int n1 =s.nextInt();
        int n2 =s.nextInt();
        int m= s.nextInt();

        for(int i =1 ; i<=m ; i++)
        {
            if(n1>=i && n2 >=i)
            {
                n1 -=i;
                n2 -=i;
              
            }
            else 
                break;
        }
        System.out.println(n1+n2);
    }
     s.close();
}
}
