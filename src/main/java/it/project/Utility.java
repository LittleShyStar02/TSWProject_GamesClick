package it.project;

import java.util.Calendar;
import java.util.Date;
import java.util.GregorianCalendar;

public class Utility 
{
	
	public static String dateToString(Date date)
	{
		Calendar cal = new GregorianCalendar();
		cal.setTime(date);
		return cal.get(Calendar.DAY_OF_MONTH) + "/" + (cal.get(Calendar.MONTH)+1) + "/" + cal.get(Calendar.YEAR);
	}
	
	public static String dateToMysql(Date date)
	{
		Calendar cal = new GregorianCalendar();
		cal.setTime(date);
		return cal.get(Calendar.YEAR) + "-" + cal.get(Calendar.MONTH) + "-" + cal.get(Calendar.DAY_OF_MONTH);
	}

}
