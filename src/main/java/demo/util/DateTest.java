package demo.util;

import java.text.SimpleDateFormat;
import java.util.Date;

/**
 * Created by mingfei.net@gmail.com
 * 6/16/17 16:34
 * https://github.com/thu/JavaEE_Library/
 */
public class DateTest {
    public static void main(String[] args) {
        /*
            table
            time Date -- 'yyyy-MM-dd'
         */

        Date date = new Date();
        System.out.println(date);
        SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
        System.out.println(format.format(date));
    }
}
