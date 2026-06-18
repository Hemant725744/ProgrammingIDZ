import java.util.Scanner;
public class task_2 {
    
    public static void main(String[] args) {
        Scanner s =new Scanner(System.in);
        int n = s.nextInt();

        int[] arr = new int[n];
        
        for (int i = 0; i<arr.length ;i++)
        {
            arr[i]=s.nextInt();
        }
        
        int even = 0;
        int odd = 0;
        for (int i = 0; i<arr.length ;i++)
        {
            if(arr[i]%2==0)
                even++;
            else
                odd++;
        }

        System.out.println((even > odd) ? "Readyfor Battle" : "Not Ready");    
        s.close();
    }
}
