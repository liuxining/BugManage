package bean;
/*
 * 
    * @ClassName: BugBean
    * @Description: bug信息类
    * @author liuxining
    * @date 2017年9月6日
    *
 */
public class BugBean {
	private int id;
	private int userId;
	private int projectId;
	private String title;
	private int level;
	private String descr;
	private int status;
	private String createDate;
	private ProjectBean projectBean;
	private UserBean userBean;
	private int handleBugCount;
	private int handleBugPassCount;
	
	
	

	public int getHandleBugPassCount() {
		return handleBugPassCount;
	}

	public void setHandleBugPassCount(int handleBugPassCount) {
		this.handleBugPassCount = handleBugPassCount;
	}

	public int getHandleBugCount() {
		return handleBugCount;
	}

	public void setHandleBugCount(int handleBugCount) {
		this.handleBugCount = handleBugCount;
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

	public int getProjectId() {
		return projectId;
	}

	public void setProjectId(int projectId) {
		this.projectId = projectId;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
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

	public int getStatus() {
		return status;
	}

	public void setStatus(int status) {
		this.status = status;
	}

	public String getCreateDate() {
		return createDate;
	}

	public void setCreateDate(String createDate) {
		this.createDate = createDate;
	}

	public ProjectBean getProjectBean() {
		return projectBean;
	}

	public void setProjectBean(ProjectBean projectBean) {
		this.projectBean = projectBean;
	}

	public UserBean getUserBean() {
		return userBean;
	}

	public void setUserBean(UserBean userBean) {
		this.userBean = userBean;
	}

	@Override
	public String toString() {
		return "BugBean [id=" + id + ", userId=" + userId + ", projectId=" + projectId + ", title=" + title + ", level="
				+ level + ", descr=" + descr + ", status=" + status + ", createDate=" + createDate + ", projectBean="
				+ projectBean + ", userBean=" + userBean + "]";
	}

	
	
	
}
