package dao;

import java.sql.SQLException;
import java.util.List;

import org.apache.commons.dbutils.QueryRunner;
import org.apache.commons.dbutils.handlers.BeanHandler;
import org.apache.commons.dbutils.handlers.BeanListHandler;
import org.apache.commons.dbutils.handlers.ScalarHandler;

import bean.BugBean;
import util.DataSourceUtil;

public class BugDao {

	public boolean add(BugBean bugBean) throws SQLException {
		QueryRunner runner = new QueryRunner(DataSourceUtil.getDataSource());
		String sql = "insert into bug(userId,projectId,level,status,title,descr,createDate) values(?,?,?,?,?,?,?)";
		int count = runner.update(sql, bugBean.getUserId(),bugBean.getProjectId(),bugBean.getLevel(),bugBean.getStatus(),bugBean.getTitle(),bugBean.getDescr(),bugBean.getCreateDate());
		return (count == 1);
	}
	
	public boolean update(BugBean bugBean) throws SQLException {
		QueryRunner runner = new QueryRunner(DataSourceUtil.getDataSource());
		String sql = "update bug set id=" + bugBean.getId();
		if(bugBean.getDescr() != null){
			sql += ",descr='" + bugBean.getDescr() + "'";
		}
		if(bugBean.getStatus() != 0){
			sql += ",status=" + bugBean.getStatus();
		}
		if(bugBean.getLevel() != 0){
			sql += ",level=" + bugBean.getLevel();
		}
		if(bugBean.getProjectId() != 0){
			sql += ",projectId=" + bugBean.getProjectId();
		}
		if(bugBean.getTitle() != null){
			sql += ",title='" + bugBean.getTitle() + "'"; 
		}
		sql += " where id=" + bugBean.getId();
		int count = runner.update(sql);
		return count == 1;
	}
	
	public BugBean getById(int id) throws SQLException{
		QueryRunner runner = new QueryRunner(DataSourceUtil.getDataSource());
		String sql = "select * from bug where id=?";
		BugBean bugBean = null;
		bugBean = runner.query(sql, new BeanHandler<BugBean>(BugBean.class), id);
		return bugBean;
	}


	public List<BugBean> getAll() throws SQLException {
		QueryRunner runner = new QueryRunner(DataSourceUtil.getDataSource());
		String sql = "select * from bug order by createDate desc";
		List<BugBean> list = null;
		list = runner.query(sql, new BeanListHandler<BugBean>(BugBean.class));
		return list;
	}


	public boolean delete(int id) throws SQLException {
		QueryRunner runner = new QueryRunner(DataSourceUtil.getDataSource());
		String sql = "delete from bug where id=?";
		int count = runner.update(sql, id);
		return count == 1;
		
	}

	public boolean close(int id) throws SQLException {
		QueryRunner runner = new QueryRunner(DataSourceUtil.getDataSource());
		String sql = "update bug set status=5 where id=?";
		int count = runner.update(sql,id);
		return count == 1;
	}

	public List<BugBean> getByUserId(int userId) throws SQLException {
		QueryRunner runner = new QueryRunner(DataSourceUtil.getDataSource());
		String sql = "select * from bug where userId=? order by createDate desc";
		List<BugBean> list = null;
		list = runner.query(sql, new BeanListHandler<BugBean>(BugBean.class),userId);
		return list;
	}

	public List<BugBean> getAll(int userId, int level, int status, int projectId) throws SQLException {
		QueryRunner runner = new QueryRunner(DataSourceUtil.getDataSource());
		String sql = "select * from bug where 1=1";
		if(userId != 0){
			sql += " and userId=" + userId;
		}
		if(level != 0){
			sql += " and level=" + level;
		}
		if(status != 0){
			sql += " and status=" + status;
		}
		if(projectId != 0){
			sql += " and projectId=" + projectId;
		}
		sql += " order by createDate desc";
		List<BugBean> list = null;
		list = runner.query(sql, new BeanListHandler<BugBean>(BugBean.class));
		return list;
		
	}
	
	public List<BugBean> getAllByPage(int userId, int level, int status, int projectId,int start,int size) throws SQLException {
		QueryRunner runner = new QueryRunner(DataSourceUtil.getDataSource());
		String sql = "select * from bug where 1=1";
		if(userId != 0){
			sql += " and userId=" + userId;
		}
		if(level != 0){
			sql += " and level=" + level;
		}
		if(status != 0){
			sql += " and status=" + status;
		}
		if(projectId != 0){
			sql += " and projectId=" + projectId;
		}
		sql += " order by createDate desc";
		sql += " limit " + start + "," + size;
		List<BugBean> list = null;
		list = runner.query(sql, new BeanListHandler<BugBean>(BugBean.class));
		return list;
		
	}

	public boolean upStat(int id, int status) throws SQLException {
		QueryRunner runner = new QueryRunner(DataSourceUtil.getDataSource());
		String sql = "update bug set status=? where id=?";
		int count = runner.update(sql,status,id);
		return count == 1;
		
	}

	public int getCount(int userId, int level, int status, int projectId) throws SQLException {
		QueryRunner runner = new QueryRunner(DataSourceUtil.getDataSource());
		String sql = "select count(*) from bug where 1=1";
		if(userId != 0){
			sql += " and userId=" + userId;
		}
		if(level != 0){
			sql += " and level=" + level;
		}
		if(status != 0){
			sql += " and status=" + status;
		}
		if(projectId != 0){
			sql += " and projectId=" + projectId;
		}
		int count = ((Long)runner.query(sql, new ScalarHandler<Long>())).intValue();
		return count;
		
	}

	

}
