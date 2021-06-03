package com.stock.controller;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.mindrot.jbcrypt.BCrypt;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.stock.domain.UserVo;
import com.stock.service.UserService;
import com.stock.util.GetClientIp;

import lombok.extern.log4j.Log4j;

@Log4j
@RequestMapping("/user")
@Controller
public class UserController {
	
	@Autowired
	private UserService service;
	
	
	@GetMapping("/login")
	public String login() {
		
		log.info("로그인페이지---");
		
		return "/user/userLogin";
		
	}
	
	@PostMapping("/login")
	public ModelAndView loginPost(UserVo vo, HttpSession session) throws IOException {

		log.info("로그인시도합니다 Controller----" + vo);
		ModelAndView mv = new ModelAndView();
		
		
		String result = service.userLogin(vo);
		
		if(result.equals("로그인 성공")) {
			log.info("로그인성공");
			session.setAttribute("userId", vo.getUserId());
			mv.setViewName("redirect:/notices/list");
				
			return mv;
		}else {
			log.info("로그인 실패");
			mv.addObject("userId", vo.getUserId());
			mv.addObject("userPw", vo.getUserPw());
			mv.addObject("err", "로그인에 실패했습니다 \\n 정보를 확인해주세요.");
			mv.setViewName("/user/userLogin");
		return mv;
		}
		
	}
	
	
	@GetMapping("/create")
	public String userCreate() {
		
		log.info("회원가입페이지---");
		
		return "/user/userCreate";
		
	}
	
	//유저 생성
	@PostMapping("/create")
	public void userCreatePage(UserVo vo, HttpServletRequest request, HttpServletResponse response) throws IOException {
		
		log.info("테스트---" + vo);
		
		service.userCreate(vo, request); //유저회원가입정보중 공백있으면 400에러발생

		
		//PrintWrtier에서 한글 인코딩이 깨지는 경우 셋팅
		//반드시 PrintWriter 객체 선언하기 전에 셋팅해줘야 함
		//response.setCharacterEncoding("utf-8");
		response.setContentType("text/html; charset=UTF-8");
		PrintWriter out = response.getWriter();
		out.println("<script>alert('정상적으로 회원가입 되었습니다.\\n로그인 페이지로 이동합니다'); location.href='/user/login'</script>");
		out.flush();	// 현재 출력 버퍼에 저장되어 있는 내용을 웹 브라우저에 전송하고 비운다.

	}

	//id,email중복체크
	@ResponseBody
	@PostMapping("/createIdAndEmailCheck")
	public int userIdAndEmailCheck(UserVo vo) {
		
		log.info("userandEmail---" + vo);
		
		return service.userIdAndEmailCheck(vo);
		
	}
	
}
