package com.java.controller;

import java.io.IOException;
import java.security.NoSuchAlgorithmException;
import java.util.List;

import javax.servlet.http.HttpSession;
import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.java.bean.Admin;
import com.java.bean.Book;
import com.java.bean.Category;
import com.java.bean.User;
import com.java.dao.BookDao;
import com.java.dao.CategoriesDao;
import com.java.dao.UserDao;

@Controller
public class UserController {
@Autowired
UserDao userdao;

@Autowired
BookDao bookdao;

@Autowired
CategoriesDao categoriesdao;

/*---Display Register Page---*/

@RequestMapping("/register")
public String displayregisterpage(Model m) {
	m.addAttribute("user",new User());
	return "user/registration";
}

/*Save Register Data*/

@RequestMapping(value="/register",method = RequestMethod.POST)
public String register(@Valid @ModelAttribute("user") User user,BindingResult result,Model model,HttpSession session){
	userdao.getsaveregister(user);
	if(result.hasErrors()) {
		model.addAttribute("wrong_login",true);
		return "user/registration";
	}else {
		session.setAttribute("auth_user",user);
		return "user/login";
	}
	
}

/*Show Register Data in Admin Page*/

@RequestMapping("/registerlist")
public String registerlist(Model m){
List<User> userregilist=userdao.getUsers();
m.addAttribute("list",userregilist);
return "admin/registerlist";
}

/*Delete User in Admin Page*/

/*@RequestMapping(value="/deleteuser/{id}",method = RequestMethod.GET)
public String delete(@PathVariable int id){
	userdao.deleteUser(id);
return "redirect:/registerlist";
}*/
@RequestMapping(value="/deleteuser/{id}",method = RequestMethod.GET)
public String delete(@PathVariable int id,Model m,RedirectAttributes reAtt){
	int i=userdao.confirmUserForDelete(id);
	if(i>0) {
		String message="Can't delete this user!";
		reAtt.addFlashAttribute("resultFlag",0);
		return "redirect:/registerlist";
	}
	else {
		userdao.deleteUser(id);
		String message="Successfully delete user information";
		reAtt.addFlashAttribute("resultFlag",1);
		
		System.out.println("Delete");
		return "redirect:/registerlist";
	}
}
/*Display Login Form*/

@RequestMapping("login")
public String displayloginpage(Model m,HttpSession session) {
	m.addAttribute("user",new User());
	return "user/login";
}

/*Check Login*/

@RequestMapping("saveuserloginform")
public String userlogin(@ModelAttribute ("user")User user,Model model,HttpSession session) throws  IOException, NoSuchAlgorithmException {
	int u=userdao.getUserByUsernameandPassword(user.getUsername(),user.getPassword());
	
	if(u >0) {
		
		User userObject=userdao.getUser(user.getUsername(),user.getPassword());
		session.setAttribute("userSession", userObject);
		User auth_user=userdao.getUser(user);
		session.setAttribute("auth_user", auth_user);
		//model.addAttribute("errormsg",true);
		List<Book> booklist = bookdao.getBooks();
		model.addAttribute("searchname",new Book());
		List<Category>catalist=categoriesdao.getcatagories();
		model.addAttribute("catalist",catalist);
		model.addAttribute("booklist", booklist);
		return "user/bookviewnew";
		
	}
	else {
		
		model.addAttribute("wrong_login",true);
		return "user/login";
	}
}

/*LogOut form System*/



@RequestMapping("logout")
public String logout(Model m,HttpSession session) {
	
		
	m.addAttribute("user",new User());
	
	return "user/login";
	
}
/* Display System Home Page*/

@RequestMapping("index")
public String displayhomepage(Model m) {

List<Category>catalist=categoriesdao.getcatagories();
m.addAttribute("catalist",catalist);
	return "index";
}
}
