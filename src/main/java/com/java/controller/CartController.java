package com.java.controller;

import java.io.IOException;
import java.security.NoSuchAlgorithmException;
import java.sql.Date;
import java.sql.SQLException;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.java.bean.Admin;
import com.java.bean.Book;
import com.java.bean.Category;
import com.java.bean.Item;
import com.java.bean.Orders;
import com.java.bean.OrderDetail;
import com.java.bean.User;
import com.java.dao.BookDao;
import com.java.dao.CategoriesDao;
import com.java.dao.OrderDao;
import com.java.dao.OrderDetailDao;



@Controller

public class CartController {
	@Autowired
	BookDao bookdao;
	
	@Autowired
	OrderDao orderdao;
	
	@Autowired
	OrderDetailDao orderdetaildao;
	
	@Autowired
	CategoriesDao categoriesdao;
	

	//Book View before login
	@RequestMapping("book")
		public String displaybook(Model m,HttpSession session) {
		List<Book> booklist = bookdao.getBooks();
		m.addAttribute("searchname",new Book());
		List<Category>catalist=categoriesdao.getcatagories();
		m.addAttribute("catalist",catalist);
		m.addAttribute("booklist", booklist);
		
		User user=(User)session.getAttribute("useSession");
		session.setAttribute("userSession", user);
			return "user/bookview";
		}
	
	//Book View after login
		@RequestMapping("bookviewnew")
			public String displaybooknew(Model m,HttpSession session) {
			List<Book> booklist = bookdao.getBooks();
			m.addAttribute("searchname",new Book());
			List<Category>catalist=categoriesdao.getcatagories();
			m.addAttribute("catalist",catalist);
			m.addAttribute("booklist", booklist);
			
			User user=(User)session.getAttribute("useSession");
			session.setAttribute("userSession", user);
				return "user/bookviewnew";
			}
	
	@RequestMapping("cartview")
	public String displayviewcart(Model m,HttpSession session) {
			User u=(User) session.getAttribute("auth_user");
			if(u==null) {
				m.addAttribute("errormsg",true);
				List<Book> booklist = bookdao.getBooks();
				m.addAttribute("searchname",new Book());
				m.addAttribute("booklist", booklist);
				List<Category>catalist=categoriesdao.getcatagories();
				m.addAttribute("catalist",catalist);
				return "user/bookview";
				
			}else {
				m.addAttribute("cart");
				List<Category>catalist=categoriesdao.getcatagories();
				m.addAttribute("catalist",catalist);
				return "user/cartview";
			}
		
	}
	
	@RequestMapping(value = "cart/buy/{id}", method = RequestMethod.GET)
	public String buy(@PathVariable("id") int id, HttpSession session) {
		
		Book book = bookdao.getBookById(id);
		
		
		if (session.getAttribute("cart") == null) {
			List<Item> cart = new ArrayList<Item>();
			cart.add(new Item(book, 1));
			session.setAttribute("cart", cart);
		} else {
			@SuppressWarnings("unchecked")
			List<Item> cart = (List<Item>) session.getAttribute("cart");
			
			boolean exist = false;
			for(Item item : cart) {
				if(item.getBook().getId() == id) {
					exist = true;
					item.setQuantity(item.getQuantity() + 1);
				}				
			}
			if(!exist) {
				cart.add(new Item(book, 1));
			}
			session.setAttribute("cart", cart);
		}
		return "redirect:/cartview";
	}

	@RequestMapping(value = "cart/remove/{id}", method = RequestMethod.GET)
	public String remove(@PathVariable("id") int id, HttpSession session) {
		
		@SuppressWarnings("unchecked")
		List<Item> cart = (List<Item>) session.getAttribute("cart");

		Item removeItem = new Item();
		for(Item item : cart) {
			if(item.getBook().getId() == id) {
				removeItem = item;
			}
		}
		cart.remove(removeItem);
		session.setAttribute("cart", cart);
		return "redirect:/cartview";
		
	}
	@RequestMapping(value="cart/order",method = RequestMethod.GET)
	public String order(HttpSession session) {
		
		session.invalidate();
		return "redirect:/cartview";
		
	}

