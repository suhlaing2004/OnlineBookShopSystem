package com.java.bean;


import javax.validation.constraints.NotBlank;
import javax.validation.constraints.Pattern;

public class Admin {
	private int id;
	@NotBlank(message = "Username is required")
	private String Username;
	@Pattern(regexp = "^[a-zA-Z0-9]{6,10}$")
	private String password;
	
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id=id;
	}
	
	
	
	public String getUsername() {
		return this.Username;
	}
	public void setUsername(String username) {
		Username = username;
	}
	public String getPassword() {
		return this.password;
	}
	public void setPassword(String password) {
		this.password=password;
	}

}
