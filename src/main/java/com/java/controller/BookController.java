package com.java.controller;

import java.io.ByteArrayInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.sql.Blob;
import java.sql.SQLException;
import java.util.List;

import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.io.IOUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataAccessException;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import org.springframework.web.servlet.view.RedirectView;

import com.java.bean.Admin;
import com.java.bean.Book;
import com.java.bean.Category;
import com.java.bean.Category;
import com.java.bean.User;
import com.java.dao.BookDao;
import com.java.dao.CategoriesDao;
import com.java.dao.UserDao;

@Controller
public class BookController {
	private static final String price = null;

	@Autowired
	BookDao bookdao;

	@Autowired
	CategoriesDao categoriesdao;

	@RequestMapping("addbook")
	public String showaddbook(Model m,HttpSession httpSession) {
		m.addAttribute("book", new Book());
		List<Category> catagoriesList = categoriesdao.getcatagories();
		m.addAttribute("catagoriesList", catagoriesList);
		
		Admin admin=(Admin)httpSession.getAttribute("adminSession");
		httpSession.setAttribute("adminSession",admin);
		
		return "admin/addbook";
	}

	@RequestMapping(value = "/save", method = RequestMethod.POST)
	public String savebook(@ModelAttribute("book") Book book, Model model) throws DataAccessException, IOException {

		bookdao.save(book);
		model.addAttribute("booklist", bookdao.getBooks());
		return "redirect:/viewbook";
	}

	@RequestMapping("/showImage/{id}")
	public void showImage(@PathVariable("id") int id, Model model, HttpServletResponse response)
			throws SQLException, IOException {
		Blob ph = bookdao.findImageById(id);

		response.setContentType("image/jpeg");
		byte[] bytes = ph.getBytes(1, (int) ph.length());
		InputStream inputStream = new ByteArrayInputStream(bytes);
		IOUtils.copy(inputStream, response.getOutputStream());

	}

	@RequestMapping("viewbook")
	public String viewbook(Model m,HttpSession httpSession) {
		List<Book> booklist = bookdao.getBooks();
		m.addAttribute("booklist", booklist);
		
		Admin admin=(Admin)httpSession.getAttribute("adminSession");
		httpSession.setAttribute("adminSession",admin);
		
		return "admin/viewbook";
	}

	@RequestMapping(value = "/editbook/{id}")
	public String edit(@PathVariable int id, Model m) {
		Book book = bookdao.getBookById(id);
		m.addAttribute("booktoedit", book);
		m.addAttribute("bookedit", new Book());
		List<Category> catagoriesList = categoriesdao.getcatagories();
		m.addAttribute("catagoriesList", catagoriesList);
		return "admin/bookeditform";
	}

	@RequestMapping(value = "/editsave", method = RequestMethod.POST)
	public String editsave(@ModelAttribute("bookedit") Book book) throws DataAccessException, IOException {

		bookdao.update(book);

		return "redirect:/viewbook";
	}

	
	
	@RequestMapping(value="/deletebook/{id}",method = RequestMethod.GET)
	public String delete(@PathVariable int id,Model m,RedirectAttributes reAtt){
		int i=bookdao.confirmBookForDelete(id);
		if(i>0) {
			String message="Can't delete this order!";
			reAtt.addFlashAttribute("resultFlag",0);
			return "redirect:/viewbook";
		}
		else {
			bookdao.deletebook(id);
			String message="Successfully delete user information";
			reAtt.addFlashAttribute("resultFlag",1);
			
			System.out.println("Delete");
			return "redirect:/viewbook";
		}
	}
	

	/*Search book by book title 
	@RequestMapping(value="/search",method=RequestMethod.POST)
	public String searchbook(@ModelAttribute("searchname")Book book,Model m,HttpSession httpSession) {
		List<Book>blist= bookdao.getBookbyName(book);
		m.addAttribute("booklist",blist);
		List<Category>catalist=categoriesdao.getcatagories();
		m.addAttribute("catalist",catalist);
		List<Category> catagoriesList = categoriesdao.getcatagories();
		m.addAttribute("catagoriesList", catagoriesList);
		
		Admin admin=(Admin)httpSession.getAttribute("adminSession");
		httpSession.setAttribute("adminSession",admin);
		
		return "user/searchbook";
		
	}*/
	
	//Search book by category before login
	@RequestMapping(value="/searchbook/{id}")
	public String searchbookbycategory(@PathVariable int id,Model m,HttpSession httpSession) {
		List<Book> book=bookdao.getcategoryById(id);
		m.addAttribute("searchname",new Book());
		List<Category>catalist=categoriesdao.getcatagories();
		m.addAttribute("catalist",catalist);
		List<Category> catagoriesList = categoriesdao.getcatagories();
		m.addAttribute("catagoriesList", catagoriesList);
		m.addAttribute("booklist", book);
		
		Admin admin=(Admin)httpSession.getAttribute("adminSession");
		httpSession.setAttribute("adminSession",admin);
		
	return "user/categorybybook";
	
}
	
	//Search book by category after login
	@RequestMapping(value="/searchbooknew/{id}")
	public String searchbookbycategorynew(@PathVariable int id,Model m,HttpSession httpSession) {
		List<Book> book=bookdao.getcategoryById(id);
		m.addAttribute("searchname",new Book());
		List<Category>catalist=categoriesdao.getcatagories();
		m.addAttribute("catalist",catalist);
		List<Category> catagoriesList = categoriesdao.getcatagories();
		m.addAttribute("catagoriesList", catagoriesList);
		m.addAttribute("booklist", book);
		
		Admin admin=(Admin)httpSession.getAttribute("adminSession");
		httpSession.setAttribute("adminSession",admin);
		
	return "user/categorybybooknew";
	
}
	
	
	
	
}
