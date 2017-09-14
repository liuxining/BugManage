package servlet;

import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import bean.BugBean;
import bean.HandleBugBean;
import bean.ProjectBean;
import bean.UserBean;
import dao.BugDao;
import dao.HandleBugDao;
import dao.ProjectDao;
import dao.UserDao;
import util.StringUtil;

/**
 * Servlet implementation class CollectServlet
 */
@WebServlet("/CollectServlet")
public class CollectServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private ProjectDao projectDao = new ProjectDao();
	private BugDao bugDao = new BugDao();
	private HandleBugDao handleBugDao = new HandleBugDao();
	private UserDao userDao = new UserDao();
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public CollectServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.getWriter().append("Served at: ").append(request.getContextPath());
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

	@Override
	protected void service(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		String method = req.getParameter("method");
		if("toLeaderIndex".equals(method)){
			toLeaderIndex(req,resp);
		}
		else if("toTesterIndex".equals(method)){
			toTesterIndex(req,resp);
		}
		else if("toProgrammerIndex".equals(method)){
			toProgrammerIndex(req,resp);
		}
	}

	private void toProgrammerIndex(HttpServletRequest req, HttpServletResponse resp) {
		try {
			String to = req.getParameter("to");
			UserBean userBean = (UserBean) req.getSession().getAttribute("loginUserBean");
			int bugNoFinCount = bugDao.getCount(0, 0, 1, 0);
			int handleBugMyCount = handleBugDao.getCount(userBean.getId(), 0, 0, 0, 0);
			int handleBugMy3Count = handleBugDao.getCount(userBean.getId(), 0, 0, 3, 0);
			int handleBugMy2Count = handleBugDao.getCount(userBean.getId(), 0, 0, 2, 0);
			int handleBugCount = handleBugDao.getCount(0, 0, 0, 0, 0);
			int handleBug3Count = handleBugDao.getCount(0, 0, 0, 3, 0);
			int handleBug2Count = handleBugDao.getCount(0, 0, 0, 2, 0);
			req.getSession().setAttribute("bugNoFinCountc", bugNoFinCount);
			req.getSession().setAttribute("handleBugCountc", handleBugCount);
			req.getSession().setAttribute("handleBugMyCountc", handleBugMyCount);
			req.getSession().setAttribute("handleBugMy3Countc", handleBugMy3Count);
			req.getSession().setAttribute("handleBugMy2Countc", handleBugMy2Count);
			req.getSession().setAttribute("handleBugMy1Countc", handleBugMyCount - handleBug2Count - handleBug3Count);
			req.getSession().setAttribute("handleBugCountc", handleBugCount);
			req.getSession().setAttribute("handleBug3Countc", handleBug3Count);
			req.getSession().setAttribute("handleBug2Countc", handleBug2Count);
			req.getSession().setAttribute("handleBug1Countc", handleBugCount - handleBug2Count - handleBug3Count);
			List<HandleBugBean> list = handleBugDao.getAll(0, 0, 0, 0);
			for (HandleBugBean handleBugBean : list) {
				handleBugBean.setBugBean(bugDao.getById(handleBugBean.getBugId()));
				handleBugBean.setUserBean(userDao.getById(handleBugBean.getUserId()));
			}
			req.getSession().setAttribute("handleBugListc", list);
			to = to.replace("_", "/") + ".jsp";
			req.getRequestDispatcher(to).forward(req, resp);
		} catch (SQLException | ServletException | IOException e) {
			e.printStackTrace();
		}
		
	}

	private void toTesterIndex(HttpServletRequest req, HttpServletResponse resp) {
		try {
			String to = req.getParameter("to");
			int projectNoFinCount = projectDao.getCount(0, 0, 1);
			int bugCount = bugDao.getCount(0,0,0,0);
			int bug4Count = bugDao.getCount(0,0,4,0);
			int bug5Count = bugDao.getCount(0,0,5,0);
			int handleBugCount = handleBugDao.getCount(0, 0, 0, 0, 0);
			int handleBug3Count = handleBugDao.getCount(0, 0, 0, 3, 0);
			int handleBug2Count = handleBugDao.getCount(0, 0, 0, 2, 0);
			req.getSession().setAttribute("bugCountc", bugCount);
			req.getSession().setAttribute("bug1Countc", bugCount - bug4Count - bug5Count);
			req.getSession().setAttribute("bug4Countc", bug4Count);
			req.getSession().setAttribute("bug5Countc", bug5Count);
			req.getSession().setAttribute("handleBugCountc", handleBugCount);
			req.getSession().setAttribute("handleBug3Countc", handleBug3Count);
			req.getSession().setAttribute("handleBug2Countc", handleBug2Count);
			req.getSession().setAttribute("handleBug1Countc", handleBugCount - handleBug2Count - handleBug3Count);
			req.getSession().setAttribute("projectNoFinCountc", projectNoFinCount);
			List<BugBean> list = bugDao.getAllByPage(0, 0, 0, 0, 0, 5);
			for (BugBean bugBean : list) {
				bugBean.setUserBean(userDao.getById(bugBean.getUserId()));
				bugBean.setProjectBean(projectDao.getById(bugBean.getProjectId()));
				bugBean.setHandleBugCount(handleBugDao.getCount(0, 0, 0, 0, 0));
				bugBean.setHandleBugPassCount(handleBugDao.getCount(0, 0, 0, 3, 0));
			}
			req.getSession().setAttribute("bugListc", list);
			to = to.replace("_", "/") + ".jsp";
			req.getRequestDispatcher(to).forward(req, resp);
		} catch (SQLException | ServletException | IOException e) {
			e.printStackTrace();
		}
		
	}

	private void toLeaderIndex(HttpServletRequest req, HttpServletResponse resp) {
		try {
			String to = req.getParameter("to");
			//获取项目、bug、解决方案数量
			int projectCount = projectDao.getCount(0,0,0);
			int project1Count = projectDao.getCount(0,0,1);
			int project2Count = projectDao.getCount(0,0,2);
			int bugCount = bugDao.getCount(0,0,0,0);
			int bug4Count = bugDao.getCount(0,0,4,0);
			int bug5Count = bugDao.getCount(0,0,5,0);
			int handleBugCount = handleBugDao.getCount(0, 0, 0, 0, 0);
			int handleBug3Count = handleBugDao.getCount(0, 0, 0, 3, 0);
			int handleBug2Count = handleBugDao.getCount(0, 0, 0, 2, 0);
			int userCount = userDao.getCount(0,0);
			int user3Count = userDao.getCount(0,3);
			int user2Count = userDao.getCount(0,2);
			int userLeaderCount = userDao.getCount(3,0);
			int userLeader3Count = userDao.getCount(3,3);
			int userLeader2Count = userDao.getCount(3,2);
			int userTesterCount = userDao.getCount(2,0);
			int userTester3Count = userDao.getCount(2,3);
			int userTester2Count = userDao.getCount(2,2);
			int userProgrammerCount = userDao.getCount(1,0);
			int userProgrammer3Count = userDao.getCount(1,3);
			int userProgrammer2Count = userDao.getCount(1,2);
			req.getSession().setAttribute("projectCountc", projectCount);
			req.getSession().setAttribute("project1Countc", project1Count);
			req.getSession().setAttribute("project2Countc", project2Count);
			req.getSession().setAttribute("project3Countc", projectCount - project1Count - project2Count);
			req.getSession().setAttribute("bugCountc", bugCount);
			req.getSession().setAttribute("bug1Countc", bugCount - bug4Count - bug5Count);
			req.getSession().setAttribute("bug4Countc", bug4Count);
			req.getSession().setAttribute("bug5Countc", bug5Count);
			req.getSession().setAttribute("handleBugCountc", handleBugCount);
			req.getSession().setAttribute("handleBug3Countc", handleBug3Count);
			req.getSession().setAttribute("handleBug2Countc", handleBug2Count);
			req.getSession().setAttribute("handleBug1Countc", handleBugCount - handleBug2Count - handleBug3Count);
			req.getSession().setAttribute("userCountc", userCount);
			req.getSession().setAttribute("user3Countc", user3Count);
			req.getSession().setAttribute("user2Countc", user2Count);
			req.getSession().setAttribute("user1Countc", userCount - user2Count - user3Count);
			req.getSession().setAttribute("userLeaderCountc", userLeaderCount);
			req.getSession().setAttribute("userLeader3Countc", userLeader3Count);
			req.getSession().setAttribute("userLeader2Countc", userLeader2Count);
			req.getSession().setAttribute("userLeader1Countc", userLeaderCount - userLeader2Count - userLeader3Count);
			req.getSession().setAttribute("userTesterCountc", userTesterCount);
			req.getSession().setAttribute("userTester3Countc", userTester3Count);
			req.getSession().setAttribute("userTester2Countc", userTester2Count);
			req.getSession().setAttribute("userTester1Countc", userTesterCount - userTester2Count - userTester3Count);
			req.getSession().setAttribute("userProgrammerCountc", userProgrammerCount);
			req.getSession().setAttribute("userProgrammer3Countc", userProgrammer3Count);
			req.getSession().setAttribute("userProgrammer2Countc", userProgrammer2Count);
			req.getSession().setAttribute("userProgrammer1Countc", userProgrammerCount - userProgrammer2Count - userProgrammer3Count);
			
			//获取最新的5个项目的信息
			List<ProjectBean> pList = projectDao.getAllByPage(0, 0, 0, 0, 5);
			for (ProjectBean projectBean : pList) {
				projectBean.setBugCount(bugDao.getCount(0, 0, 0, projectBean.getId()));
				projectBean.setBugFinCount(bugDao.getCount(0, 0, 4, projectBean.getId()));
				projectBean.setBugCloseCount(bugDao.getCount(0, 0, 5, projectBean.getId()));
				projectBean.setHandleBugCount(handleBugDao.getCount(0, 0, 0, 0, projectBean.getId()));
				projectBean.setHandleBugPassCount(handleBugDao.getCount(0, 0, 0, 3, projectBean.getId()));
			}
			req.getSession().setAttribute("projectListc", pList);
			System.out.println(pList);
			to = to.replace("_", "/") + ".jsp";
			req.getRequestDispatcher(to).forward(req, resp);
		} catch (SQLException | ServletException | IOException e) {
			e.printStackTrace();
		}
	}

	
	
	
	
	

}
