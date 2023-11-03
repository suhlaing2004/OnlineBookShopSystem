package com.java.dao;

import java.io.IOException;
import java.sql.Date;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.time.LocalDate;
import java.util.List;

import org.springframework.dao.DataAccessException;
import org.springframework.jdbc.core.JdbcTemplate;

import org.springframework.jdbc.core.RowMapper;

import com.java.bean.Book;
import com.java.bean.OrderDetail;
import com.java.bean.Orders;
import com.java.bean.User;

public class OrderDao {
	static JdbcTemplate template;

	public void setTemplate(JdbcTemplate template) {
		this.template = template;
	}
	

	public void saveOrder(Orders o) {
		String sql="insert into orders (date,user_id) values ('"+o.getDate()+"',"+o.getUser_id()+")";
		template.update(sql);
		
	}
	
	public List<Orders> getOrders(){
		String sql="select o.id,u.username,o.date,b.name,od.quantity from orders o,user u,orderdetail od,book b where o.id=od.order_id and o.user_id=u.id and b.id=od.book_id";
		List<Orders>olist=template.query(sql, new RowMapper<Orders>() {
		@Override
		public Orders mapRow(ResultSet rs, int arg1) throws SQLException {
			Orders o=new Orders();
			o.setId(rs.getInt(1));
			o.setUser_name(rs.getString(2));
			o.setDate(rs.getString(3));
			o.setBook_name(rs.getString(4));
			o.setQuantity(rs.getInt(5));
			
			return o;
		}
		});
		return olist;
	}
	
	public List<Orders> getOrderlist(){
		String sql="select * from orders";
		List<Orders>orders=template.query(sql, new RowMapper<Orders>() {
		@Override
		public Orders mapRow(ResultSet rs, int arg1) throws SQLException {
			Orders o=new Orders();
			o.setId(rs.getInt(1));
			
			o.setDate(rs.getString(2));
			o.setUser_id(rs.getInt(3));
			
			return o;
		}
		});
		return orders;
	}
	
	
	public int deleteorder(int id){
		String sql="delete from orders where id="+id+"";
		return template.update(sql);
		}
	
	public List<Orders> getCountOrders(){
		return template.query("select count(*) from orders",new RowMapper<Orders>() {
			public Orders mapRow(ResultSet rs,int row) throws SQLException{
				Orders o=new Orders();
				o.setId(rs.getInt(1));
				return o;
			}
		});
	}
	
	public List<Orders> getorderbydate(){
		String sql="select u.username,b.name,b.price,od.quantity,o.date from user u join orders o on u.id=o.user_id join orderdetail od on o.id=od.order_id join book b on b.id=od.book_id where o.date=curdate()";
		List<Orders>obydatelist=template.query(sql, new RowMapper<Orders>() {
			@Override
			public Orders mapRow(ResultSet rs, int arg1) throws SQLException {
				Orders o=new Orders();
				 o.setUser_name(rs.getString(1));
				 o.setBook_name(rs.getString(2));
				 o.setPrice(rs.getInt(3));
				 o.setQuantity(rs.getInt(4));
				 o.setDate(rs.getString(5));
				return o;
			}
			});
			return obydatelist;
		}


	public int confirmOrderForDelete(int id) {
		String sql="select count(*) from orderdetail where order_id='"+id+"'";
		int count=template.queryForObject(sql, Integer.class);
		return count;
	}
	}


	

