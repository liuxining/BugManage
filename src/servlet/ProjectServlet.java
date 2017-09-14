package servlet;

import java.io.IOException;
import java.io.PrintWriter;
import java.io.UnsupportedEncodingException;
import java.lang.reflect.InvocationTargetException;
import java.sql.SQLException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.beanutils.BeanUtils;
import org.apache.log4j.Logger;

import com.alibaba.fastjson.JSON;

import bean.PagingBean;
import bean.ProjectBean;
import bean.UserBean;
import dao.BugDao;
import dao.HandleBugDao;
import dao.ProjectDao;
import dao.UserDao;
import util.Constants;
import util.DateUtil;
import util.StringUtil;

/**
 * Servlet implementation class ProjectServlet
 */
@WebServlet("/ProjectServlet")
public class ProjectServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private ProjectDao projectDao = new ProjectDao();
	private UserDao userDao = new UserDao();
	private BugDao bugDao = new BugDao();
	private HandleBugDao handleBugDao = new HandleBugDao();
	
	private static Logger log = Logger.getLogger(ProjectServlet.class.getName());
	
	
	/**
     * @see HttpServlet#HttpServlet()
     */
    public ProjectServlet() {
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
		req.setCharacterEncoding("UTF-8");
		String method = req.getParameter("method");
		if("add".equals(method)){
			add(req,resp);
		}
		else if("toUpdate".equals(method)){
			toUpdate(req,resp);
		}
		else if("list".equals(method)){
			list(req,resp);
		}
		else if("delete".equals(method)){
			delete(req,resp);
		}
		else if("detail".equals(method)){
			detail(req,resp);
		}
	}

	private void detail(HttpServletRequest req, HttpServletResponse resp) {
		int id = StringUtil.stringToInt(req.getParameter("id"));
		try {
			ProjectBean projectBean = projectDao.getById(id);
			int bugCount = bugDao.getCount(0, 0, 0, id);
			int bugFinCount = bugDao.getCount(0, 0, 4, id);
			int handleBugCount = handleBugDao.getCount(0, 0, 0, 0, id);
			int handleBugPassCount = handleBugDao.getCount(0, 0, 0, 3, id);
			System.out.println("bugCount:" + bugCount);
			System.out.println("bugFinCount:" + bugFinCount);
			System.out.println("handleBugCount:" + handleBugCount);
			System.out.println("handleBugPassCount:" + handleBugPassCount);
			req.setAttribute("bugCount", bugCount);
			req.setAttribute("bugFinCount", bugFinCount);
			req.setAttribute("handleBugCount", handleBugCount);
			req.setAttribute("handleBugPassCount", handleBugPassCount);
			req.setAttribute("projectBean", projectBean);
			req.getRequestDispatcher("leader/detail.jsp").forward(req, resp);
		} catch (ServletException | IOException | SQLException e) {
			e.printStackTrace();
		}
	}

	private void delete(HttpServletRequest req, HttpServletResponse resp) {
		int id = StringUtil.stringToInt(req.getParameter("id"));
		int type = StringUtil.stringToInt(req.getParameter("type"));
		int status2 = StringUtil.stringToInt(req.getParameter("status2"));
		int userId = StringUtil.stringToInt(req.getParameter("userId"));
		int page = StringUtil.stringToInt(req.getParameter("page"));
		try {
			boolean flag = projectDao.delete(id);
			req.getRequestDispatcher("ProjectServlet?method=list&to=leader_listProject&status=" + (flag ? 3 : 4) + "&type=" + type + "&status2=" + status2 + "&userId=" + userId + "&page=" + page).forward(req, resp);
		} catch (ServletException | IOException | SQLException e) {
			e.printStackTrace();
		}
	}

	private void list(HttpServletRequest req, HttpServletResponse resp) {
		String status = req.getParameter("status");
		String to = req.getParameter("to");
		int type = StringUtil.stringToInt(req.getParameter("type"));
		int page = StringUtil.stringToInt(req.getParameter("page"));
		int userId = StringUtil.stringToInt(req.getParameter("userId"));
		int status2 = StringUtil.stringToInt(req.getParameter("status2"));
		log.info("获取到的参数信息为:type=" + type + ",page=" + page + ",userId=" + userId + ",status2=" + status2);
		req.setAttribute("type", type);
		req.setAttribute("userId", userId);
		req.setAttribute("status2", status2);
		try {
			int totalCount = projectDao.getCount(userId, type, status2);
			PagingBean pagingBean = new PagingBean(totalCount, page, Constants.PAGE_SIZE);
			pagingBean.setPreUrl(req.getContextPath() + "/ProjectServlet?method=list&type=" + type + "&userId=" + userId + "&status2=" + status2 + "&to=" + to);
			pagingBean.setAnd(true);
			page = pagingBean.getCurrentPage();
			req.setAttribute("page", page);
			List<ProjectBean> list = projectDao.getAllByPage(userId,type,status2,page * Constants.PAGE_SIZE,Constants.PAGE_SIZE);
			System.out.println("projectList size ->" + list.size());
			for (ProjectBean projectBean : list) {
				projectBean.setUserBean(userDao.getById(projectBean.getUserId()));
			}
			log.info("获取到的项目信息为： " + list);
			if(list != null && list.size() == 0){
				list = null;
			}
			req.setAttribute("pageMsg", pagingBean.getHtmlMsg());
			req.setAttribute("projectList", list);
			//获取所有的项目经理用户信息
			List<UserBean> uList = userDao.getAll(3);
			req.setAttribute("userList", uList);

			to = to.replace("_", "/") + ".jsp";
			if(status != null && !status.equals("")){
				to += "?status=" + status;
			}
			
			req.getRequestDispatcher(to).forward(req, resp);
		} catch (ServletException | IOException | SQLException e) {
			e.printStackTrace();
		}
	}

	private void toUpdate(HttpServletRequest req, HttpServletResponse resp) {
		int id = StringUtil.stringToInt(req.getParameter("id"));
		int type = StringUtil.stringToInt(req.getParameter("type"));
		int status2 = StringUtil.stringToInt(req.getParameter("status2"));
		int userId = StringUtil.stringToInt(req.getParameter("userId"));
		int page = StringUtil.stringToInt(req.getParameter("page"));
		req.setAttribute("type", type);
		req.setAttribute("userId", userId);
		req.setAttribute("status2", status2);
		req.setAttribute("page", page);
		try {
			ProjectBean projectBean = projectDao.getById(id);
			req.setAttribute("updateBean", projectBean);
			req.getRequestDispatcher("leader/addProject.jsp").forward(req, resp);
		} catch (ServletException | IOException | SQLException e) {
			e.printStackTrace();
		}
	}

	private void add(HttpServletRequest req, HttpServletResponse resp) throws UnsupportedEncodingException {
		req.setCharacterEncoding("UTF-8");
		ProjectBean projectBean = new ProjectBean();
		try {
			BeanUtils.populate(projectBean, req.getParameterMap());
			if(projectBean.getId() != 0){
				//为更新操作
				int type = StringUtil.stringToInt(req.getParameter("type2"));
				int status2 = StringUtil.stringToInt(req.getParameter("status2"));
				int userId = StringUtil.stringToInt(req.getParameter("userId2"));
				int page = StringUtil.stringToInt(req.getParameter("page2"));
				boolean flag = projectDao.update(projectBean);
				resp.sendRedirect("ProjectServlet?method=list&to=leader_listProject&status=" + (flag ? 1 : 2) + "&type=" + type + "&status2=" + status2 + "&userId=" + userId + "&page=" + page);
			}
			
			else{
				UserBean userBean = (UserBean) req.getSession().getAttribute("loginUserBean");
				projectBean.setUserId(userBean.getId());
				projectBean.setCreateDate(DateUtil.getDate());
				boolean flag = projectDao.add(projectBean);
				resp.sendRedirect("leader/addProject.jsp?status=" + (flag ? 1 : 2));
			}
			
			
		} catch (IllegalAccessException | InvocationTargetException | SQLException | IOException e) {
			e.printStackTrace();
		}
	}
	
	
	

}
