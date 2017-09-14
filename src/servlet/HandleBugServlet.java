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
import bean.HandleBugBean;
import bean.PagingBean;
import bean.UserBean;
import dao.BugDao;
import dao.HandleBugDao;
import dao.UserDao;
import util.Constants;
import util.DateUtil;
import util.StringUtil;

/**
 * Servlet implementation class HandleBugServlet
 */
@WebServlet("/HandleBugServlet")
public class HandleBugServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	private static Logger log = Logger.getLogger(HandleBugServlet.class.getName());
	
	private HandleBugDao handleBugDao = new HandleBugDao();

	private UserDao userDao = new UserDao();

	private BugDao bugDao = new BugDao();
	
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public HandleBugServlet() {
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
		if("handleBug".equals(method)){
			handleBug(req,resp);
		}
		else if("testerBugDetailHandleBugList".equals(method)){
			testerBugDetailHandleBugList(req,resp);
		}
		else if("delete".equals(method)){
			delete(req,resp);
		}
		else if("getBugByUserId".equals(method)){
			getBugByUserId(req,resp);
		}
		else if("shenHe".equals(method)){
			shenHe(req,resp);
		}
		else if("leaderListHandleBugList".equals(method)){
			leaderListHandleBugList(req,resp);
		}
		else if("leaderListHandleBugDelete".equals(method)){
			leaderListHandleBugDelete(req,resp);
		}
		else if("toUpdate".equals(method)){
			toUpdate(req,resp);
		}
	}

	private void toUpdate(HttpServletRequest req, HttpServletResponse resp) {
		int id = StringUtil.stringToInt(req.getParameter("id"));
		int bugId = StringUtil.stringToInt(req.getParameter("bugId"));
		int pass = StringUtil.stringToInt(req.getParameter("pass"));
		int userId = StringUtil.stringToInt(req.getParameter("userId"));
		int page = StringUtil.stringToInt(req.getParameter("page"));
		
		req.setAttribute("bugId", bugId);
		req.setAttribute("pass", pass);
		req.setAttribute("userId", userId);
		req.setAttribute("page", page);
		
		try {
			HandleBugBean handleBugBean = handleBugDao.getById(id);
			req.setAttribute("updateBean", handleBugBean);
			req.getRequestDispatcher("BugServlet?method=detail&id=" + handleBugBean.getBugId() + "&to=programmer_handleBug").forward(req, resp);
		} catch (SQLException | ServletException | IOException e) {
			e.printStackTrace();
		}
		
	}

	private void leaderListHandleBugDelete(HttpServletRequest req, HttpServletResponse resp) {
		int id = StringUtil.stringToInt(req.getParameter("id"));
		int bugId = StringUtil.stringToInt(req.getParameter("bugId"));
		int pass = StringUtil.stringToInt(req.getParameter("pass"));
		int userId = StringUtil.stringToInt(req.getParameter("userId"));
		int page = StringUtil.stringToInt(req.getParameter("page"));
		String to = req.getParameter("to");
		
		try {
			boolean flag = handleBugDao.delete(id);
			req.getRequestDispatcher("HandleBugServlet?method=leaderListHandleBugList&status=" + (flag ? 3 : 4) + "&bugId=" + bugId + "&pass=" + pass + "&userId=" + userId + "&page=" + page + "&to=" + to).forward(req, resp);
		} catch (SQLException | ServletException | IOException e) {
			e.printStackTrace();
		}
	}

	private void leaderListHandleBugList(HttpServletRequest req, HttpServletResponse resp) {
		int bugId = StringUtil.stringToInt(req.getParameter("bugId"));
		int pass = StringUtil.stringToInt(req.getParameter("pass"));
		int userId = StringUtil.stringToInt(req.getParameter("userId"));
		int page = StringUtil.stringToInt(req.getParameter("page"));
		String status = req.getParameter("status");
		String to = req.getParameter("to");
		req.setAttribute("bugId", bugId);
		req.setAttribute("pass", pass);
		req.setAttribute("userId", userId);
		try {
			int count = handleBugDao.getCount(userId, 0, bugId, pass,0);
			PagingBean pagingBean = new PagingBean(count, page, Constants.PAGE_SIZE);
			pagingBean.setPreUrl(req.getContextPath() + "/HandleBugServlet?method=leaderListHandleBugList&bugId=" + bugId + "&pass=" + pass + "&userId=" + userId + "&to=" + to);
			pagingBean.setAnd(true);
			page = pagingBean.getCurrentPage();
			req.setAttribute("page", page);
			req.setAttribute("pageMsg", pagingBean.getHtmlMsg());
			List<HandleBugBean> list = handleBugDao.getAllByPage(userId, 0, bugId, pass,page * Constants.PAGE_SIZE,Constants.PAGE_SIZE);
			req.setAttribute("handleBugList", list);
			for (HandleBugBean handleBugBean : list) {
				handleBugBean.setBugBean(bugDao.getById(handleBugBean.getBugId()));
				handleBugBean.setUserBean(userDao.getById(handleBugBean.getUserId()));
			}
			
			
			List<BugBean> bList = bugDao.getAll();
			List<UserBean> uList = userDao.getAll(1);
			
			req.setAttribute("bugList", bList);
			req.setAttribute("userList", uList);
			
			to = to.replace("_", "/") + ".jsp";
			req.getRequestDispatcher(to + "?status=" + (status != null ? status : "")).forward(req, resp);;
		} catch (SQLException | ServletException | IOException e) {
			e.printStackTrace();
		}
		
	}

	private void shenHe(HttpServletRequest req, HttpServletResponse resp) {
		int id = StringUtil.stringToInt(req.getParameter("id"));
		int pass = StringUtil.stringToInt(req.getParameter("pass"));
		try {
			handleBugDao.shenHe(id,pass);
			resp.getWriter().print(pass);
			resp.getWriter().flush();
			resp.getWriter().close();
		} catch (SQLException | IOException e) {
			e.printStackTrace();
		}
	}

	private void getBugByUserId(HttpServletRequest req, HttpServletResponse resp) {
		int userId = StringUtil.stringToInt(req.getParameter("userId"));
		int level = StringUtil.stringToInt(req.getParameter("level"));
		int pass = StringUtil.stringToInt(req.getParameter("pass"));
		String status = req.getParameter("status");
		String respType = req.getParameter("respType");
		log.info("获取到的id=" + userId);
		try {
			List<HandleBugBean> list = handleBugDao.getAll(userId,level,0,pass);
			for (HandleBugBean handleBugBean : list) {
				handleBugBean.setUserBean(userDao.getById(handleBugBean.getUserId()));
				handleBugBean.setBugBean(bugDao .getById(handleBugBean.getBugId()));
			}
			log.info("获取到的handleBugList:" + list);
			if(respType != null && respType.equals("typeJson")){
				PrintWriter out = resp.getWriter();
				out.write(JSON.toJSONString(list));
				out.flush();
				out.close();
			}
			else{
				if(list != null && list.size() == 0){
					list = null;
				}
				req.setAttribute("handleBugList", list);
				String url = "programmer/myBugList.jsp";
				if(status != null && status.length() > 0){
					url += "?status=" + status;
				}
				req.getRequestDispatcher(url).forward(req, resp);
			}
		} catch (IOException | SQLException | ServletException e) {
			e.printStackTrace();
		}
		
		
	}

	
	
	private void delete(HttpServletRequest req, HttpServletResponse resp) {
		int id = StringUtil.stringToInt(req.getParameter("id"));
		int userId = StringUtil.stringToInt(req.getParameter("userId"));
		try {
			boolean flag = handleBugDao.delete(id);
			resp.sendRedirect("HandleBugServlet?method=getBugByUserId&userId=" + userId + "&status=" + (flag ? 3 : 4));
		} catch (SQLException | IOException e) {
			e.printStackTrace();
			try {
				resp.sendRedirect("HandleBugServlet?method=getBugByUserId&userId=" + userId + "&status=4");
			} catch (IOException e1) {
				e1.printStackTrace();
			}
		}
		
	}

	private void testerBugDetailHandleBugList(HttpServletRequest req, HttpServletResponse resp) {
		int bugId = StringUtil.stringToInt(req.getParameter("bugId"));
		int pass = StringUtil.stringToInt(req.getParameter("pass"));
		int userId = StringUtil.stringToInt(req.getParameter("userId"));
		int page = StringUtil.stringToInt(req.getParameter("page"));
		log.info("获取到的id=" + bugId);
		PrintWriter out = null;
		try {
			int count = handleBugDao.getCount(userId, 0, bugId, pass,0);
			PagingBean pagingBean = new PagingBean(count, page, Constants.PAGE_SIZE);
			pagingBean.setJson(true);
			page = pagingBean.getCurrentPage();
			List<HandleBugBean> list = handleBugDao.getAllByPage(userId, 0, bugId, pass, page * Constants.PAGE_SIZE, Constants.PAGE_SIZE);
			for (HandleBugBean handleBugBean : list) {
				handleBugBean.setUserBean(userDao.getById(handleBugBean.getUserId()));
			}
			log.info("获取到的handleBugList:" + list);
			resp.setContentType("text/json; charSet=utf-8");
			out = resp.getWriter();
			String outMsg = "{\"handleBug\":" + JSON.toJSONString(list) + ",\"pageMsg\":" + JSON.toJSONString(pagingBean.getHtmlMsg()) + "}";
			log.info(outMsg);
			out.write(outMsg);
			out.flush();
			out.close();
		} catch (IOException | SQLException e) {
			e.printStackTrace();
		}
		
	}

	private void handleBug(HttpServletRequest req, HttpServletResponse resp) {
		HandleBugBean handleBugBean = new HandleBugBean();
		try {
			BeanUtils.populate(handleBugBean, req.getParameterMap());
			if(handleBugBean.getId() != 0){
				//更新
				int bugId = StringUtil.stringToInt(req.getParameter("bugId2"));
				int pass = StringUtil.stringToInt(req.getParameter("pass2"));
				int userId = StringUtil.stringToInt(req.getParameter("userId2"));
				int page = StringUtil.stringToInt(req.getParameter("page2"));
				handleBugDao.update(handleBugBean);
				req.getRequestDispatcher("HandleBugServlet?method=leaderListHandleBugList&bugId=" + bugId + "&pass=" + pass + "&userId=" + userId + "&page=" + page + "&to=programmer_myHandleBug" + "&status=1").forward(req, resp);
			}
			else{
				handleBugBean.setDate(DateUtil.getDate());
				UserBean userBean = (UserBean) req.getSession().getAttribute("loginUserBean");
				handleBugBean.setUserId(userBean.getId());
				handleBugBean.setPass(1);
				boolean flag = handleBugDao.add(handleBugBean);
				resp.sendRedirect("BugServlet?method=detail&to=programmer_handleBug&status=" + (flag ? 1 : 2) + "&id=" + handleBugBean.getBugId());
			}
		} catch (IllegalAccessException | InvocationTargetException | SQLException | IOException | ServletException e) {
			e.printStackTrace();
		}

	}

	
	

}
