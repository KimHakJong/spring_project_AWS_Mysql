package com.gant.myhome.controller;

import java.security.Principal;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.gant.myhome.domain.Todolist;
import com.gant.myhome.service.BoardService;
import com.gant.myhome.service.ProjectCalendarService;
import com.gant.myhome.service.TodolistService;


@Controller
@RequestMapping(value="/todolist")
//http://localhost:8088/gant/todolist/ 로 시작하는 주소 

public class TodolistController {
   
   private static final Logger logger = LoggerFactory.getLogger(TodolistController.class);
   
   private TodolistService todolistservice;
   private BoardService boardservice;
   private ProjectCalendarService calservice;

      
   @Autowired
   public TodolistController(TodolistService todolistservice, 
		   BoardService boardService, ProjectCalendarService calservice) {
	   
	   this.calservice = calservice;
	   this.todolistservice = todolistservice;
	   this.boardservice = boardService;
   }
   
	public static void init(HttpServletResponse response) {
        response.setContentType("text/html; charset=utf-8");
        response.setCharacterEncoding("utf-8");
    }
	
   
   @RequestMapping(value="/receive", method=RequestMethod.GET)
   public ModelAndView Todolist(ModelAndView mv, 
		   						@RequestParam("p_no") int p_no,  Principal principal,
		   						@RequestParam(value="p_mids", required = false) String p_id,
		   						@RequestParam(value="p_mnames", required = false) String p_name,
		   						@RequestParam(value="page", defaultValue="1", required=false) int page,
		   						@RequestParam(value = "search_word", defaultValue = "", required = false) String search_word) 
   {
	   
	   String p_ids[], p_names[], ids[];
	   
		p_id = get_id(p_no);
		p_name = get_name(p_no);
		   
		p_ids = p_id.split(",");
		p_names = p_name.split(",");
	   
		int limit = 10;
		int check = 0;
		
		int listcount = 0;
		

		listcount = todolistservice.getListCount(p_no);
		
		List<Todolist> todolist = new ArrayList<>();
		List<HashMap<String, Object>> r_list = new ArrayList<>();
		
		todolist = todolistservice.getTodolist2(p_no);
				
		String loginid = principal.getName();
		
				
		for (Todolist todo : todolist) {
	    	HashMap<String, Object> numlist = new HashMap<>();
	    	
	    	
	    	if(todo.getBoard_r_id() != null)
	    	{
	    		ids = todo.getBoard_r_id().split(",");
	    		check = 0;
		    		for(int j=0;j<ids.length;j++) 
		    		{

		    			if(loginid.equals(ids[j])) {
		    				check = 1;
		    		}
		    	}
		    	
		    	if(check == 1) {
			    	numlist.put("board_num", todo.getBoard_num());
			    	r_list.add(numlist);
		    	}
	    	}
	   
	    	
		}
		
		
		List<Todolist> todolist_tmp = new ArrayList<>();
		todolist = new ArrayList<>();
		check = 0;
		
		
		for (HashMap<String, Object> map : r_list) {
			int value = 0;
		    for (Map.Entry<String, Object> entry : map.entrySet()) {
		    	value = (Integer)entry.getValue();
		    	
		    	if(value != 0) {
		    		check++;
		    		if(search_word.equals("") || search_word == null) {
		    			todolist_tmp = todolistservice.getTodolist3(page, limit, p_no, value);
		    		}
		    		else {
		    			todolist_tmp = todolistservice.getSearchTodolist3(page, limit, p_no, value, search_word);
		    		}
			        todolist.addAll(todolist_tmp);
		    	}
		    }
		}
		
		
		listcount = check;

		int maxpage = (listcount + limit - 1) / limit;
		
		int startpage = ((page-1) / 10) * 10 +1;
		int endpage = startpage + 10 -1;
		
		if(endpage>maxpage)
			endpage=maxpage;
		
		String status = "r";
		
	   
	   mv.addObject("p_no", p_no);
	   mv.addObject("p_id", p_ids);
	   mv.addObject("p_name", p_names);
		mv.addObject("page",page);
		mv.addObject("maxpage",maxpage);
		mv.addObject("startpage",startpage);
		mv.addObject("endpage",endpage);
		mv.addObject("listcount",listcount);
		mv.addObject("todolist",todolist);
		mv.addObject("limit",limit);
		mv.addObject("status", status);
	   

		
	   logger.info("receive mv 결과" + mv);
	   

	   mv.setViewName("/todolist/todolist");
	   	   
	   return mv;

	}
   
