package servlet;

import java.io.IOException;
import java.io.PrintWriter;
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

import bean.BugBean;
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
 * Servlet implementation class BugServlet
 */
@WebServlet("/BugServlet")
public class BugServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	private static Logger log = Logger.getLogger(BugServlet.class.getName());
	
	private BugDao bugDao = new BugDao();
	private ProjectDao projectDao = new ProjectDao();
	private UserDao userDao = new UserDao();

	private HandleBugDao hanleBugDao = new HandleBugDao();

	
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public BugServlet() {
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
		else if("delete".equals(method)){
			delete(req,resp);
		}
		else if("detail".equals(method)){
			detail(req,resp);
		}
		else if("list".equals(method)){
			list(req,resp);
		}
		else if("upStat".equals(method)){
			upStat(req,resp);
		}
		else if("handleBug".equals(method)){
			handleBug(req,resp);
		}
		else if("toAdd".equals(method)){
			toAdd(req,resp);
		}
	}
	
	


	private void toAdd(HttpServletRequest req, HttpServletResponse resp) {
		String status = req.getParameter("status");
		try {
			List<ProjectBean> list = projectDao.getAll();
			req.setAttribute("projectList", list);
			req.getRequestDispatcher("tester/addBug.jsp?status=" + (status == null ? "" : status)).forward(req, resp);
		} catch (SQLException | ServletException | IOException e) {
			e.printStackTrace();
		}
	}

	private void handleBug(HttpServletRequest req, HttpServletResponse resp) {
		BugBean bugBean = new BugBean();
		try {
			BeanUtils.populate(bugBean, req.getParameterMap());
			boolean flag = bugDao.update(bugBean);
			resp.getWriter().print(bugBean.getStatus() + "#" + (flag ? "1" : "2"));
			resp.getWriter().flush();
			resp.getWriter().close();
//			resp.sendRedirect("BugServlet?method=detail&to=tester_detail&id=" + bugBean.getId() + "&status=" + (flag ? "1" : "2"));
		} catch (SQLException | IllegalAccessException | InvocationTargetException | IOException e) {
			e.printStackTrace();
		}
	}

	private void upStat(HttpServletRequest req, HttpServletResponse resp) {
		int id = StringUtil.stringToInt(req.getParameter("id"));
		int status = StringUtil.stringToInt(req.getParameter("status"));
		int projectId = StringUtil.stringToInt(req.getParameter("projectId"));
		int level = StringUtil.stringToInt(req.getParameter("level"));
		int status2 = StringUtil.stringToInt(req.getParameter("status2"));
		int page = StringUtil.stringToInt(req.getParameter("page"));
		int userId = StringUtil.stringToInt(req.getParameter("userId"));
		
		
		int status3 = status;
		
		if(status != 5){
			status = 1;
		}
		log.info("获取到的id:" + id);
		try {
			boolean flag = bugDao.upStat(id,status);
			if(status3 == 1){
				status3 = 7;
			}
			else if(status3 == 4){
				status3 = 9;
			}
			if(!flag){
				status3++;
			}
			resp.sendRedirect("BugServlet?method=list&to=tester_listBug&status=" + ("" + status3) + "&projectId=" + projectId + "&level=" + level + "&status2=" + status2 + "&page=" + page + "&userId=" + userId);
			
		} catch (SQLException | IOException e) {
			e.printStackTrace();
		}
	}

	private void detail(HttpServletRequest req, HttpServletResponse resp) {
		String idStr = req.getParameter("id");
		int id = StringUtil.stringToInt(idStr);
		String to = req.getParameter("to");
		String status = req.getParameter("status");
		log.info("获取到的id:" + idStr + ",转换为int : " + id);
		try {
			BugBean bugBean = bugDao.getById(id);
			bugBean.setUserBean(userDao.getById(bugBean.getUserId()));
			bugBean.setProjectBean(projectDao.getById(bugBean.getProjectId()));
			req.setAttribute("bugBean", bugBean);
			log.info("从数据库获取的bug对象为：" + bugBean);
			
			List<UserBean> uList = userDao.getAll(1);
			req.setAttribute("userList", uList);
			
			//获取该Bug的解决方案数量
			int handleBugCount = hanleBugDao.getCount(0, 0, id, 0, 0);
			int handleBug2Count = hanleBugDao.getCount(0, 0, id, 2, 0);
			int handleBug3Count = hanleBugDao.getCount(0, 0, id, 3, 0);
			req.setAttribute("handleBugCount", handleBugCount);
			req.setAttribute("handleBug3Count", handleBug3Count);
			req.setAttribute("handleBug2Count", handleBug2Count);
			req.setAttribute("handleBug1Count", handleBugCount - handleBug2Count - handleBug3Count);
			
			
			to = to.replace("_", "/");
			req.getRequestDispatcher(to + ".jsp" + (status != null ? "?status=" + status : "")).forward(req, resp);
		} catch (ServletException | IOException | SQLException e) {
			e.printStackTrace();
		}
	}

	private void delete(HttpServletRequest req, HttpServletResponse resp) {
		int id = StringUtil.stringToInt(req.getParameter("id"));
		String to = req.getParameter("to");
		int projectId = StringUtil.stringToInt(req.getParameter("projectId"));
		int level = StringUtil.stringToInt(req.getParameter("level"));
		int status2 = StringUtil.stringToInt(req.getParameter("status2"));
		int page = StringUtil.stringToInt(req.getParameter("page"));
		int userId = StringUtil.stringToInt(req.getParameter("userId"));
		try {
			boolean flag = bugDao.delete(id);
			if(to != null && to.equals("HandleBugServlet_list")){
				to = "HandleBugServlet?method=list&status=" + (flag ? 3 : 4);
			}
			else{
				to = "BugServlet?method=list&to=tester_listBug&status=" + (flag ? 3 : 4) + "&projectId=" + projectId + "&level=" + level + "&status2=" + status2 + "&page=" + page + "&userId=" + userId;
			}
			req.getRequestDispatcher(to).forward(req, resp);
		} catch (ServletException | IOException | SQLException e) {
			e.printStackTrace();
			if(to != null && to.equals("HandleBugServlet_list")){
				to = "HandleBugServlet?method=list&status=4";
			}
			else{
				to = "BugServlet?method=list&to=tester_listBug&status=4&projectId=" + projectId + "&level=" + level + "&status2=" + status2 + "&page=" + page + "&userId=" + userId;
			}
			try {
				req.getRequestDispatcher(to).forward(req, resp);
			} catch (ServletException e1) {
				e1.printStackTrace();
			} catch (IOException e1) {
				e1.printStackTrace();
			}
			
		}
	}

	private void list(HttpServletRequest req, HttpServletResponse resp) {
		String status = req.getParameter("status");
		String to = req.getParameter("to");
		String respType = req.getParameter("respType");
		int projectId = StringUtil.stringToInt(req.getParameter("projectId"));
		int level = StringUtil.stringToInt(req.getParameter("level"));
		int status2 = StringUtil.stringToInt(req.getParameter("status2"));
		int page = StringUtil.stringToInt(req.getParameter("page"));
		int userId = StringUtil.stringToInt(req.getParameter("userId"));
		req.setAttribute("projectId", projectId);
		req.setAttribute("level", level);
		req.setAttribute("status2", status2);
		req.setAttribute("userId", userId);
		
		log.info("projectId:" + projectId + ",level:" + level + ",status2:" + status2);
		try {
			int totalCount = bugDao.getCount(userId,level,status2,projectId);
			PagingBean pagingBean = new PagingBean(totalCount,page,Constants.PAGE_SIZE);
			pagingBean.setPreUrl(req.getContextPath() + "/BugServlet?method=list&to=" + to + "&respType=" + respType + "&projectId=" + projectId + "&status2=" + status2 + "&level=" + level + "&userId=" + userId);
			pagingBean.setAnd(true);
			page = pagingBean.getCurrentPage();
			req.setAttribute("page", page);
			req.setAttribute("pageMsg", pagingBean.getHtmlMsg());
			List<BugBean> list = bugDao.getAllByPage(userId,level,status2,projectId,page * Constants.PAGE_SIZE,Constants.PAGE_SIZE);
			log.info("list:length:" + list.size());
			log.info("list:" + list);
			for (BugBean bugBean : list) {
				bugBean.setProjectBean(projectDao.getById(bugBean.getProjectId()));
				bugBean.setUserBean(userDao.getById(bugBean.getUserId()));
			}
			log.info("list:" + list);
			if(respType != null && respType.equals("typeJson")){
				log.info("respType:" + respType);
				resp.setContentType("text/json; charSet=UTF-8");
				pagingBean.setJson(true);
				PrintWriter out = resp.getWriter();
				String outMsg = "{\"bugBean\":" + JSON.toJSONString(list) + ",\"pageMsg\":" +JSON.toJSONString(pagingBean.getHtmlMsg()) + "}";
				out.write(outMsg);
				System.out.println(outMsg);
				out.flush();
				out.close();
			}
			else{
				if(list != null && list.size() == 0){
					list = null;
				}
				req.setAttribute("bugList", list);
				List<UserBean> uList = userDao.getAll(2);
				req.setAttribute("userList", uList);
				List<ProjectBean> pList = projectDao.getAll();
				req.setAttribute("projectList", pList);
				to = to.replace("_", "/") + ".jsp";
				if(status != null && !status.equals("")){
					to += "?status=" + status;
				}
				req.getRequestDispatcher(to).forward(req, resp);
			}
		} catch (ServletException | IOException | SQLException e) {
			e.printStackTrace();
		}
	}

	private void toUpdate(HttpServletRequest req, HttpServletResponse resp) {
		int id = StringUtil.stringToInt(req.getParameter("id"));
		log.info("获取到的id:" + id);
		int projectId = StringUtil.stringToInt(req.getParameter("projectId"));
		int level = StringUtil.stringToInt(req.getParameter("level"));
		int status2 = StringUtil.stringToInt(req.getParameter("status2"));
		int page = StringUtil.stringToInt(req.getParameter("page"));
		int userId = StringUtil.stringToInt(req.getParameter("userId"));
		try {
			BugBean bugBean = bugDao.getById(id);
			log.info("获取到的bugBean:" + bugBean);
			req.setAttribute("updateBean", bugBean);
			
			List<ProjectBean> list = projectDao.getAll();
			req.setAttribute("projectList", list);
			req.setAttribute("projectId", projectId);
			req.setAttribute("level", level);
			req.setAttribute("status2", status2);
			req.setAttribute("page", page);
			req.setAttribute("userId", userId);
			
			
			req.getRequestDispatcher("tester/addBug.jsp").forward(req, resp);
		} catch (ServletException | IOException | SQLException e) {
			e.printStackTrace();
		}
	}




	private void add(HttpServletRequest req, HttpServletResponse resp) {
		BugBean bugBean = new BugBean();
		try {
			BeanUtils.populate(bugBean, req.getParameterMap());
			if(bugBean.getId() != 0){
				//为更新操作
				int projectId = StringUtil.stringToInt(req.getParameter("projectId2"));
				int level = StringUtil.stringToInt(req.getParameter("level2"));
				int status2 = StringUtil.stringToInt(req.getParameter("status2"));
				int page = StringUtil.stringToInt(req.getParameter("page2"));
				int userId = StringUtil.stringToInt(req.getParameter("userId2"));
				System.out.println("addBug:projectId   :   " + projectId);
				boolean flag = bugDao.update(bugBean);
				resp.sendRedirect("BugServlet?method=list&to=tester_listBug&status=" + (flag ? 1 : 2) + "&projectId=" + projectId + "&level=" + level + "&status2=" + status2 + "&page=" + page + "&userId=" + userId);
				
			}
			else{
				//为添加操作
				UserBean userBean = (UserBean) req.getSession().getAttribute("loginUserBean");
				bugBean.setStatus(1);
				bugBean.setUserId(userBean.getId());
				bugBean.setCreateDate(DateUtil.getDate());
				boolean flag = bugDao.add(bugBean);
				resp.sendRedirect("BugServlet?method=toAdd&status=" + (flag ? 1 : 2));
				
			}
		} catch (IllegalAccessException | InvocationTargetException | IOException | SQLException e) {
			e.printStackTrace();
		}
	}
	
	
	

}
