package com.java.controller;

import java.io.IOException;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataAccessException;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.java.bean.Admin;
import com.java.bean.Book;
import com.java.bean.Category;

import com.java.dao.CategoriesDao;

@Controller
public class CategoriesController {
	@Autowired
	CategoriesDao categoriesdao;

	//	Requst addcategory page from admin and return addcatagory
	
	@RequestMapping("/addcatagory")
	public String displayaddcatagory(Model m,HttpSession httpSession) {
		m.addAttribute("catagory",new Category());
		
		Admin admin=(Admin)httpSession.getAttribute("adminSession");
		httpSession.setAttribute("adminSession",admin);
		
		return "admin/addcatagory";
	}

	//Request viewcategory page from admin and return viewcatagory
	
	@RequestMapping("/viewcatagory")
	public String displaycatagoriespage(Model m,HttpSession httpSession) {
		List <Category> catagorieslist=categoriesdao.getcatagories();
		m.addAttribute("catagorieslist",catagorieslist);
		
		Admin admin=(Admin)httpSession.getAttribute("adminSession");
		httpSession.setAttribute("adminSession",admin);
		
		return "admin/viewcatagory";
	}

	//Save category to database and return viewcatagory
	
	@RequestMapping(value = "/savecatagory", method = RequestMethod.POST)
	public String savebook(@ModelAttribute("catagory") Category category, Model model) throws DataAccessException, IOException {

		categoriesdao.save(category);
		model.addAttribute("catagorieslist", categoriesdao.getcatagories());
		return "redirect:/viewcatagory";
	}

	//Delete category with id and return viewcatagory
	
	@RequestMapping(value = "/deletecatagory/{id}", method = RequestMethod.GET)
	public String deletecatagory(@PathVariable int id,RedirectAttributes reAtt) {
		int i=categoriesdao.confirmCategoryForDelete(id);
		if(i>0) {
			String message="Can't delete this category!";
			reAtt.addFlashAttribute("resultFlag",0);
			return "redirect:/viewcatagory";
		}
		else {
			categoriesdao.deletecategory(id);
			String message="Successfully delete category";
			reAtt.addFlashAttribute("resultFlag",1);
			
			System.out.println("Delete");
			return "redirect:/viewcatagory";
		}
	}

	//Edit category form admin and return catagoryeditform
	
	@RequestMapping(value = "/editcatagory/{id}")
	public String edit(@PathVariable int id, Model m,HttpSession httpSession) {
		Category category = categoriesdao.getCatagoryById(id);
		m.addAttribute("categorytoedit", category);
		m.addAttribute("categoryedit", new Category());
		
		Admin admin=(Admin)httpSession.getAttribute("adminSession");
		httpSession.setAttribute("adminSession",admin);
		
		return "admin/catagoryeditform";
	}

	//Editcategory save from admin and return viewcatagory
	
	@RequestMapping(value = "/editcategorysave", method = RequestMethod.POST)
	public String editsave(@ModelAttribute("categoryedit") Category category) throws DataAccessException, IOException {

		categoriesdao.update(category);

		return "redirect:/viewcatagory";
	}
	
	
	
}
