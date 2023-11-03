package com.java.dao;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;

import org.springframework.dao.EmptyResultDataAccessException;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;

import com.java.bean.Admin;
import com.java.bean.Book;

public class AdminDao {
	static JdbcTemplate template;
	public void setTemplate(JdbcTemplate template) {
	this.template = template;
	}
	
	
	
	public int getAuthenicateAdmin(String username, String password) {
		try {
			String sql="select count(*) from admin where username='"+username+"' and password='"+password+"'";
			int count=template.queryForObject(sql,Integer.class);
			return count;
		}catch(EmptyResultDataAccessException e) {
			return 0;
		}
		
	}
	
	public Admin getAdmin(String username,String password) {
		String sql = "select * from admin where username='"+ username+"' and password='"+password+"'";
		
		return template.queryForObject(sql, new RowMapper<Admin>() {

			@Override
			public Admin mapRow(ResultSet rs, int arg1) throws SQLException {
				Admin admin = new Admin();
				admin.setId(rs.getInt(1));
				admin.setUsername(rs.getString(2));
				admin.setPassword(rs.getString(3));
               
				return admin;
			}
			
		});
	}

	

}
