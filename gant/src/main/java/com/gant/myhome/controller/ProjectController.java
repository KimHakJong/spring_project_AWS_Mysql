package com.gant.myhome.controller;

import java.security.Principal;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.gant.myhome.domain.Members;
import com.gant.myhome.domain.Project;
import com.gant.myhome.service.MemberService;
import com.gant.myhome.service.ProjectService;

@Controller
@RequestMapping(value="/pmain")
public class ProjectController {
	
	private static final Logger logger = LoggerFactory.getLogger(ProjectController.class);
	
	private ProjectService projectservice;
	private MemberService memberservice;
	private PasswordEncoder passwordEncoder;
	
	@Autowired
	public ProjectController(ProjectService projectservice, MemberService memberservice, PasswordEncoder passwordEncoder) {
		this.projectservice = projectservice;
		this.memberservice = memberservice;
		this.passwordEncoder = passwordEncoder;
	}
	
	@RequestMapping(value="/view")
	public ModelAndView mainView(Principal principal, ModelAndView mv, HttpSession session,
							@RequestParam(value="p_name", defaultValue="", required=false) String p_name) {
			String id = principal.getName();
			Members m = memberservice.getMemberInfo(id);
			List<Project> list = projectservice.getProjectList(id, p_name, m.getAdmin(), m.getPosition());
			session.setAttribute("profileimg", m.getProfileimg());
			session.setAttribute("name", m.getName());
			mv.addObject("list",list);
			mv.addObject("check_id",id);
			mv.setViewName("pmain/view");
			return mv;
	}
	
	@PostMapping(value="/createProject")
	public String createProject(Project project, RedirectAttributes rattr, Model model) {
		int result = projectservice.create(project);
		logger.info("생성이동");
		if(result==1) {
			rattr.addFlashAttribute("create",result); //프로젝트 생성 성공시 1보냄
			return "redirect:/pmain/view";
		}else {
			model.addAttribute("message", "프로젝트 생성 오류입니다");
			return "error/error";
		}
	}
	
	@ResponseBody
	@PostMapping(value="/loadupdatemodal")
	public Project loadUpdateModal(int p_no) {
		Project pro = projectservice.getProjectOne(p_no);
		logger.info(pro.getP_content());
		return pro;
	}
	
	@PostMapping(value="/updateProject")
	public String updateProject(Project project, RedirectAttributes rattr, Model model) {
		int result = projectservice.update(project);
		if(result==1) {
			rattr.addFlashAttribute("update",result);
			return "redirect:/pmain/view";
		}else {
			model.addAttribute("message","프로젝트 수정 실패");
			return "error/error";
		}
	}
	
	@ResponseBody
	@PostMapping(value="/memberlist_ajax")//명단검색에서 회원명단 가져오기 위함
	public List<Members> memberList_ajax(){
		List<Members> list = memberservice.getMembersList_ajax();
		return list; 
	}
	
	@ResponseBody
	@PostMapping(value="/searchMemberList_ajax")
	public List<Members> searchMemberList_ajax(String name){
		List<Members> list = memberservice.getSearchMembersList_ajax(name);
		return list;
	}
	
	@GetMapping(value="/deleteProject")
	public String deleteProject(int p_no, RedirectAttributes rattr, Model model) {
		int result = projectservice.delete(p_no);
		if(result == 1) {
			rattr.addFlashAttribute("delete",result);
			return "redirect:/pmain/view";
		}else {
			model.addAttribute("message","프로젝트 삭제 실패");
			return "error/error";
		}
	}
	
	@ResponseBody
	@PostMapping(value="/pmemberdetail")
	public List<Members> pMemberDetail(int p_no){
		Project project = projectservice.getProjectOne(p_no);
		String[] ids = project.getP_mids().split(",");
		List<Members> list = new ArrayList<Members>();
		for(int i=0; i<ids.length; i++) {
			Members m = memberservice.getMemberInfo(ids[i]);
			list.add(m);
		}
		
		return list;
	}
}
