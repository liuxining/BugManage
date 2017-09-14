package servlet;

import java.io.IOException;
import java.io.PrintWriter;
import java.lang.reflect.InvocationTargetException;
import java.sql.SQLException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.beanutils.BeanUtils;

import bean.BugBean;
import bean.HandleBugBean;
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
 * Servlet implementation class UserServlet
 */
@WebServlet("/UserServlet")
public class UserServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private UserDao userDao = new UserDao();
	private HandleBugDao handleBugDao = new HandleBugDao();
	private BugDao bugDao = new BugDao();
	private ProjectDao projectDao = new ProjectDao();
	
	
	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public UserServlet() {
		super();
		// TODO Auto-generated constructor stub
	}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.getWriter().append("Served at: ").append(request.getContextPath());
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

	@Override
	protected void service(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		req.setCharacterEncoding("UTF-8");
		String method = req.getParameter("method");
		if ("register".equals(method)) {
			register(req, resp);
		} else if ("checkDup".equals(method)) {
			checkDup(req, resp);
		} else if ("login".equals(method)) {
			login(req, resp);
		}else if("toUpdate".equals(method)){
			toUpdate(req,resp);
		}
		else if("detail".equals(method)){
			detail(req,resp);
		}
		else if("list".equals(method)){
			list(req,resp);
		}
		else if("delete".equals(method)){
			delete(req,resp);
		}
		else if("upStat".equals(method)){
			upStat(req,resp);
		}
		else if("logout".equals(method)){
			logout(req,resp);
		}
	}

	private void logout(HttpServletRequest req, HttpServletResponse resp) {
		req.getSession().invalidate();
		try {
			resp.sendRedirect("login.jsp?status=4");
		} catch (IOException e) {
			e.printStackTrace();
		}
	}

	private void upStat(HttpServletRequest req, HttpServletResponse resp) {
		UserBean userBean = new UserBean();
		try {
			BeanUtils.populate(userBean, req.getParameterMap());
			boolean flag = false;
			
			if(userBean.getId() != 1){
				flag = userDao.update(userBean);
				//userBean.setStatus(3);
			}
			resp.getWriter().print(userBean.getId() + "#" + userBean.getStatus() + "#" + (flag ? "1" : "2"));
			resp.getWriter().flush();
			resp.getWriter().close();
		} catch (IllegalAccessException e) {
			e.printStackTrace();
		} catch (InvocationTargetException e) {
			e.printStackTrace();
		} catch (SQLException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}
		
		
		
	}

	private void delete(HttpServletRequest req, HttpServletResponse resp) {
		int id = StringUtil.stringToInt(req.getParameter("id"));
		int type = StringUtil.stringToInt(req.getParameter("type"));
		int status2 = StringUtil.stringToInt(req.getParameter("status2"));
		int page = StringUtil.stringToInt(req.getParameter("page"));
		int status = 4;
		try {
			boolean flag = false;
			if(id == 1){
				flag = false;
				status = 5;
			}
			else{
				flag = userDao.delete(id);
				if(flag){
					status = 3;
				}
			}
			
			req.getRequestDispatcher("UserServlet?method=list&status=" + status + "&type=" + type + "&status2=" + status2 + "&page=" + page).forward(req, resp);
		} catch (SQLException | ServletException | IOException e) {
			e.printStackTrace();
			try {
				req.getRequestDispatcher("UserServlet?method=list&status=" + status + "&type=" + type + "&status2=" + status2 + "&page=" + page).forward(req, resp);
			} catch (ServletException | IOException e1) {
				e1.printStackTrace();
			}
		}
	}

	private void list(HttpServletRequest req, HttpServletResponse resp) {
		String status = req.getParameter("status");
		int type = StringUtil.stringToInt(req.getParameter("type"));
		int status2 = StringUtil.stringToInt(req.getParameter("status2"));
		int page = StringUtil.stringToInt(req.getParameter("page"));
		List<UserBean> list;
		try {
			int count = userDao.getCount(type, status2);
			PagingBean pagingBean = new PagingBean(count, page, Constants.PAGE_SIZE);
			pagingBean.setPreUrl("UserServlet?method=list&type=" + type + "&status2=" + status2);
			pagingBean.setAnd(true);
			page = pagingBean.getCurrentPage();
			req.setAttribute("pageMsg", pagingBean.getHtmlMsg());
			list = userDao.getAllByPage(type, status2, page * Constants.PAGE_SIZE, Constants.PAGE_SIZE);
			req.setAttribute("userList", list);
			req.setAttribute("type", type);
			req.setAttribute("status2", status2);
			req.setAttribute("page", page);
			req.getRequestDispatcher("leader/user/userList.jsp" + (status == null ? "" : "?status=" + status)).forward(req, resp);
		} catch (SQLException | ServletException | IOException e) {
			e.printStackTrace();
		}
	}

	private void detail(HttpServletRequest req, HttpServletResponse resp) {
		int id = StringUtil.stringToInt(req.getParameter("id"));
		String to = req.getParameter("to");
		String status = req.getParameter("status");
		int page = StringUtil.stringToInt(req.getParameter("page"));
		UserBean userBean;
		try {
			userBean = userDao.getById(id);
			req.setAttribute("userBean", userBean);
			if(to.equals("leader_user_userDetail")){
				if(userBean.getType() == 1){
					//用户为开发人员
					int level = StringUtil.stringToInt(req.getParameter("level"));
					int bugId = StringUtil.stringToInt(req.getParameter("bugId"));
					req.setAttribute("level", level);
					req.setAttribute("bugId", bugId);
					//获取用户提交的Bug解决方案列表
					int count = handleBugDao.getCount(id, level, bugId, 0, 0);
					PagingBean pagingBean = new PagingBean(count, page, Constants.PAGE_SIZE);
					pagingBean.setPreUrl(req.getContextPath() + "/UserServlet?method=detail&to=" + to + "&id=" + id + "&level=" + level + "&bugId=" + bugId);
					pagingBean.setAnd(true);
					page = pagingBean.getCurrentPage();
					req.setAttribute("pageMsg", pagingBean.getHtmlMsg());
					List<HandleBugBean> list = handleBugDao.getAllByPage(id,level,bugId,0,page * Constants.PAGE_SIZE,Constants.PAGE_SIZE);
					for (HandleBugBean handleBugBean : list) {
						handleBugBean.setBugBean(bugDao.getById(handleBugBean.getBugId()));
					}
					System.out.println("开发人员提交的Bug解决方案：" + list);
					req.setAttribute("handleBugList", list);
					List<BugBean> bList = bugDao.getAll();
					req.setAttribute("bugList", bList);
				}
				else if(userBean.getType() == 2){
					//用户为测试人员
					//获取用户提交的Bug列表
					
					int level = StringUtil.stringToInt(req.getParameter("level"));
					int status2 = StringUtil.stringToInt(req.getParameter("status2"));
					int projectId = StringUtil.stringToInt(req.getParameter("projectId"));
					int count = bugDao.getCount(userBean.getId(), level, status2, projectId);
					req.setAttribute("level", level);
					req.setAttribute("status2", status2);
					req.setAttribute("projectId", projectId);
					PagingBean pagingBean = new PagingBean(count, page, Constants.PAGE_SIZE);
					pagingBean.setPreUrl(req.getContextPath() + "/UserServlet?method=detail&to=" + to + "&id=" + id + "&level=" + level + "&status2=" + status2 + "&projectId=" + projectId);
					pagingBean.setAnd(true);
					page = pagingBean.getCurrentPage();
					req.setAttribute("pageMsg", pagingBean.getHtmlMsg());
					
					List<BugBean> list = bugDao.getAllByPage(userBean.getId(),level,status2,projectId,page * Constants.PAGE_SIZE,Constants.PAGE_SIZE);
					for (BugBean bugBean : list) {
						bugBean.setProjectBean(projectDao.getById(bugBean.getProjectId()));
					}
					System.out.println("测试人员提交的Bug：" + list);
					req.setAttribute("bugList", list);
					//获取所有项目列表
					List<ProjectBean> pList = projectDao.getAll();
					req.setAttribute("projectList", pList);
				}
				else{
					//用户为项目经理
					int type = StringUtil.stringToInt(req.getParameter("type"));
					int status2 = StringUtil.stringToInt(req.getParameter("status2"));
					int count = projectDao.getCount(id, type, status2);
					req.setAttribute("type", type);
					req.setAttribute("status2", status2);
					
					PagingBean pagingBean = new PagingBean(count, page, Constants.PAGE_SIZE);
					pagingBean.setPreUrl(req.getContextPath() + "/UserServlet?method=detail&to=" + to + "&id=" + id + "&type=" + type + "&status2=" + status2);
					pagingBean.setAnd(true);
					page = pagingBean.getCurrentPage();
					req.setAttribute("pageMsg", pagingBean.getHtmlMsg());
					List<ProjectBean> projectList = projectDao.getAllByPage(id,type,status2,page * Constants.PAGE_SIZE,Constants.PAGE_SIZE);
					req.setAttribute("projectList", projectList);
				}
			}
			to = to.replace("_", "/");
			System.out.println("to= " + to + " 将跳转值个人信息页面");
			req.getRequestDispatcher(to + ".jsp" + (status == null ? "" : "?status=" + status)).forward(req, resp);;
		} catch (SQLException | ServletException | IOException e) {
			e.printStackTrace();
		}
		
		
	}

	private void toUpdate(HttpServletRequest req, HttpServletResponse resp) {
		int id = StringUtil.stringToInt(req.getParameter("id"));
		int type = StringUtil.stringToInt(req.getParameter("type"));
		int status2 = StringUtil.stringToInt(req.getParameter("status2"));
		int page = StringUtil.stringToInt(req.getParameter("page"));
		String optr = req.getParameter("optr");
		try {
			UserBean loginUserBean = (UserBean) req.getSession().getAttribute("loginUserBean");
			if(id != 1 || (id == 1 && loginUserBean.getId() == 1)){
				UserBean userBean = userDao.getById(id);
				req.setAttribute("updateBean", userBean);
				req.setAttribute("optr", optr);
				req.setAttribute("type", type);
				req.setAttribute("status2", status2);
				req.setAttribute("page", page);
				req.getRequestDispatcher("register.jsp").forward(req, resp);
			}
			else{
				req.getRequestDispatcher("UserServlet?methid=list&type=" + type + "&status2=" + status2 + "&page=" + page + "&status=5").forward(req, resp);
			}
		} catch (SQLException | ServletException | IOException e) {
			e.printStackTrace();
		}
		
	}

	private void login(HttpServletRequest req, HttpServletResponse resp) {
		String num = req.getParameter("num");
		String password = req.getParameter("password");
		int type = StringUtil.stringToInt(req.getParameter("type"));
		
		UserBean userBean = null;
		try {
			userBean = userDao.getByNum(num);
			if (userBean != null) {
				if(userBean.getType() == type){
					if (userBean.getPassword().equals(password)) {
						// 登录成功
						if(userBean.getStatus() != 3){
							resp.sendRedirect("login.jsp?status=" + (userBean.getStatus() + 8));
						}
						else{
							req.getSession().setAttribute("loginUserBean", userBean);
							Cookie cookie = new Cookie("loginUserId",userBean.getId() + "");
							cookie.setPath("/");
							cookie.setMaxAge(60 * 5);
							resp.addCookie(cookie);
							
							System.out.println(userBean + " 登录成功！");
							if(userBean.getType() == 1){
								resp.sendRedirect("CollectServlet?method=toProgrammerIndex&to=programmer_main");
							}
							else if(userBean.getType() == 2){
								//测试人员
								resp.sendRedirect("CollectServlet?method=toTesterIndex&to=tester_main");
							}
							else{
								//项目经理
								resp.sendRedirect("CollectServlet?method=toLeaderIndex&to=leader_main");
							}
						}
					} else {
						// 密码错误
						System.out.println(num + " 密码错误");
						resp.sendRedirect("login.jsp?status=2");
					}
					
				}
				else{
					//用户类型不匹配
					resp.sendRedirect("login.jsp?status=3");
					
				}
			} else {
				// 工号不存在
				System.out.println(num + " 不存在！");
				resp.sendRedirect("login.jsp?status=1");
			}
		} catch (SQLException | IOException e) {
			e.printStackTrace();
		}
	}

	private void checkDup(HttpServletRequest req, HttpServletResponse resp) {
		String num = req.getParameter("num");
		try {
			PrintWriter out = resp.getWriter();
			UserBean userBean = userDao.getByNum(num);
			if (userBean != null) {
				System.out.println(num + "已存在");
				out.write("1");
			} else {
				System.out.println(num + "不存在");
				out.write("0");
			}
			out.flush();
			out.close();
		} catch (SQLException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}
	}

	private void register(HttpServletRequest req, HttpServletResponse resp) {
		String date = req.getParameter("birthDay");
		String sex = req.getParameter("sex");
		System.out.println(date + "," + sex);
		String optr = req.getParameter("optr");
		UserBean userBean = new UserBean();
		try {
			BeanUtils.populate(userBean, req.getParameterMap());
		} catch (IllegalAccessException | InvocationTargetException e) {
			e.printStackTrace();
		}
		// 保存到数据库
		try {
			if(userBean.getId() != 0){
				//为更新操作
				boolean flag = userDao.update(userBean);
				if(optr != null && optr.equals("user")){
					String to = req.getParameter("to");
					System.out.println("跳转到个人详情，to=" + to);
					resp.sendRedirect("UserServlet?method=detail&to=" + to + "&status=1&id=" + userBean.getId());
				}
				else{
					int type = StringUtil.stringToInt(req.getParameter("type2"));
					int status2 = StringUtil.stringToInt(req.getParameter("status2"));
					int page = StringUtil.stringToInt(req.getParameter("page2"));
					resp.sendRedirect("UserServlet?method=list&type=0&status=" + (flag ? 1 : 2) + "&type=" + type + "&status2=" + status2 + "&page=" + page);
					
				}
			}
			else{
				//为添加操作
				userBean.setCreateDate(DateUtil.getDate());
				System.out.println(userBean + " 注册成功！");
				if(optr != null && optr.equals("admin")){
					userBean.setStatus(3);
					boolean flag = userDao.add(userBean);
					req.getRequestDispatcher("register.jsp?status=" + (flag ? 3 : 4)).forward(req, resp);
				}
				else{
					userBean.setStatus(1);
					boolean flag = userDao.add(userBean);
					if(flag){
						resp.sendRedirect("login.jsp?status=7");
					}
					else{
						resp.sendRedirect("register.jsp?status=8");
						
					}
				}
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		} catch (ServletException e) {
			e.printStackTrace();
		}
	}
}
