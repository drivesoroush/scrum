package myjava;

import java.util.ArrayList;

public class RoleType {
	public static String PRODUCT_OWNER = "product_owner";
	public static String TEAM_MEMBER = "team_member";
	public static String SCRUM_MASTER = "scrum_master";
	
	public RoleType() {
	}
	
	public ArrayList<String> getAllTypes() {
		ArrayList<String> types = new ArrayList<String>();
		types.add(PRODUCT_OWNER);
		types.add(TEAM_MEMBER);
		types.add(SCRUM_MASTER);
		return types;
	}
}
