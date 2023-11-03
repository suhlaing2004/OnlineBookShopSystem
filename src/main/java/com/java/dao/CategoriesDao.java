package com.java.dao;

import java.io.IOException;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;

import org.springframework.jdbc.core.BeanPropertyRowMapper;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;

import com.java.bean.Book;
import com.java.bean.Category;
import com.java.bean.User;



public class CategoriesDao {
	static JdbcTemplate template;
	public void setTemplate(JdbcTemplate template) {
	this.template = template;
	}
	
	public int save(Category category){
		String sql="insert into category(name)values('"+category.getName()+"')";
		return template.update(sql);
	}
	
	public List<Category> getcatagories(){
		String sql="select id , name from category";
		List <Category> catagorieslist= template.query(sql,new RowMapper<Category>(){
		public Category mapRow(ResultSet rs, int row) throws SQLException {
			Category c=new Category();
			c.setId(rs.getInt(1));
			c.setName(rs.getString(2));
			
			return c;
			}
			});
			return catagorieslist;
			}
	
	public int deletecategory(int id) {
		String sql = "delete from category where id=" + id + "";
		return template.update(sql);
		
	}
	
	public int update(Category c) {
		String sql="update category set name='"+c.getName()+"' where id="+c.getId()+"";
		return template.update(sql);
	}
	
	@SuppressWarnings("deprecation")
	public Category getCatagoryById(int id){
	String sql="select * from Category where id=?";
	return template.queryForObject(sql, new Object[]{id},new BeanPropertyRowMapper<Category>(Category.class));
	}
	
	public  List<Category> getCountCatagories(){
		return template.query("select count(*)from category", new RowMapper<Category>() {
			public Category mapRow(ResultSet rs,int row)throws SQLException{
				Category categories=new Category();
				categories.setId(rs.getInt(1));
				return categories;
			}
		});
	}

	public int confirmCategoryForDelete(int id) {
		String sql="select count(*) from book where category_id='"+id+"'";
		int count=template.queryForObject(sql, Integer.class);
		return count;
	}
}
