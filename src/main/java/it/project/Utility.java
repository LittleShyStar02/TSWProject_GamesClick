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
		String month = String.valueOf(cal.get(Calendar.MONTH)+1);
		if(month.length() == 1 && !month.matches("0\\w")) month = "0".concat(month);
		String day = String.valueOf(cal.get(Calendar.DAY_OF_MONTH));
		if(day.length() == 1 && !day.matches("0\\w")) day = "0".concat(day);
		return day + "/" + month + "/" + cal.get(Calendar.YEAR);
	}
	
	public static String dateToMysql(Date date)
	{
		Calendar cal = new GregorianCalendar();
		cal.setTime(date);
		String month = String.valueOf(cal.get(Calendar.MONTH));
		if(month.length() == 1 && !month.matches("0\\w")) month = "0".concat(month);
		String day = String.valueOf(cal.get(Calendar.DAY_OF_MONTH));
		if(day.length() == 1 && !day.matches("0\\w")) day = "0".concat(day);
		return cal.get(Calendar.YEAR) + "-" + month + "-" + day;
	}

}
