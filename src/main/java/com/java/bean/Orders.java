package com.java.bean;

import java.sql.Date;
import java.time.LocalDate;

public class Orders {
	private int id;
	private String date;
	private int user_id;
	private int book_id;
	private int quantity;
	private String user_name;
	private String book_name;
	private int price;
	
	
	
	public int getPrice() {
		return price;
	}
	public void setPrice(int price) {
		this.price = price;
	}
	public String getBook_name() {
		return book_name;
	}
	public void setBook_name(String book_name) {
		this.book_name = book_name;
	}
	public String getUser_name() {
		return user_name;
	}
	public void setUser_name(String user_name) {
		this.user_name = user_name;
	}
	public int getBook_id() {
		return book_id;
	}
	public void setBook_id(int book_id) {
		this.book_id = book_id;
	}
	public int getQuantity() {
		return quantity;
	}
	public void setQuantity(int quantity) {
		this.quantity = quantity;
	}
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	

	public int getUser_id() {
		return user_id;
	}
	public String getDate() {
		return date;
	}
	public void setDate(String date) {
		this.date = date;
	}
	public void setUser_id(int user_id) {
		this.user_id = user_id;
	}
	
	public  Orders(int id,String date,int user_id,int book_id,int quantity,int price) {
		this.id=id;
		this.date=date;
		this.user_id=user_id;
		this.book_id=book_id;
		this.quantity=quantity;
		this.price=price;
	}
	public Orders() {
		
	}
	
	
	
	
}
