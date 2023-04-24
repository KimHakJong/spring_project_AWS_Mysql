package com.gant.myhome.controller;


import java.io.PrintWriter;
import java.security.Principal;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.gant.myhome.domain.Members;
import com.gant.myhome.domain.Memo;
import com.gant.myhome.service.MemberService;
import com.gant.myhome.service.MemoService;

@Controller
@RequestMapping(value="/small")
public class SmallController {
	
private static final Logger logger = LoggerFactory.getLogger(MembersController.class);
	
	private MemberService  memberservice;
	private MemoService memoservice;
	
	@Autowired
	public SmallController(MemberService memberservice, MemoService memoservice) {
		this.memberservice = memberservice;
		this.memoservice = memoservice;
	}
	
	@ResponseBody
	@PostMapping(value="/memolist")
	public List<Memo> getMemoList(String id) {
		logger.info("ajax컨트롤러까지감");
		List<Memo> list = memoservice.getMemoList(id);
		return list; 
		
	}
	
	@RequestMapping(value="/chat")
	public ModelAndView chatView(Principal userPrincipal, ModelAndView mv, HttpServletResponse response) throws Exception {
		
		String id = userPrincipal.getName();
		
		if(id==null) {
			response.setContentType("text/html;charset=utf-8");
			PrintWriter out = response.getWriter();
			out.println("<script>");
			out.println("alert('로그인 후 이용해주세요');");
			out.println("window.close();");
			out.println("location.href='../member/login';");
			out.println("</script>");
			out.close();
			return null;
		}
		
		Members member = memberservice.getMemberInfo(id); //채팅에 필요한 name,프로필사진값 가져옴
		
		mv.addObject("member",member);
		mv.setViewName("chat/chat");
		return mv;
	}
	
	@ResponseBody
	@PostMapping(value="/update_insertmemo")
	public Map<String,Integer> updateMemo(Memo memo) {
		int result = 0;
		
		Map<String,Integer> map = new HashMap<String,Integer>();
		
		if(memo.getNum()==-1) { //새로 메모추가한 경우: 메모컬럼 insert 후 , 메모번호넘겨줌(추가한 메모 다시 저장할 때 또 insert방지)
			result = memoservice.add(memo);
			logger.info("추가:"+result);
			map.put("result", result);
			int insert_num = memoservice.getMemoNum(memo.getId());
			logger.info("추가번호:"+insert_num);
			map.put("insert_num", insert_num);
			
		}else {
			result = memoservice.update(memo);
			logger.info("수정:"+result);
			map.put("result", result);
		}
		return map;
	}
	
	@ResponseBody
	@PostMapping(value="/loadmemo")
	public Memo loadMemo(int num) {
		Memo memo = memoservice.getMemoOne(num);
		return memo;
	}
	
	@ResponseBody
	@PostMapping(value="/deletememo")
	public int deleteMemo(int num) {
		int result = memoservice.delete(num);
		return result;
	}
}
