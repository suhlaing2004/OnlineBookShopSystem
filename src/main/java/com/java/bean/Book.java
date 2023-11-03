package com.java.bean;

import java.sql.Blob;

import org.springframework.web.multipart.MultipartFile;

public class Book {
	private int id;
	private String name;
	private int price;
	private String searchname;
	private int searchprice;
	private MultipartFile image;
	public int getSearchprice() {
		return searchprice;
	}
	public void setSearchprice(int searchprice) {
		this.searchprice = searchprice;
	}
	private int category_id;
	private String categoryname;
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id=id;
	}
	
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name=name;
	}
	
	public int getPrice() {
		return price;
	}
	public void setPrice(int price) {
		this.price=price;
	}
	
	public MultipartFile getImage() {
		return image;
	}
	public void setImage(MultipartFile image) {
		this.image = image;
	}
	
	
	public int getCategory_id() {
		return category_id;
	}
	public void setCategory_id(int category_id) {
		this.category_id = category_id;
	}
	public String getCategoryname() {
		return categoryname;
	}
	public void setCategoryname(String categoryname) {
		this.categoryname = categoryname;
	}
	public Book() {
		
	}
	
	public Book(int id,String name,int price,MultipartFile image,int category_id,String categoryname) {
		this.id=id;
		this.name=name;
		this.price=price;
		this.image=image;
		this.category_id=category_id;
		this.categoryname=categoryname;
	}
	public String getSearchname() {
		return searchname;
	}
	public void setSearchname(String searchname) {
		this.searchname = searchname;
	}
	
}