   @RequestMapping(value="/send", method=RequestMethod.GET)
   public ModelAndView Todolist(ModelAndView mv, Principal principal,
		   						@RequestParam("p_no") int p_no, 
		   						@RequestParam(value="page", defaultValue="1", required=false) int page,
		   						@RequestParam(value = "search_word", defaultValue = "", required = false) String search_word)
   {
	   
	   String p_ids[], p_names[];
	   String id = principal.getName();
	   
	   List<Todolist> todolist = new ArrayList<>();
	   
		int limit = 10; 
		
		int listcount = 0;
		
		
		
		if(search_word.equals("") || search_word == null) {	
			listcount = todolistservice.getSendListCount(p_no, id);
			todolist = todolistservice.getTodolist(page, limit, p_no, id);
		} else {
			listcount = todolistservice.getSendSearchListCount(p_no, id, search_word);
			todolist = todolistservice.getSearchTodolist(page, limit, p_no, id, search_word);
		}
		
		int maxpage = (listcount + limit - 1) / limit;
		
		int startpage = ((page-1) /10) * 10 +1;
		int endpage = startpage + 10 -1;
		
		if(endpage>maxpage)
			endpage=maxpage;
		
		

	
	   
	   String p_id = get_id(p_no);
	   String p_name = get_name(p_no);
	   
	   p_ids = p_id.split(",");
	   p_names = p_name.split(",");
	   
	   String status = "s";
	   
	   
	   mv.addObject("p_no", p_no);
	   mv.addObject("p_id", p_ids);
	   mv.addObject("p_name", p_names);
		mv.addObject("page",page);
		mv.addObject("maxpage",maxpage);
		mv.addObject("startpage",startpage);
		mv.addObject("endpage",endpage);
		mv.addObject("listcount",listcount);
		mv.addObject("todolist",todolist);
		mv.addObject("limit",limit);
		mv.addObject("status",status);
	   
	   
	   logger.info("send mv 결과" + mv);
	   

	   mv.setViewName("/todolist/todolist");
	   	   
	   return mv;

	}
   
	@GetMapping(value = "/write") 
		public ModelAndView write(Principal principal, ModelAndView mv, 
								@RequestParam("p_no") int p_no ) {			
   
		String id = principal.getName();
		
	    	    
		String p_id = get_id(p_no);
		String p_name = get_name(p_no);
		   
		String[] p_ids = p_id.split(",");
		String[] p_names = p_name.split(",");
	    
	    mv.setViewName("todolist/write");
	    
	    mv.addObject("p_id", p_ids);
	    mv.addObject("p_name", p_names);
		
		mv.addObject("id", id);
		mv.addObject("p_no", p_no);
		
		
		logger.info(id);

		
		return mv;
	 
	}
	
	@PostMapping("/add")
	public String add(Todolist todolist,
				@RequestParam("r_name") String r_id,
				@RequestParam("p_no") int p_no){
		

		todolist.setBoard_r_id(r_id);
		todolist.setState("true");
		
		todolistservice.insertBoard(todolist);

		return "redirect:receive?p_no=" + p_no;

	}
	
	@GetMapping("/search-member")
	public void search(){
		return;
	}
   
   
   
	private String get_name(int p_no) {
		String name = todolistservice.get_name(p_no);
		
		return name;
	}
	
	private String get_id(int p_no) {
		String id = todolistservice.get_id(p_no);
		
		
		return id;
	}
	
	@GetMapping("/detail")
	
	   public ModelAndView Detail (
			   Principal principal,
			   @RequestParam("p_no") int p_no,
			   @RequestParam("num") int num, 
			   @RequestParam("s") int s,
			   ModelAndView mv){

		String id = principal.getName();
		String admin = boardservice.getadmindate(id);
		
		String p_no2 = String.valueOf(p_no);
		
		String hostid = calservice.gethostid(p_no2);
		
		Todolist todolist = todolistservice.getDetail(num);

	
		mv.setViewName("todolist/detail");
			
		mv.addObject("todolist", todolist);
		mv.addObject("admin", admin);
		mv.addObject("hostid", hostid);
		mv.addObject("s", s);
		
		return mv;
	}
	
	@PostMapping("/delete")
	   public void todolistDeleteAction (
			   @RequestParam("num") int num)	{
		
		
		
		
		todolistservice.boardDelete(num);
		
		


		return;

	}
	
	@GetMapping("/modifyView")
	
	   public ModelAndView BoardModifyView (
			   @RequestParam("p_no") int p_no,
			   @RequestParam("num") int num, 
			   @RequestParam("s") int s, ModelAndView mv, HttpServletRequest request){

				
		Todolist todolist = todolistservice.getDetail(num);
		
		if(todolist == null) {
			logger.info("수정보기 실패");
			mv.setViewName("error/error");
			mv.addObject("url", request.getRequestURL());
			mv.addObject("message","수정보기 실패입니다.");
			return mv;
		}
		
		logger.info("수정 상세보기 성공");
		
		mv.addObject("todolist", todolist);
		mv.addObject("s", s);
		mv.addObject("p_no", p_no);
		mv.setViewName("todolist/modify");
			
		
		return mv;
	}
	
	@PostMapping("/modifyAction")
	   public String BoardModifyAction (
			   @RequestParam("p_no") int p_no,
			   @RequestParam("s") int s,
	            Todolist todolist, Model mv, HttpServletRequest request, RedirectAttributes rattr)
	throws Exception{
		
		int result = todolistservice.boardModify(todolist);
		String url;
		
		if(result ==0) {
			logger.info("수정 실패");
			
			mv.addAttribute("url", request.getRequestURL());
			mv.addAttribute("message","게시판 수정실패입니다.");
			url="error/error";
		} else {
			logger.info("수정 완료");
		
			url="redirect:detail";
			
			rattr.addAttribute("num", todolist.getBoard_num());
			rattr.addAttribute("s", s);
			rattr.addAttribute("p_no", p_no);
			
		}
		return url; 
				
		
	}

}