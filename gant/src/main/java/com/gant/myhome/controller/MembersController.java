package com.gant.myhome.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.security.Principal;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.CookieValue;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.gant.myhome.domain.MailVO;
import com.gant.myhome.domain.Members;
import com.gant.myhome.service.MemberService;
import com.gant.myhome.task.SendMail;

@Controller
@RequestMapping(value = "/member")//http://localhost:9696/gant/member/ 로 시작하는 주소 맴핑
public class MembersController {
	
	private static final Logger logger = LoggerFactory.getLogger(MembersController.class);
	
	private MemberService  memberservice;
	private PasswordEncoder passwordEncoder;
	private SendMail sendMail;
		
	@Autowired
	public MembersController(MemberService memberservice , PasswordEncoder passwordEncoder,SendMail sendMail) {
	this.memberservice = memberservice;
	this.passwordEncoder = passwordEncoder;
	this.sendMail = sendMail;
	}
	
	
	/*
	<security:remember-me> 설정 후
    로그인 유지를 위한 쿠키의 값 수정
	 */
	@RequestMapping(value = "/login" , method = RequestMethod.GET)
	public ModelAndView login(ModelAndView mv, 
							  @CookieValue(value="remember-me",required=false) Cookie readCookie,
							  HttpSession session, HttpServletRequest request,
							  Principal userPrincipal) {
		
		String readCookie2 = "";
		String readCookie2_val = "";
		Cookie[] cookies = request.getCookies();
		if(cookies != null) {
			for(int i=0; i<cookies.length; i++) {
				if(cookies[i].getName().equals("store")) {
					readCookie2 = cookies[i].getName();
					readCookie2_val = cookies[i].getValue();
				}
			}
		}

		if(readCookie != null) {
				logger.info("자동로그인 쿠키 로드 :" + userPrincipal.getName()); //principal.getName() : 로그인한 아이디
				mv.setViewName("redirect:/pmain/view");
		}else if (!readCookie2.equals("")){
			logger.info("ID저장 쿠키 로드 ");
			mv.setViewName("member/login");
			mv.addObject("id_store", readCookie2_val);
			mv.addObject("loginfail",session.getAttribute("loginfail"));
			session.removeAttribute("loginfail");
		} else {
			mv.setViewName("member/login");
			mv.addObject("loginfail",session.getAttribute("loginfail")); //세션에 저장된 값을 한 번만 실행될 수 있도록 mv에 저장
			session.removeAttribute("loginfail"); //세션의 값은 제거
		}
		return mv;
	}
	
	@RequestMapping(value="/join", method=RequestMethod.GET)
	public String join() {
		return "member/join"; //WEB-INF/views/member/member_joinForm.jsp
	}	
	
	//회원가입폼에서 아이디 검사
	@RequestMapping(value = "/idcheck", method=RequestMethod.POST)
	public void idcheck(@RequestParam("id") String id,
						HttpServletResponse response) throws Exception {
		
		int result = memberservice.idCheck(id);
		response.setContentType("text/html;charset=utf-8");
		PrintWriter out = response.getWriter();
		out.print(result);
	}
	
	@ResponseBody
	@PostMapping(value = "/sendCert")
	public Map<String,String> certCheck(String emdomain) {
		logger.info("인증발송ajax");
		int num = (int) (Math.random() * 999999 + 1);
		String certnum = String.format("%06d", num);
		
		MailVO vo = new MailVO();
		vo.setTo(emdomain);
		vo.setSubject("인증번호 [" + certnum + "] 이메일 인증 메일입니다.");
		vo.setContent("인증번호는 " + certnum + " 입니다.");
		
		sendMail.sendMail(vo);
		
		Map<String,String> map = new HashMap<String,String>();
		map.put("certnum", certnum);
		map.put("result", "인증번호를 발송했습니다.");
		
		return map;
	}
	
	@RequestMapping(value = "/joinProcess",method=RequestMethod.POST)
	public String joinProcess(String jumin1, String jumin2, String phone1, String phone2, String phone3,
							  String email, String domain, Members m, RedirectAttributes rattr,
							  Model model) {
		
		m.setAdmin("false");
		String encPassword = passwordEncoder.encode(m.getPassword());
		m.setPassword(encPassword);
		m.setJumin(jumin1+"-"+jumin2);
		m.setPhone_num(phone1+"-"+phone2+"-"+phone3);
		m.setEmail(email+"@"+domain);
		
		logger.info("회원가입 비밀번호 암호화");
		int result = memberservice.insert(m);
		
		if(result==1) {
			rattr.addFlashAttribute("result","joinSuccess");
			return "redirect:login";
		}else {
			model.addAttribute("message","회원 가입 실패입니다.");
			return "error/error";
		}
	}
	
	@GetMapping(value ="/findid")
	public String findId() {
		return "member/findid";
	}
	
	@PostMapping(value="/findidok")
	public ModelAndView findIdOk(Members m, RedirectAttributes rattr, ModelAndView mv) {
		String id = memberservice.findIdCheck(m);
		
		if(id.equals("")) {
			rattr.addFlashAttribute("noname","noname");
			mv.setViewName("redirect:/member/findid");
		}else if(id.equals("noemail")) {
			rattr.addFlashAttribute("noemail","noemail");
			mv.setViewName("redirect:/member/findid");
		}else { //정보 잘 찾은 경우
			mv.addObject("name",m.getName());
			mv.addObject("id", id);
			mv.setViewName("member/findidok");
		}
		return mv;
	}

