package bean;
/**
 * 
    * @ClassName: ProjectBean
    * @Description: 项目类
    * @author liuxining
    * @date 2017年9月6日
    *
 */
public class ProjectBean {
	private int id;
	private String name;
	private int userId;
	private int status;
	private int type;
	private String descr;
	private String createDate;
	private UserBean userBean;
	private int bugCount;
	private int bugFinCount;
	private int bugCloseCount;
	private int handleBugCount;
	private int handleBugPassCount;
	
	
	
	


	public int getBugFinCount() {
		return bugFinCount;
	}

	public void setBugFinCount(int bugFinCount) {
		this.bugFinCount = bugFinCount;
	}

	public int getBugCloseCount() {
		return bugCloseCount;
	}

	public void setBugCloseCount(int bugCloseCount) {
		this.bugCloseCount = bugCloseCount;
	}

	public int getHandleBugPassCount() {
		return handleBugPassCount;
	}

	public void setHandleBugPassCount(int handleBugPassCount) {
		this.handleBugPassCount = handleBugPassCount;
	}

	public int getBugCount() {
		return bugCount;
	}

	public void setBugCount(int bugCount) {
		this.bugCount = bugCount;
	}

	public int getHandleBugCount() {
		return handleBugCount;
	}

	public void setHandleBugCount(int handleBugCount) {
		this.handleBugCount = handleBugCount;
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

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public int getUserId() {
		return userId;
	}

	public void setUserId(int userId) {
		this.userId = userId;
	}

	public int getStatus() {
		return status;
	}

	public void setStatus(int status) {
		this.status = status;
	}

	public int getType() {
		return type;
	}

	public void setType(int type) {
		this.type = type;
	}

	public String getDescr() {
		return descr;
	}

	public void setDescr(String descr) {
		this.descr = descr;
	}

	public String getCreateDate() {
		return createDate;
	}

	public void setCreateDate(String createDate) {
		this.createDate = createDate;
	}
	
	

}
