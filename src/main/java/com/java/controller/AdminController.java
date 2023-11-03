package com.java.controller;

import java.util.List;

import javax.servlet.http.HttpSession;
import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.EmptyResultDataAccessException;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.java.bean.*;
import com.java.dao.*;

@Controller
public class AdminController {
@Autowired
AdminDao admindao;

@Autowired
BookDao bookdao;

@Autowired
OrderDao orderdao;

@Autowired
UserDao userdao;

@Autowired
CategoriesDao categoriesDao;
	
@RequestMapping("/")
public String index(Model m) {
	List<Category>catalist=categoriesDao.getcatagories();
	m.addAttribute("catalist",catalist);
	return "index";
}
@RequestMapping("/adminlogin")
public String displayloginpage(Model m) {
	m.addAttribute("admin",new Admin());
	return "admin/login";
}
@RequestMapping("/signOut")
public String signOut(Model m,HttpSession session) {
	
		if(session !=null && session.getAttribute("adminSession") != null) {
			session.invalidate();
		}
	m.addAttribute("admin",new Admin());
	
	return "admin/login";
	
}

@RequestMapping("/validateadminlogin")
public String adminlogin(@ModelAttribute ("admin")Admin admin,Model model,HttpSession httpSession) {
		int a=admindao.getAuthenicateAdmin(admin.getUsername(),admin.getPassword());
		if(a<=0) {
			model.addAttribute("wrong_login",true);
			return "admin/login";
		}
		else {
		Admin adminObject=admindao.getAdmin(admin.getUsername(),admin.getPassword());
		httpSession.setAttribute("adminSession",adminObject);
		
		List<Book> countbook=bookdao.getCountBooks();
		model.addAttribute("countbook",countbook);
		model.addAttribute("Book", new Book());
		httpSession.setAttribute("countbook", countbook);
		
		
		List<Category> countcatagories=categoriesDao.getCountCatagories();
		model.addAttribute("countcatagories",countcatagories);
		model.addAttribute("Catagories",new Category());
		httpSession.setAttribute("countcatagories", countcatagories);
		
		List<Orders> countorders=orderdao.getCountOrders();
		model.addAttribute("countorders",countorders);
		model.addAttribute("Orders",new Orders());
		httpSession.setAttribute("countorders", countorders);
		
		List<User> countusers=userdao.getCountUsers();
		model.addAttribute("countusers",countusers);
		model.addAttribute("User",new User());
		httpSession.setAttribute("countusers", countusers);
		
		
		return "admin/dashboard";
	}
}


@RequestMapping("/dashboard")
public String displaydashboard(Model m,HttpSession httpSession) {
	List<Book> countbook=bookdao.getCountBooks();
	m.addAttribute("countbook",countbook);
	m.addAttribute("Book", new Book());
	
	
	List<Category> countcatagories=categoriesDao.getCountCatagories();
	m.addAttribute("countcatagories",countcatagories);
	m.addAttribute("Catagories",new Category());
	
	List<Orders> countorders=orderdao.getCountOrders();
	m.addAttribute("countorders",countorders);
	m.addAttribute("Orders",new Orders());
	
	List<User> countusers=userdao.getCountUsers();
	m.addAttribute("countusers",countusers);
	m.addAttribute("User",new User());
	
	Admin admin=(Admin)httpSession.getAttribute("adminSession");
	httpSession.setAttribute("adminSession",admin);
	
	return "admin/dashboard";
}

/*@RequestMapping("/userlist")
public String displayuserlistpage(Model m) {
	m.addAttribute("admin",new Admin());
	return "admin/userlist";
}*/

@RequestMapping(value="/registerlist/{pageid}")
public String edit(@PathVariable int pageid,Model m){
int total=5; 
if(pageid==1){}
else{
pageid=(pageid-1)*total+1;
}
List<User> userlist=userdao.getUsersByPage(pageid,total);
m.addAttribute("list", userlist);
return "admin/registerlist";
}



}
