package myjava;

import java.util.Date;
import java.util.ArrayList;

public class Chart {
	private ArrayList<Date> dates;
	private ArrayList<Integer> values; 
	
	public Chart() {
	}
	
	public void setDates(ArrayList<Date> dates) {
		this.dates = dates;
	}
	public ArrayList<Date> getDates() {
		return dates;
	}
	public void setValues(ArrayList<Integer> values) {
		this.values = values;
	}
	public ArrayList<Integer> getValues() {
		return values;
	}
	
	
}
