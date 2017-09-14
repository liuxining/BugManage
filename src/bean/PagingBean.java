package bean;

public class PagingBean {
	private int totalPage;
	private int totalCount;
	private int currentPage;
	private int pageSize;
	private String preUrl;
	private boolean isAnd;
	private String htmlMsg;
	private boolean isJson;
	
	
	

	public String getHtmlMsg() {
		StringBuffer buffer = new StringBuffer();
		buffer.append("<ul class='am-pagination'>");
		//添加首页和上一页
		if(this.getCurrentPage() <= 0){
			//当前页为第一页
			buffer.append("<li class='am-disabled'><a href='#'>首页</a></li>");
			buffer.append("<li class='am-disabled'><a href='#'>上一页</a></li>");
		}
		else{
			//当前页不是第一页
			if(isJson){
				buffer.append("<li><a href='#' onclick='showNext(0)'>首页</a></li>");
				buffer.append("<li><a href='#' onclick='showNext(");
				buffer.append(this.getCurrentPage() - 1);
				buffer.append(")'>上一页</a></li>");
				
			}
			else{
				buffer.append("<li><a href='");
				buffer.append(this.getPreUrl() + (this.isAnd() ? "&" : "?") + "page=0");
				buffer.append("'>首页</a></li>");
				buffer.append("<li><a href='");
				buffer.append(this.getPreUrl() + (this.isAnd() ? "&" : "?") + "page=" + (this.getCurrentPage() - 1));
				buffer.append("'>上一页</a></li>");
			}
		}
		//添加尾页和下一页
		if((this.getCurrentPage() == (this.getTotalPage() - 1)) || this.getTotalPage() == 0){
			//当前页为最后一页
			buffer.append("<li class='am-disabled'><a href='#'>下一页</a></li>");
			buffer.append("<li class='am-disabled'><a href='#'>尾页</a></li>");
		}
		else{
			//当前页不是最后一页
			if(isJson){
				buffer.append("<li><a href='#' onclick='showNext(");
				buffer.append(this.currentPage + 1);
				buffer.append(")'>下一页</a></li>");
				buffer.append("<li><a href='#' onclick='showNext(");
				buffer.append(this.totalPage - 1);
				buffer.append(")'>尾页</a></li>");
			}
			else{
				buffer.append("<li><a href='");
				buffer.append(this.getPreUrl() + (this.isAnd() ? "&" : "?") + "page=" + (this.getCurrentPage() + 1));
				buffer.append("'>下一页</a></li>");
				buffer.append("<li><a href='");
				buffer.append(this.getPreUrl() + (this.isAnd() ? "&" : "?") + "page=" + (this.getTotalPage() - 1));
				buffer.append("'>尾页</a></li>");
			}
		}
		
		//添加当前页码和总页码
		buffer.append("<li><a href='#'>");
		buffer.append("<span>");
		buffer.append(this.getTotalPage() > 0 ? (this.getCurrentPage() + 1) : "0");
		buffer.append("/" + this.getTotalPage());
		buffer.append("</span></a></li>");
		buffer.append("</ul>");

		return buffer.toString();
	}

	public void setHtmlMsg(String htmlMsg) {
		this.htmlMsg = htmlMsg;
	}
	
	

	public boolean isJson() {
		return isJson;
	}

	public void setJson(boolean isJson) {
		this.isJson = isJson;
	}

	public PagingBean(int totalCount,int currentPage, int pageSize) {
		this.totalCount = totalCount;
		this.totalPage = (totalCount - 1) / pageSize + 1;
		
		if(currentPage >= this.totalPage){
			currentPage = this.totalPage - 1;
		}
		if(currentPage < 0){
			currentPage = 0;
		}
		this.currentPage = currentPage;
		this.pageSize = pageSize;
	}

	public int getTotalCount() {
		return totalCount;
	}

	public void setTotalCount(int totalCount) {
		this.totalCount = totalCount;
	}

	public String getPreUrl() {
		return preUrl;
	}

	public void setPreUrl(String preUrl) {
		this.preUrl = preUrl;
	}

	public boolean isAnd() {
		return isAnd;
	}

	public void setAnd(boolean isAnd) {
		this.isAnd = isAnd;
	}

	public int getTotalPage() {
		return totalPage;
	}

	public void setTotalPage(int totalPage) {
		this.totalPage = totalPage;
	}

	public int getCurrentPage() {
		return currentPage;
	}

	public void setCurrentPage(int currentPage) {
		this.currentPage = currentPage;
	}

	public int getPageSize() {
		return pageSize;
	}

	public void setPageSize(int pageSize) {
		this.pageSize = pageSize;
	}

	@Override
	public String toString() {
		return "PagingBean [totalPage=" + totalPage + ", totalCount=" + totalCount + ", currentPage=" + currentPage
				+ ", pageSize=" + pageSize + ", preUrl=" + preUrl + ", isAnd=" + isAnd + ", htmlMsg=" + htmlMsg + "]";
	}

		
	

}
