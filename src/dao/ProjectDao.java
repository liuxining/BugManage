package dao;

import java.sql.SQLException;
import java.util.List;

import org.apache.commons.dbutils.QueryRunner;
import org.apache.commons.dbutils.handlers.BeanHandler;
import org.apache.commons.dbutils.handlers.BeanListHandler;
import org.apache.commons.dbutils.handlers.ScalarHandler;

import bean.ProjectBean;
import util.DataSourceUtil;
import util.DateUtil;

public class ProjectDao {
	
	public boolean add(ProjectBean projectBean) throws SQLException {
		QueryRunner runner = new QueryRunner(DataSourceUtil.getDataSource());
		String sql = "insert into project(name,descr,type,status,userId,createDate) values(?,?,?,?,?,?)";
		int count = runner.update(sql, projectBean.getName(),projectBean.getDescr(),projectBean.getType(),projectBean.getStatus(),projectBean.getUserId(),projectBean.getCreateDate());
		return count == 1;
	}

	public boolean update(ProjectBean projectBean) throws SQLException {
		QueryRunner runner = new QueryRunner(DataSourceUtil.getDataSource());
		String sql = "update project set id=" + projectBean.getId();
		if(projectBean.getDescr() != null){
			sql += ",descr='" + projectBean.getDescr() + "'";
		}
		if(projectBean.getName() != null){
			sql += ",name='" + projectBean.getName() + "'";
		}
		if(projectBean.getStatus() != 0){
			sql += ",status=" + projectBean.getStatus();
		}
		if(projectBean.getType() != 0){
			sql += ",type=" + projectBean.getType();
		}
		sql += " where id=" + projectBean.getId();
		int count = runner.update(sql);
		return count == 1;
	}
	
	public ProjectBean getById(int id) throws SQLException{
		QueryRunner runner = new QueryRunner(DataSourceUtil.getDataSource());
		String sql = "select * from project where id=?";
		ProjectBean projectBean = null;
		projectBean = runner.query(sql, new BeanHandler<ProjectBean>(ProjectBean.class), id);
		return projectBean;
	}


	public List<ProjectBean> getAll() throws SQLException {
		QueryRunner runner = new QueryRunner(DataSourceUtil.getDataSource());
		String sql = "select * from project order by createDate desc";
		List<ProjectBean> list = null;
		list = runner.query(sql, new BeanListHandler<ProjectBean>(ProjectBean.class));
		return list;
	}


	public boolean delete(int id) throws SQLException {
		QueryRunner runner = new QueryRunner(DataSourceUtil.getDataSource());
		String sql = "delete from project where id=?";
		int count = runner.update(sql, id);
		return count == 1;
	}


	public List<ProjectBean> getAll(int userId, int type, int status) throws SQLException {
		QueryRunner runner = new QueryRunner(DataSourceUtil.getDataSource());
		String sql = "select * from project where 1=1";
		if(userId != 0){
			sql += " and userId=" + userId;
		}
		if(type != 0){
			sql += " and type=" + type;
		}
		if(status != 0){
			sql += " and status=" + status;
		}
		sql += " order by createDate desc";
		List<ProjectBean> list = null;
		list = runner.query(sql, new BeanListHandler<ProjectBean>(ProjectBean.class));
		return list;
		
	}
	
	public List<ProjectBean> getAllByPage(int userId, int type, int status,int start,int size) throws SQLException {
		QueryRunner runner = new QueryRunner(DataSourceUtil.getDataSource());
		String sql = "select * from project where 1=1";
		if(userId != 0){
			sql += " and userId=" + userId;
		}
		if(type != 0){
			sql += " and type=" + type;
		}
		if(status != 0){
			sql += " and status=" + status;
		}
		sql += " order by createDate desc";
		sql += " limit " + start + "," + size;
		List<ProjectBean> list = null;
		list = runner.query(sql, new BeanListHandler<ProjectBean>(ProjectBean.class));
		return list;
		
	}
	
	public int getCount(int userId, int type, int status) throws SQLException {
		QueryRunner runner = new QueryRunner(DataSourceUtil.getDataSource());
		String sql = "select count(*) from project where 1=1";
		if(userId != 0){
			sql += " and userId=" + userId;
		}
		if(type != 0){
			sql += " and type=" + type;
		}
		if(status != 0){
			sql += " and status=" + status;
		}
		int count = ((Long)runner.query(sql, new ScalarHandler<Long>())).intValue();
		return count;
	}



}