	@RequestMapping("/orderslist")
	public String orderslist(Model m,HttpSession httpSession){
	List<Orders> orders=orderdao.getOrderlist();
	m.addAttribute("list",orders);
	
	Admin admin=(Admin)httpSession.getAttribute("adminSession");
	httpSession.setAttribute("adminSession",admin);
	
	return "admin/orderslist";
	}
	
	/*@RequestMapping(value="/deleteorder/{id}",method = RequestMethod.GET)
	public String deleteorder(@PathVariable int id){
	orderdao.deleteorder(id);
	return "redirect:/orderslist";
	}*/
	
	@RequestMapping(value="/deleteorder/{id}",method = RequestMethod.GET)
	public String delete(@PathVariable int id,Model m,RedirectAttributes reAtt){
		int i=orderdao.confirmOrderForDelete(id);
		if(i>0) {
			String message="Can't delete this book!";
			reAtt.addFlashAttribute("resultFlag",0);
			return "redirect:/orderslist";
		}
		else {
			orderdao.deleteorder(id);
			String message="Successfully delete book";
			reAtt.addFlashAttribute("resultFlag",1);
			
			System.out.println("Delete");
			return "redirect:/orderslist";
		}
	}
	
	@RequestMapping("/orderdetaillist")
	public String orderdetaillist(Model m,HttpSession httpSession){
	List<OrderDetail>orderdetaillist=orderdetaildao.getOrderDetails();
	m.addAttribute("list",orderdetaillist);
	
	Admin admin=(Admin)httpSession.getAttribute("adminSession");
	httpSession.setAttribute("adminSession",admin);
	
	return "admin/orderdetaillist";
	}
	
	@RequestMapping(value="/deleteorderdetail/{id}",method=RequestMethod.GET)
	public String deleteorderdetail(@PathVariable int id) {
		orderdetaildao.getdeleteorderdetail(id);
		System.out.println("Delete");
		return "redirect:/orderdetaillist";
	}

	@RequestMapping(value="/saveorder",method=RequestMethod.POST)
	public String saveOrder(HttpSession session,@ModelAttribute("order")Orders orders,Model m)throws NoSuchAlgorithmException, IOException, SQLException  {
		@SuppressWarnings("unchecked")
		List<Item> cart=(List<Item>) session.getAttribute("cart");
		User user= (User) session.getAttribute("auth_user");
		int user_id=user.getId();
		LocalDate localdate=LocalDate.now();
		Orders o=new Orders();
		o.setUser_id(user_id);
		o.setDate(String.valueOf(localdate));
		
		orderdao.saveOrder(o);
		
		for(Item item:cart) {
		
			int order_id=orderdetaildao.getLatestId();
			OrderDetail orderdetail=new OrderDetail();
			orderdetail.setBook_id(item.getBook().getId());
			orderdetail.setOrder_id(order_id);
			orderdetail.setQuantity(item.getQuantity());
			orderdetaildao.saveOrderDetail(orderdetail);
		}
		
		
		m.addAttribute("user",user);
	
		m.addAttribute("cart",cart);
		session.invalidate();
		return "user/checkout";

}
	
	
	
	@RequestMapping("/order")
	public String order(Model m,HttpSession httpSession){
	List<Orders> olist=orderdao.getOrders();
	m.addAttribute("olist",olist);
	
	Admin admin=(Admin)httpSession.getAttribute("adminSession");
	httpSession.setAttribute("adminSession",admin);
	
	return "admin/order";
	}
	
	@RequestMapping("/ordersbydatelist")
	public String orderbydate(Model m,HttpSession session) {
		List<Orders> obydatelist=orderdao.getorderbydate();
		m.addAttribute("obydatelist",obydatelist);
		
		Admin admin=(Admin)session.getAttribute("adminSession");
		session.setAttribute("adminSession", admin);
		
		return "admin/ordersbydate";
	}
	
	
	

}
