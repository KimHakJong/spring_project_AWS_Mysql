package com.gant.myhome.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.gant.myhome.domain.Calendar;
import com.gant.myhome.service.CalendarService;


@Controller
@RequestMapping(value="/calendar")
//http://localhost:8088/myhome4/calendar/ 로 시작하는 주소 
public class CalendarController {
   
   private static final Logger logger = LoggerFactory.getLogger(CalendarController.class);
   
   private CalendarService calservice;

      
   @Autowired
   public CalendarController(CalendarService calservice) {
	   this.calservice = calservice;

   }


   
   @RequestMapping(value="/list", method=RequestMethod.GET)
   public ModelAndView CalList(ModelAndView mv) 
   {
		
       JSONArray jsonArr = new JSONArray();
       
       Map<String, Object> obj = new HashMap<>();
              
	   List<Calendar> list = calservice.getCalList();  
	 	   
	      
	   for(Calendar c : list) {
		   	   		   
		   JSONObject jsonObj = new JSONObject();
		   obj.put("title", c.getTitle());
		   obj.put("id", c.getId());
		   obj.put("name", c.getName());
		   obj.put("start", c.getStartday());
		   obj.put("end", c.getEndday());
		   obj.put("allDay", true);
		   
		   jsonObj = new JSONObject(obj);
		   jsonArr.add(jsonObj);

	   }
	   
	   
	   
	   mv.addObject("event", jsonArr);
	   mv.setViewName("/calendar/calendar2");
	   	   
	   return mv;

	}
   
   //requset body로 한번에 받아오는것도 고려
   @RequestMapping(value="/add", method=RequestMethod.POST)//name이 loginid
   public String addCal( @RequestParam("start") String startday, 
		   			@RequestParam("end") String endday,
   					@RequestParam("id") String id,
   					@RequestParam("name") String name,
   					@RequestParam("title") String title) {
	   
	   Calendar c = new Calendar();
	   
	   
	   
	   c.setName(name);
	   c.setId(id);
	   c.setStartday(startday);
	   c.setEndday(endday);
	   c.setTitle(title);
	   

	   
	   calservice.add(c);
	   
	   
	   
	   return "redirect:list";
	   
   }
   		
   @ResponseBody
   @RequestMapping(value="/getadmin")
   /*name이 loginid*/
   public String getadmin2(@RequestParam("id") String id) {

	   String admin = calservice.getadminid(id);

	   
	   return admin;
   }
   
   @RequestMapping(value="/update", method=RequestMethod.POST)
   public String updateCal( @RequestParam("start") String startday, 
		   			@RequestParam("end") String endday,
   					@RequestParam("id") String id,
   					@RequestParam("title") String title) {
	   
	  
	   Calendar c = new Calendar();
	   	   
	   c.setId(id);
	   c.setStartday(startday);
	   c.setEndday(endday);
	   c.setTitle(title);
	   
	   
	   
	   int result = 0;
	   result = calservice.update(c);
	
	   return "redirect:list";
	   
   }
   
   @RequestMapping(value="/delete", method=RequestMethod.POST)
   public String delcal( @RequestParam("id") String id,
   					@RequestParam("title") String title) {
	   
	   
	   Calendar c = new Calendar();
	   	   
	   c.setId(id);
	   c.setTitle(title);

	   
	   int result = 0;
	   result = calservice.caldelete(id);

	   return "redirect:list";
	   
   }
   
   
   

   
}