package servlet;

import java.io.File;
import java.io.IOException;

import javax.servlet.ServletConfig;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.BasicConfigurator;
import org.apache.log4j.PropertyConfigurator;

/**
 * Servlet implementation class InitServlet
 */
@WebServlet(name="/InitServlet",loadOnStartup=1)
public class InitServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public InitServlet() {
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
	public void init(ServletConfig config) throws ServletException {
		System.out.println("开始初始化log4j配置servlet");
		String log4jLocation = config.getInitParameter("log4j-properties-location");
		
		ServletContext sc = config.getServletContext();
		
		if(log4jLocation == null){
			//没有配置配置文件路径，采用log4j默认配置初始化
			System.out.println("没有配置配置文件路径，采用log4j默认配置初始化");
			BasicConfigurator.configure();
		}
		else{
			//存在配置文件路径
			String webAppPath = sc.getRealPath("/");
			String log4jProperties = webAppPath + log4jLocation;
			File file = new File(log4jProperties);
			if(file.exists()){
				//配置文件存在，使用配置文件初始化log4j
				System.out.println("配置文件存在，使用配置文件初始化log4j");
				PropertyConfigurator.configure(log4jProperties);
			}
			else{
				//配置文件没有找到，使用log4j默认配置进行初始化
				System.out.println("配置文件没有找到，使用log4j默认配置进行初始化");
				BasicConfigurator.configure();
				
			}
		}
	}
	
	

}
