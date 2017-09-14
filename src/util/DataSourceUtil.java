package util;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.sql.DataSource;

import com.mchange.v2.c3p0.ComboPooledDataSource;
import com.mysql.jdbc.Statement;

/**
 * 2017年09月06日11:04:20
 * 数据库连接池工具类
 * @author liuxining
 *
 */
public class DataSourceUtil {
	private static DataSource dataSource = new ComboPooledDataSource();
	
	private static ThreadLocal<Connection> tl = new ThreadLocal<Connection>();
	
	public static DataSource getDataSource(){
		return dataSource;
	}
	public static Connection getConnection() throws SQLException{
		return dataSource.getConnection();
	}
	
	public static Connection getCurrentConnection() throws SQLException{
		Connection conn = tl.get();
		if(conn == null){
			conn = dataSource.getConnection();
			tl.set(conn);
		}
		return conn;
	}
	
	public static void startTransaction() throws SQLException{
		Connection conn = getCurrentConnection();
		if(conn != null){
			conn.setAutoCommit(false);
		}
	}
	
	public static void commitAndRelease() throws SQLException{
		Connection conn = getCurrentConnection();
		if(conn != null){
			conn.commit();
			conn.close();
			tl.remove();
		}
	}
	
	public static void closeStatement(Statement stmt){
		if(stmt != null){
			try {
				stmt.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
	}
	
	public static void rollback() throws SQLException{
		Connection conn = getCurrentConnection();
		if(conn != null){
			conn.rollback();
		}
	}
	
	public static void closeResultSet(ResultSet rs){
		if(rs != null){
			try {
				rs.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
	}
	
	public static void closeStatementAndResultSet(Statement stmt,ResultSet rs){
		closeResultSet(rs);
		closeStatement(stmt);
	}
	
	
	public static void closeConnection() throws SQLException{
		Connection conn = getCurrentConnection();
		if(conn != null){
			conn.close();
		}
	}
	
	
	
	
	
	
	
	
	
	
}
