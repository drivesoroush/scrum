package myjava;

import java.util.ArrayList;

public class Priority {
	
	String High = "high";
	String Medium = "medium";
	String Low = "low";
	
	public Priority() {
	}
	
	public ArrayList<String> getAllPriority()
	{
		ArrayList<String> priority = new ArrayList<String>();
		priority.add(High);
		priority.add(Medium);
		priority.add(Low);
		return priority;
	}
}
