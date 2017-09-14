package filter;

import java.io.IOException;
import java.sql.SQLException;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import bean.UserBean;
import dao.UserDao;
import util.StringUtil;

/**
 * Servlet Filter implementation class LoginFilter
 */
@WebFilter(filterName="/LoginFilter",urlPatterns="/*")
public class LoginFilter implements Filter {

    /**
     * Default constructor. 
     */
    public LoginFilter() {
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see Filter#destroy()
	 */
	public void destroy() {
		// TODO Auto-generated method stub
	}

	/**
	 * @see Filter#doFilter(ServletRequest, ServletResponse, FilterChain)
	 */
	public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) throws IOException, ServletException {
		// TODO Auto-generated method stub
		// place your code here

		
		HttpServletRequest req = (HttpServletRequest) request;
		HttpServletResponse resp = (HttpServletResponse) response;
		
		req.setCharacterEncoding("UTF-8");
		UserBean userBean = null;
		String path = req.getServletPath();
		System.out.println(path);
		int status = 5;
		boolean flag = false;
		if(path.indexOf(("login.jsp")) != -1 || path.indexOf("register.jsp") != -1 || path.indexOf("static") != -1 || path.indexOf("assets") != -1){
			flag = true;
			System.out.println("访问前台允许页面");
		}
		else if(path.indexOf("UserServlet") != -1){
			String method = req.getParameter("method");
			if("checkDup".equals(method) || "register".equals(method) || "login".equals(method)){
				
				System.out.println("method=" + method + "，放行");
				flag = true;
			}
		}
		if(!flag){
			userBean = (UserBean) req.getSession().getAttribute("loginUserBean");
			if(userBean == null){
//				Cookie[] cks = req.getCookies();
//				if(cks != null && cks.length > 0){
//					for (Cookie cookie : cks) {
//						if(cookie.getName().equals("loginUserId")){
//							String value = cookie.getValue();
//							try {
//								userBean = new UserDao().getById(StringUtil.stringToInt(value));
//								req.getSession().setAttribute("loginUserBean", userBean);
//								flag = true;
//								System.out.println("cookie存在");
//								break;
//							} catch (SQLException e) {
//								e.printStackTrace();
//							}
//						}
//					}
//				}
			}
			else{
				flag = true;
				System.out.println("session不为空");
			}
			if(flag){
				if((path.indexOf("leader") != -1 && userBean.getType() != 3) || (path.indexOf("tester") != -1 && userBean.getType() == 1)){
					flag = false;
					status = 6;
				}
			}
		}
		if(!flag){
			System.out.println("需要登录");
			resp.sendRedirect(req.getContextPath() + "/login.jsp?status=" + status);
		}
		else{
			System.out.println("放行");
			chain.doFilter(req, response);
		}
		// pass the request along the filter chain
	}

	/**
	 * @see Filter#init(FilterConfig)
	 */
	public void init(FilterConfig fConfig) throws ServletException {
		// TODO Auto-generated method stub
	}

}
