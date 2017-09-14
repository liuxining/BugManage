package dao;

import java.sql.SQLException;
import java.util.List;

import org.apache.commons.dbutils.QueryRunner;
import org.apache.commons.dbutils.handlers.BeanHandler;
import org.apache.commons.dbutils.handlers.BeanListHandler;
import org.apache.commons.dbutils.handlers.ScalarHandler;

import bean.UserBean;
import util.DataSourceUtil;

/**
 * 
    * @ClassName: UserDao
    * @Description: 用户数据库操作类
    * @author liuxining
    * @date 2017年9月6日
    *
 */
public class UserDao {

	public boolean add(UserBean userBean) throws SQLException {
		QueryRunner runner = new QueryRunner(DataSourceUtil.getDataSource());
		String sql = "insert into user(name,password,type,sex,birthDay,phone,status,num,createDate) values(?,?,?,?,?,?,?,?,?)";
		int count = runner.update(sql, userBean.getName(),userBean.getPassword(),userBean.getType(),userBean.getSex(),userBean.getBirthDay(),userBean.getPhone(),userBean.getStatus(),userBean.getNum(),userBean.getCreateDate());
		return count == 1;
	}

	public UserBean getByNum(String num) throws SQLException {
		QueryRunner runner = new QueryRunner(DataSourceUtil.getDataSource());
		String sql = "select * from user where num=?";
		UserBean userBean = null;
		userBean = runner.query(sql, new BeanHandler<UserBean>(UserBean.class),num);
		return userBean;
		
	}

	public boolean update(UserBean userBean) throws SQLException {
		QueryRunner runner = new QueryRunner(DataSourceUtil.getDataSource());
		String sql = "update user set id='" + userBean.getId() + "'";
		if(userBean.getName() != null){
			sql += ",name='" + userBean.getName() + "'";
		}
		if(userBean.getPassword() != null && userBean.getPassword().length() > 0){
			sql += ",password='" + userBean.getPassword() + "'";
		}
		if(userBean.getPhone() != null){
			sql += ",phone='" + userBean.getPhone() + "'";
		}
		if(userBean.getSex() != 0){
			sql += ",sex=" + userBean.getSex();
		}
		if(userBean.getStatus() != 0){
			sql += ",status=" + userBean.getStatus();
		}
		if(userBean.getBirthDay() != null && userBean.getBirthDay().length() > 0){
			sql += ",birthDay=" + userBean.getBirthDay();
		}
		
		sql += " where id=" + userBean.getId();
		int count = runner.update(sql);
		return count == 1;
	}

	public UserBean getById(int userId) throws SQLException {
		QueryRunner runner = new QueryRunner(DataSourceUtil.getDataSource());
		String sql = "select * from user where id=?";
		UserBean userBean = null;
		userBean = runner.query(sql, new BeanHandler<UserBean>(UserBean.class),userId);
		return userBean;

	}

	public List<UserBean> getAll() throws SQLException {
		QueryRunner runner = new QueryRunner(DataSourceUtil.getDataSource());
		String sql = "select * from user order by createDate desc";
		List<UserBean> list = runner.query(sql, new BeanListHandler<UserBean>(UserBean.class));
		return list;
	}
	
	public List<UserBean> getAll(int type) throws SQLException {
		QueryRunner runner = new QueryRunner(DataSourceUtil.getDataSource());
		String sql = "select * from user where type=? order by createDate desc";
		List<UserBean> list = runner.query(sql, new BeanListHandler<UserBean>(UserBean.class),type);
		return list;
	}

	public List<UserBean> getAllByPage(int type,int status,int start,int size) throws SQLException {
		QueryRunner runner = new QueryRunner(DataSourceUtil.getDataSource());
		String sql = "select * from user where 1=1";
		if(type != 0){
			sql += " and type=" + type;
		}
		if(status != 0){
			sql += " and status=" + status;
		}
		sql += " order by createDate desc";
		sql += " limit " + start + "," + size;
		List<UserBean> list = runner.query(sql, new BeanListHandler<UserBean>(UserBean.class));
		return list;
		
	}
	
	public int getCount(int type,int status) throws SQLException {
		QueryRunner runner = new QueryRunner(DataSourceUtil.getDataSource());
		String sql = "select count(*) from user where 1=1";
		if(type != 0){
			sql += " and type=" + type;
		}
		if(status != 0){
			sql += " and status=" + status;
		}
		int count = ((Long)runner.query(sql, new ScalarHandler<Long>())).intValue();
		return count;
		
	}

	public boolean delete(int id) throws SQLException {
		QueryRunner runner = new QueryRunner(DataSourceUtil.getDataSource());
		String sql = "delete from user where id=?";
		int count = runner.update(sql, id);
		return count == 1;
	}

}
