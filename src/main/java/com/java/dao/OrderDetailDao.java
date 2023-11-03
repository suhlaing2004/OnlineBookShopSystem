package com.java.dao;


import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.List;

import org.springframework.jdbc.core.BeanPropertyRowMapper;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;

import com.java.bean.Book;
import com.java.bean.OrderDetail;
import com.java.bean.Orders;


public class OrderDetailDao {
	private static final int id = 0;
	static JdbcTemplate template;

	public void setTemplate(JdbcTemplate template) {
		this.template = template;
	}
	
	public void saveOrderDetail(OrderDetail od)
	{
		String sql="insert into orderdetail (book_id,order_id,quantity) values ("+od.getBook_id()+","+od.getOrder_id()+","+od.getQuantity()+")";
		template.update(sql);
		
	}
	
	public List<OrderDetail> getOrderDetails(){
		String sql="select * from orderdetail";
		List<OrderDetail>orderdetaillist=template.query(sql, new RowMapper<OrderDetail>() {
		@Override
		public OrderDetail mapRow(ResultSet rs, int arg1) throws SQLException {
			OrderDetail d=new OrderDetail();
			d.setId(rs.getInt(1));
			d.setBook_id(rs.getInt(2));
			d.setOrder_id(rs.getInt(3));
			d.setQuantity(rs.getInt(4));
			return d;
		}
		});
		return orderdetaillist;
	}

	public int getLatestId() {
		String query="select id from orders order by id desc limit 1";
		return template.queryForObject(query, Integer.class);
	}
	
	public int getdeleteorderdetail(int id) {
	    String sql = "DELETE FROM orderdetail WHERE id = ?";
	    return template.update(sql, id);
	}


	

}
