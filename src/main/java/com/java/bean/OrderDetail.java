package com.java.bean;

public class OrderDetail {
	private int id;
	private int book_id;
	private int order_id;
	private int quantity;
	
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public  int getBook_id() {
		return book_id;
	}
	public void setBook_id(int book_id) {
		this.book_id = book_id;
	}
	public int getOrder_id() {
		return order_id;
	}
	public void setOrder_id(int order_id) {
		this.order_id = order_id;
	}
	public int getQuantity() {
		return quantity;
	}
	public void setQuantity(int quantity) {
		this.quantity = quantity;
	}
	
	public OrderDetail() {
		
	}
	
public OrderDetail(int book_id,int order_id,int quantity) {
	this.book_id=book_id;
	this.order_id=order_id;
	this.quantity=quantity;
		
	}
}
