package Day5;
import java.util.Scanner;
public class task_44 {
    public static void main(String[] args) 
    {
        Scanner s= new Scanner(System.in);
        int t = s.nextInt();

        while (t-->0) 
        {
            int size = s.nextInt();
            int arr[]= new int[size];
            
            
            int boost=0;
            for (int i = 0; i < size; i++) {
                arr[i] = s.nextInt();
            }

            for (int i = 0; i < arr.length; i++) 
            {
                int lessCount=0;
                int moreCount=0;
                for (int j = 0; j < arr.length; j++) 
                {    
                    if (arr[j] <= arr[i])
                        lessCount++;
                    else
                        moreCount++;
                }
                if(lessCount>moreCount)
                    boost++;
            }
            System.out.println(boost);

        }s.close();
    }
    
    
}
