package dao;

import java.sql.SQLException;
import java.util.List;

import org.apache.commons.dbutils.QueryRunner;
import org.apache.commons.dbutils.handlers.BeanHandler;
import org.apache.commons.dbutils.handlers.BeanListHandler;
import org.apache.commons.dbutils.handlers.ScalarHandler;

import bean.HandleBugBean;
import util.DataSourceUtil;

public class HandleBugDao {

	public boolean add(HandleBugBean handleBugBean) throws SQLException {
		QueryRunner runner = new QueryRunner(DataSourceUtil.getDataSource());
		String sql = "insert handleBug(bugId,userId,level,status,descr,date,pass) values(?,?,?,?,?,?,?)";
		int count = runner.update(sql, handleBugBean.getBugId(),handleBugBean.getUserId(),handleBugBean.getLevel(),handleBugBean.getStatus(),handleBugBean.getDescr(),handleBugBean.getDate(),handleBugBean.getPass());
		return count == 1;
		
	}

	public List<HandleBugBean> getByBugId(int bugId) throws SQLException {
		QueryRunner runner = new QueryRunner(DataSourceUtil.getDataSource());
		String sql = "select * from handleBug where bugId=? order by date desc";
		List<HandleBugBean> list = null;
		list = runner.query(sql, new BeanListHandler<HandleBugBean>(HandleBugBean.class), bugId);
		return list;
	}

	public boolean delete(int id) throws SQLException {
		QueryRunner runner = new QueryRunner(DataSourceUtil.getDataSource());
		String sql = "delete from handleBug where id=?";
		int count = runner.update(sql, id);
		return count == 1;
	}

	public List<HandleBugBean> getByUserId(int userId) throws SQLException {
		QueryRunner runner = new QueryRunner(DataSourceUtil.getDataSource());
		String sql = "select * from handleBug where userId=? order by date desc";
		List<HandleBugBean> list = null;
		list = runner.query(sql, new BeanListHandler<HandleBugBean>(HandleBugBean.class), userId);
		return list;
		
	}

	public boolean shenHe(int id, int pass) throws SQLException {
		QueryRunner runner = new QueryRunner(DataSourceUtil.getDataSource());
		String sql = "update handleBug set pass=? where id=?";
		int count = runner.update(sql, pass,id);
		return count == 1;
		
	}

	public List<HandleBugBean> getAll(int userId, int level, int bugId,int pass) throws SQLException {
		QueryRunner runner = new QueryRunner(DataSourceUtil.getDataSource());
		String sql = "select * from handleBug where 1=1";
		if(userId != 0){
			sql += " and userId=" + userId;
		}
		if(level != 0){
			sql += " and level=" + level;
		}
		if(bugId != 0){
			sql += " and bugId=" + bugId;
		}
		if(pass != 0){
			sql += " and pass=" + pass;
		}
		sql += " order by date desc";		
		List<HandleBugBean> list = null;
		list = runner.query(sql, new BeanListHandler<HandleBugBean>(HandleBugBean.class));
		return list;
		
		
	}
	public int getCount(int userId, int level, int bugId,int pass, int projectId) throws SQLException {
		QueryRunner runner = new QueryRunner(DataSourceUtil.getDataSource());
		String sql = "select count(*) from handleBug where 1=1";
		if(userId != 0){
			sql += " and userId=" + userId;
		}
		if(level != 0){
			sql += " and level=" + level;
		}
		if(bugId != 0){
			sql += " and bugId=" + bugId;
		}
		if(pass != 0){
			sql += " and pass=" + pass;
		}
		if(projectId != 0){
			sql += " and bugId in (select id from bug where projectId=" + projectId + ")";
		}
		int count = ((Long)runner.query(sql, new ScalarHandler<Long>())).intValue();
		return count;
		
		
	}

	public List<HandleBugBean> getAllByPage(int userId, int level, int bugId, int pass,int start,int size) throws SQLException {
		QueryRunner runner = new QueryRunner(DataSourceUtil.getDataSource());
		String sql = "select * from handleBug where 1=1";
		if(userId != 0){
			sql += " and userId=" + userId;
		}
		if(level != 0){
			sql += " and level=" + level;
		}
		if(bugId != 0){
			sql += " and bugId=" + bugId;
		}
		if(pass != 0){
			sql += " and pass=" + pass;
		}
		sql += " order by date desc";
		sql += " limit " + start + "," + size;
		List<HandleBugBean> list = null;
		list = runner.query(sql, new BeanListHandler<HandleBugBean>(HandleBugBean.class));
		return list;
		
	}

	public HandleBugBean getById(int id) throws SQLException {
		QueryRunner runner = new QueryRunner(DataSourceUtil.getDataSource());
		String sql = "select * from handleBug where id=?";
		HandleBugBean handleBugBean = null;
		handleBugBean = runner.query(sql, new BeanHandler<HandleBugBean>(HandleBugBean.class), id);
		return handleBugBean;
	}

	public void update(HandleBugBean handleBugBean) throws SQLException {
		QueryRunner runner = new QueryRunner(DataSourceUtil.getDataSource());
		String sql = "update handleBug set descr=? where id=?";
		runner.update(sql, handleBugBean.getDescr(),handleBugBean.getId());
	}

}
