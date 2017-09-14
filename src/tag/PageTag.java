package tag;

import java.io.IOException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.jsp.JspException;
import javax.servlet.jsp.tagext.SimpleTagSupport;

import bean.PagingBean;

public class PageTag extends SimpleTagSupport {

	private PagingBean pagingBean;
	private HttpServletRequest request;

	
	
	
	
	
	@Override
	public void doTag() throws JspException, IOException {
		StringBuffer buffer = new StringBuffer();
		buffer.append("<nav><ul class='pagination'>");
		//添加首页和上一页
		if(pagingBean.getCurrentPage() <= 0){
			//当前页为第一页
			buffer.append("<li class='disabled'><a href='#'>首页</a></li>");
			buffer.append("<li class='disabled'><a href='#'>上一页</a></li>");
		}
		else{
			//当前页不是第一页
			buffer.append("<li><a href='");
			buffer.append(pagingBean.getPreUrl() + (pagingBean.isAnd() ? "&" : "?") + "page=0");
			buffer.append("'>首页</a></li>");
			buffer.append("<li><a href='");
			buffer.append(pagingBean.getPreUrl() + (pagingBean.isAnd() ? "&" : "?") + "page=" + (pagingBean.getCurrentPage() - 1));
			buffer.append("'>上一页</a></li>");
		}
		//添加尾页和下一页
		if(pagingBean.getCurrentPage() == (pagingBean.getTotalPage() - 1)){
			//当前页为最后一页
			buffer.append("<li class='disabled'><a href='#'>下一页</a></li>");
			buffer.append("<li class='disabled'><a href='#'>尾页</a></li>");
		}
		else{
			//当前页不是最后一页
			buffer.append("<li><a href='");
			buffer.append(pagingBean.getPreUrl() + (pagingBean.isAnd() ? "&" : "?") + "page=" + (pagingBean.getCurrentPage() + 1));
			buffer.append("'>下一页</a></li>");
			buffer.append("<li><a href='");
			buffer.append(pagingBean.getPreUrl() + (pagingBean.isAnd() ? "&" : "?") + "page=" + (pagingBean.getTotalPage() - 1));
			buffer.append("'>尾页</a></li>");
		}
		
		//添加当前页码和总页码
		buffer.append("<li><a href='#'>");
		buffer.append("<span>");
		buffer.append(pagingBean.getTotalPage() > 0 ? (pagingBean.getCurrentPage() + 1) : "0");
		buffer.append("/" + pagingBean.getTotalPage());
		buffer.append("</span></a></li>");
		buffer.append("</ul></nav>");
		getJspContext().getOut().write(buffer.toString());
	}
	
	public PagingBean getPagingBean() {
		return pagingBean;
	}

	public void setPagingBean(PagingBean pagingBean) {
		this.pagingBean = pagingBean;
	}

	public HttpServletRequest getRequest() {
		return request;
	}

	public void setRequest(HttpServletRequest request) {
		this.request = request;
	}

}
