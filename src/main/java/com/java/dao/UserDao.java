package com.java.dao;

import java.io.IOException;
import java.security.NoSuchAlgorithmException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;

import org.springframework.dao.DataAccessException;
import org.springframework.dao.EmptyResultDataAccessException;
import org.springframework.jdbc.core.BeanPropertyRowMapper;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;

import com.java.bean.Admin;
import com.java.bean.Book;
import com.java.bean.Orders;
import com.java.bean.User;
import com.mysql.cj.log.Log;

public class UserDao {
	static JdbcTemplate template;
	public void setTemplate(JdbcTemplate template) {
	this.template = template;
	}
	
	public int getsaveregister(User user){
		String sql="insert into user(username,email,password,phonenumber,address)values('"+user.getUsername()+"','"+user.getEmail()+"','"+user.getPassword()+"','"+user.getPhonenumber()+"','"+user.getAddress()+"')";
		return template.update(sql);
			}

	
		public int deleteUser(int id){
		String sql="delete from user where id="+id+"";
		return template.update(sql);
		}
	
		
	/*public void deleteUser(int id) {
	    try (Connection conn = getConnection()) {
	        // Start a transaction to ensure both operations succeed or fail together
	        conn.setAutoCommit(false);

	        // Delete associated order details
	        try (PreparedStatement pstmtOrderDetail = conn.prepareStatement("DELETE FROM orderdetail WHERE order_id IN (SELECT id FROM orders WHERE user_id = ?)")) {
	            pstmtOrderDetail.setInt(1, id);
	            pstmtOrderDetail.executeUpdate();
	        }

	        // Delete the user
	        try (PreparedStatement pstmtUser = conn.prepareStatement("DELETE FROM user WHERE id = ?")) {
	            pstmtUser.setInt(1, id);
	            pstmtUser.executeUpdate();
	        }

	        // Commit the transaction if all operations are successful
	        conn.commit();
	    } catch (SQLException e) {
	        // Rollback the transaction if there is an exception
	        e.printStackTrace();
	    }
	}*/
	

		
		
		@SuppressWarnings("deprecation")
		public User getUserById(int id){
		String sql="select * from user where id=?";
		return template.queryForObject(sql, new Object[]{id},new BeanPropertyRowMapper<User>(User.class));
		}
		
	
	public List<User> getUsers(){
		List <User> userregilist= template.query("select * from user",new RowMapper<User>(){
		public User mapRow(ResultSet rs, int row) throws SQLException {
			User s=new User();
			s.setId(rs.getInt(1));
			s.setUsername(rs.getString(2));
			s.setEmail(rs.getString(3));
			s.setPassword(rs.getString(4));
			s.setPhonenumber(rs.getString(5));
			s.setAddress(rs.getString(6));
			return s;
			}
			});
			return userregilist;
			}
	

	public int getUserByUsernameandPassword(String username, String password) {
		try {
			String sql="select count(*) from user where username='"+username+"' and password='"+password+"'";
			int count=template.queryForObject(sql,Integer.class);
			return count;
		}catch(EmptyResultDataAccessException e) {
			return 0;
		}
		
	}
	
	public User getUser(User user ) throws NoSuchAlgorithmException, IOException {
		
		
		String sql = "select id,username,email,password,phonenumber,address from user where username='"+user.getUsername()+"' and password='"+user.getPassword()+"' ";
		return template.queryForObject(sql, new RowMapper<User>() {
			public User mapRow(ResultSet rs, int row) throws SQLException {
				User u= new User();
		        u.setId(rs.getInt(1));	  
		        u.setUsername(rs.getString(2));
		        u.setEmail(rs.getString(3));
		        u.setPhonenumber(rs.getString(4));
		        u.setAddress(rs.getString(5));
				return u;
			}
		});
	}
	
	public List<User> getCountUsers(){
		return template.query("select count(*) from user",new RowMapper<User>() {
			public User mapRow(ResultSet rs,int row) throws SQLException{
				User u=new User();
				u.setId(rs.getInt(1));
				return u;
			}
		});
	}

	public List<User> getUsersByPage(int pageid, int total) {
		String sql="select * from user limit "+(pageid-1)+","+total;
		//System.out.println(sql);
		return template.query(sql,new RowMapper<User>(){
		public User mapRow(ResultSet rs, int row) throws SQLException {
		//System.out.println(name);
		User u= new User();
        u.setId(rs.getInt(1));	  
        u.setUsername(rs.getString(2));
        u.setEmail(rs.getString(3));
        u.setPhonenumber(rs.getString(4));
        u.setAddress(rs.getString(5));
		return u;
		}
		});
		}
	
	public int getTotalUsers() {
		String sql="select count(*) from user";
		return template.queryForObject(sql,Integer.class);
	}

	public User getUser(String username, String password) {
String sql = "select * from user where username='"+ username+"' and password='"+password+"'";
		
		return template.queryForObject(sql, new RowMapper<User>() {

			@Override
			public User mapRow(ResultSet rs, int arg1) throws SQLException {
				User user = new User();
				user.setId(rs.getInt(1));
				user.setEmail(rs.getString(3));
				user.setPassword(rs.getString(4));
               
				return user;
			}
			
		});
	}
	
	public int confirmUserForDelete(int id) {
		String sql="select count(*) from orders where user_id='"+id+"'";
		int count=template.queryForObject(sql, Integer.class);
		return count;
	}

	
	
	

	/*private Connection getConnection() throws SQLException {
		    // Replace the following values with your actual database connection details
		    String url = "jdbc:mysql://localhost:3306/onlinebookstoresystem";
		    String username = "root";
		    String password = "";

		    return DriverManager.getConnection(url, username, password);
		}*/

	
	}



