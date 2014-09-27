package myjava;

public class Role {
	private RoleType type;
	private String name;
	private String description;
	
	public Role() {
	}
	
	public void setName(String name) {
		this.name = name;
	}
	
	public String getName() {
		return name;
	}
	
	public void setDescription(String description) {
		this.description = description;
	}
	
	public String getDescription() {
		return description;
	}
	
	public void setType(RoleType type) {
		this.type = type;
	}
	
	public RoleType getType() {
		return type;
	}
	
}
