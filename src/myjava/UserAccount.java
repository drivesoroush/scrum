package myjava;

public class UserAccount {
	private User user;
	private boolean isAdmin = false;
	private boolean isProductOwner = false;
	private boolean isScrumMaster = false;
	private boolean isTeamMember = false;
	
	public UserAccount() {
	}
	
	public void setUser(User user) {
		this.user = user;
	}
	public User getUser() {
		return user;
	}
	public void setAdmin(boolean isAdmin) {
		this.isAdmin = isAdmin;
	}
	public boolean isAdmin() {
		return isAdmin;
	}
	public void setProductOwner(boolean isProductOwner) {
		this.isProductOwner = isProductOwner;
	}
	public void setScrumMaster(boolean isScrumMaster) {
		this.isScrumMaster = isScrumMaster;
	}
	public void setTeamMember(boolean isTeamMember) {
		this.isTeamMember = isTeamMember;
	}
	public boolean isProductOwner() {
		return isProductOwner;
	}
	public boolean isScrumMaster() {
		return isScrumMaster;
	}
	public boolean isTeamMember() {
		return isTeamMember;
	}
}
