package bean;

/*
 * 
    * @ClassName: HandleBugBean
    * @Description: 处理bug类
    * @author liuxining
    * @date 2017年9月6日
    *
 */
public class HandleBugBean {
	private int id;
	private int userId;
	private int bugId;
	private int status;
	private int level;
	private String descr;
	private String date;
	private int pass;
	private UserBean userBean;
	private BugBean bugBean;
	
	
	

	
	
	
	
	
	public int getPass() {
		return pass;
	}

	public void setPass(int pass) {
		this.pass = pass;
	}

	public BugBean getBugBean() {
		return bugBean;
	}

	public void setBugBean(BugBean bugBean) {
		this.bugBean = bugBean;
	}

	public UserBean getUserBean() {
		return userBean;
	}

	public void setUserBean(UserBean userBean) {
		this.userBean = userBean;
	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public int getUserId() {
		return userId;
	}

	public void setUserId(int userId) {
		this.userId = userId;
	}

	public int getBugId() {
		return bugId;
	}

	public void setBugId(int bugId) {
		this.bugId = bugId;
	}

	public int getStatus() {
		return status;
	}

	public void setStatus(int status) {
		this.status = status;
	}

	public int getLevel() {
		return level;
	}

	public void setLevel(int level) {
		this.level = level;
	}

	public String getDescr() {
		return descr;
	}

	public void setDescr(String descr) {
		this.descr = descr;
	}

	public String getDate() {
		return date;
	}

	public void setDate(String date) {
		this.date = date;
	}

	@Override
	public String toString() {
		return "HandleBugBean [id=" + id + ", userId=" + userId + ", bugId=" + bugId + ", status=" + status + ", level="
				+ level + ", descr=" + descr + ", date=" + date + ", pass=" + pass + ", userBean=" + userBean
				+ ", bugBean=" + bugBean + "]";
	}
	
	

}
