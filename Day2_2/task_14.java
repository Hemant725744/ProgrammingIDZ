package Day2_2;
import java.util.Arrays;
import java.util.Scanner;

public class task_14 {
    public static void main(String[] args) {
        Scanner sc = new Scanner(System.in);
        String s = sc.next();

        char[] arr = s.toCharArray();

        for (int i = 0 ; i<arr.length-1; i+=2)
        {
            char temp = arr[i];
            arr[i]=arr[i+1];
            arr[i+1]=temp;
        }
        System.out.println(Arrays.toString(arr));

        for (int i = 0 ; i<arr.length; i++)
        {
            arr[i] = (char) ('z' - (arr[i] - 'a'));
        }
        System.out.println(Arrays.toString(arr));
        sc.close();
    }
}
