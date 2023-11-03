package com.java.dao;

import java.sql.ResultSet;
import com.java.bean.*;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Base64;
import java.util.List;
import java.util.Optional;
import java.util.Queue;

import org.springframework.dao.DataAccessException;
import org.springframework.dao.EmptyResultDataAccessException;
import org.springframework.jdbc.core.BeanPropertyRowMapper;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;
import java.sql.Blob;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;

import org.springframework.dao.DataAccessException;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.web.multipart.MultipartFile;

public class BookDao {
	static JdbcTemplate template;

	public void setTemplate(JdbcTemplate template) {
		this.template = template;
	}

	public void save(Book book) throws DataAccessException, IOException {

		String name = book.getName();
		int price = book.getPrice();
		int category_id = book.getCategory_id();
		byte[] photoBytes = book.getImage().getBytes();

		String sql = "INSERT INTO BOOK(name,image,price,category_id) VALUES (?,?,?,?)";

		template.update(sql, new Object[] { name,  photoBytes,price, category_id });

	}

	public List<Book> getBooks() 
	{
		String sql="select b.id, b.name, b.price, b.category_id,c.name from book b,category c where b.category_id=c.id";
		
		List<Book>booklist= template.query(sql, new RowMapper<Book>() {

			@Override
			public Book mapRow(ResultSet rs, int arg1) throws SQLException {
				Book book = new Book();
				book.setId(rs.getInt(1));
				book.setName(rs.getString(2));
				book.setPrice(rs.getInt(3));
                book.setCategory_id(rs.getInt(4));
                book.setCategoryname(rs.getString(5));  
               
				return book;
			}
			
			});
		return booklist;
		
		}

	public Blob findImageById(int id) {
		return template.queryForObject("select image from book where id=" + id, Blob.class);
	}

	public String getNameById(int id) {
		String query = "select name from book where id=" + id;
		return template.queryForObject(query, String.class);
	}

	public void update(Book book) throws IOException {
		int book_id = book.getId();
		String name = book.getName();
		int price = book.getPrice();
		int category_id = book.getCategory_id();
		byte[] photoBytes = book.getImage().getBytes();
		String sql = "update  book set name=?,image=?,price=?,category_id=? where id=?";
		template.update(sql, new Object[] { name, photoBytes,price, category_id, book_id});
	}

	public int deletebook(int id){
		String sql="delete from book where id="+id+"";
		return template.update(sql);
		}

	
	public Book getBookById(int id) {
		String sql = "select id, name, price, category_id from book where id=" + id;
		
		return template.queryForObject(sql, new RowMapper<Book>() {

			@Override
			public Book mapRow(ResultSet rs, int arg1) throws SQLException {
				Book book = new Book();
				book.setId(rs.getInt(1));
				book.setName(rs.getString(2));
				book.setPrice(rs.getInt(3));
                book.setCategory_id(rs.getInt(4));
               
				return book;
			}
			
		});
	}
	
	public List<Book> getBookbyName(Book book){
		//String sql = "SELECT b.id, b.name, b.price, b.category_id, c.name FROM book b, category c WHERE b.name LIKE '%" + book.getSearchname() + "%' AND b.price <= " + book.getSearchprice() + " AND b.category_id = c.id";
		String sql="select b.id, b.name, b.price, b.category_id,c.name from book b,category c where b.name like '%"+book.getSearchname()+"%' and b.category_id=c.id";
		//String sql="select * from book where name like %N5 TextBook%";
		return template.query(sql, new RowMapper<Book>() {

			public Book mapRow(ResultSet rs, int arg1) throws SQLException {
				Book b = new Book();
				b.setId(rs.getInt(1));
				b.setName(rs.getString(2));
				b.setPrice(rs.getInt(3));
                b.setCategory_id(rs.getInt(4));
                b.setCategoryname(rs.getString(5));  
				return b;
			
	}});

	}
	

	
	public  List<Book> getCountBooks(){
		return template.query("select count(*)from book", new RowMapper<Book>() {
			public Book mapRow(ResultSet rs,int row)throws SQLException{
				Book b=new Book();
				b.setId(rs.getInt(1));
				return b;
			}
		});
	}
	
	
	public List<Book> getcategoryById(int id) {
		String sql="select b.id, b.name, b.price, b.category_id,c.name from book b,category c where b.category_id=c.id and category_id="+id;
		List<Book>categorybooklist=template.query(sql, new RowMapper<Book>() {

			@Override
			public Book mapRow(ResultSet rs, int arg1) throws SQLException {
				Book b = new Book();
				b.setId(rs.getInt(1));
				b.setName(rs.getString(2));
				b.setPrice(rs.getInt(3));
                b.setCategory_id(rs.getInt(4));
                b.setCategoryname(rs.getString(5));  
				return b;
			}
			
		});
		return categorybooklist;
	}

	public List<Book> getBookByPage(int pageid, int total) {
		String sql="select b.id, b.name, b.price, b.category_id,c.name from book b,category c where b.category_id=c.id  limit "+(pageid-1)+","+total;
		return template.query(sql,new RowMapper<Book>(){
		public Book mapRow(ResultSet rs, int row) throws SQLException {
			Book b = new Book();
			b.setId(rs.getInt(1));
			b.setName(rs.getString(2));
			b.setPrice(rs.getInt(3));
            b.setCategory_id(rs.getInt(4));
            b.setCategoryname(rs.getString(5));  
			return b;
		}
		});
	}

	public int confirmBookForDelete(int id) {
		String sql="select count(*) from orderdetail where book_id='"+id+"'";
		int count=template.queryForObject(sql, Integer.class);
		return count;
	}
	
	
	
}
