package util;

import java.util.Random;

/**
 * 
    * @ClassName: StringUtil
    * @Description: 字符串工具类
    * @author liuxining
    * @date 2017年8月20日
    *
 */
public class StringUtil {
	public static String getRandomStr(int n){
		String base = "abcdefghijklmnopqrstuvwxyz0123456789";
		StringBuffer buffer = new StringBuffer();
		Random random = new Random();
		for (int i = 0; i < n; i++) {
			buffer.append(base.charAt(random.nextInt(base.length())));
		}
		return buffer.toString();
	}

	public static int stringToInt(String parameter) {
		try{
			return Integer.parseInt(parameter);
		}
		catch(Exception e){
			return 0;
		}
	}

	public static double stringToFloat(String value) {
		try{
			return Float.parseFloat(value);
		}
		catch(Exception e){
			return 0;
		}
	}
}