	@GetMapping(value ="/findpass")
	public String findPass() {
		return "member/findpass";
	}
	
	@PostMapping(value ="/findpassok")
	public ModelAndView findPassOk(Members members, RedirectAttributes rattr, ModelAndView mv) {
		
		String pass = memberservice.findPassCheck(members);
		if(pass.equals("noid")) { //아이디 존재X
			rattr.addFlashAttribute("noid","noid");
			mv.setViewName("redirect:/member/findpass");
		}else if (pass.equals("noname")) { //이름 존재X
			rattr.addFlashAttribute("noname","noname");
			mv.setViewName("redirect:/member/findpass");
		}else if (pass.equals("noemail")){ //이메일 존재X
			rattr.addFlashAttribute("noemail","noemail");
			mv.setViewName("redirect:/member/findpass");
		}else { //정보 잘 찾은 경우
			mv.addObject("id", members.getId());
			mv.addObject("password", pass);
			mv.setViewName("member/findpassok");
		}
		return mv;
	}
	
	@PostMapping(value="/findpassokProcess")
	public String findPassOkProcess(Members m, RedirectAttributes rattr, Model model,
									HttpServletRequest request) {
		
		String encPassword = passwordEncoder.encode(m.getPassword());
		m.setPassword(encPassword);
		
		int result = memberservice.passUpdate(m);
		if(result==1) {
			rattr.addFlashAttribute("update","success");
			return "redirect:login";
		}else {
			//model.addAttribute("url", request.getRequestURI()); 오류난 url을 보냄
			model.addAttribute("message","비밀번호 변경 실패");
			return "error/error";
		}
	}
	

	
	@RequestMapping(value ="/list")
	public ModelAndView membersList(Principal principal,
						  @RequestParam(value="page", defaultValue="1", required=false) int page,
						  @RequestParam(value="searchfield", defaultValue="", required=false) String searchfield,
						  @RequestParam(value="searchword", defaultValue="", required=false) String searchword,
						  ModelAndView mv, HttpServletResponse response) throws IOException {
		
		int limit = 6; //최대 보이는 수
		
		int membercount = memberservice.getMembersCount(searchfield,searchword); //총 리스트 수
		List<Members> memberlist = memberservice.getMembersList(searchfield, searchword, page, limit); //페이지별 회원리스트
		
		int maxpage = (membercount + limit - 1) / limit; //총 페이지수
		int startpage = ((page-1)/10) * 10 + 1;
		int endpage = startpage + 10 - 1;
		
		if (endpage > maxpage) endpage=maxpage;
		
		// 로그인 풀린 상태면 로그인창으로 이동
		String id = principal.getName();
		mv.addObject("id",id);

		
		//관리자와 인사부는 삭제버튼 보이기 위한 코드
		String isadminhuman = memberservice.isAdminHuman(id);
		
		//회원리스트 조회를 위한 코드
		mv.addObject("isadminhuman", isadminhuman);
		mv.addObject("page", page); //기본값1,넘어온값 있으면 보낸다.
		mv.addObject("maxpage", maxpage);
		mv.addObject("startpage", startpage);
		mv.addObject("endpage", endpage);
		
		mv.addObject("membercount", membercount);
		mv.addObject("memberlist", memberlist);
		mv.addObject("searchfield", searchfield);
		mv.addObject("searchword", searchword);
		
		mv.setViewName("member/list");
		return mv;
	}
	
	@ResponseBody
	@PostMapping(value="/orgchart")
	public Map<String,String> getOrgchart() {
		
		//각 부서별 이름을 ','로 구분하여 String형으로 담음
		String plan = memberservice.selectByDname("기획부");
		String sales = memberservice.selectByDname("영업부");
		String human = memberservice.selectByDname("인사부");
		String it = memberservice.selectByDname("전산부");
		String chong = memberservice.selectByDname("총무부");
		String account = memberservice.selectByDname("회계부");
		
		Map<String,String> map = new HashMap<String,String>();
		map.put("plan", plan);
		map.put("sales", sales);
		map.put("human", human);
		map.put("it", it);
		map.put("chong", chong);
		map.put("account", account);
		
		return map;
	}
	
	@ResponseBody
	@PostMapping(value="/commuteCheck")
	public Map<String,String> commuteCheck(String id) {
		
		String check = memberservice.checkCommute(id);
		Map<String,String> map = new HashMap<String,String>();
		map.put("check", check);
		return map;
	}
	
	@ResponseBody
	@PostMapping(value="/detail")
	public Map<String,String> memberDetail(String clickid) {
		
		Members m = memberservice.getMemberInfo(clickid);
		
		HashMap<String,String> map = new HashMap<String,String>();
		map.put("name", m.getName());
		map.put("profileimg", m.getProfileimg());
		map.put("department", m.getDepartment());
		map.put("position", m.getPosition());
		map.put("birth", m.getBirth());
		map.put("phone_num", m.getPhone_num());
		map.put("email", m.getEmail());
		map.put("address", m.getAddress());
		//map에 members 담아서도가능
		return map;
	}
	
	@RequestMapping(value="/delete")
	public String delete(String listid, RedirectAttributes rattr, Model model) {
		int result = memberservice.delete(listid);

		if(result==1) {
			rattr.addFlashAttribute("message","삭제를 완료했습니다.");
			return "redirect:/member/list";
		}else {
			model.addAttribute("message","회원삭제 실패입니다.");
			return "error/error";
		}

	}
}
