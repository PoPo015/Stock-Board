package com.stock.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.security.GeneralSecurityException;
import java.util.Date;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.MediaType;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.util.WebUtils;

import com.stock.domain.UserVo;
import com.stock.service.UserService;

import lombok.extern.log4j.Log4j;

@Log4j
@RequestMapping("/user")
@Controller
public class UserController {
	
	@Autowired
	private UserService service;
	
	//로그인 페이지
	@GetMapping("/login")
	public String login() {
		log.info("로그인페이지---");

		return "/user/userLogin";
		
	}
	
	//로그인 Post
	@PostMapping("/login")
	public ModelAndView loginPost(UserVo vo, HttpServletResponse response,HttpSession session) throws IOException {

		log.info("로그인시도합니다 Controller----" + vo);
		ModelAndView mv = new ModelAndView();
		
		String result = service.userLogin(vo);
		
		if(result.equals("로그인 성공")) {
			//자동 로그인 유지 체크
			if(vo.isRememberMe()) {
				log.info("자동 로그인 유지");
				Cookie loginCookie = new Cookie("loginCookie", session.getId());
				log.info("cookie---" + loginCookie.getValue());
				loginCookie.setPath("/");
				loginCookie.setMaxAge(60*60*24*7);
				response.addCookie(loginCookie);
				int amount = 60 * 60 * 24 * 7;
				Date sessionLimit = new Date(System.currentTimeMillis() + (1000 * amount));
				service.keepLogin(vo.getUserId(), loginCookie.getValue(), sessionLimit);
			}
			
			log.info("로그인성공");
			session.setAttribute("userId", vo.getUserId());
			mv.setViewName("redirect:/notices/list");
			return mv;
		}else {
			log.info("로그인 실패");
			mv.addObject("Id", vo.getUserId());
			mv.addObject("Pw", vo.getUserPw());
			mv.addObject("err", "로그인에 실패했습니다 \\n 정보를 확인해주세요.");
			mv.setViewName("/user/userLogin");
			return mv;
		}
		
	}
	
	//로그아웃
	@GetMapping("/logout")
	public String userLogout(HttpSession session, HttpServletRequest request, HttpServletResponse response) {
		log.info("계정 로그아웃합니다");
		Cookie loginCookie = WebUtils.getCookie(request, "loginCookie");
		
		//쿠키삭제
		if(loginCookie != null) {
			log.info("쿠키값있다 쿠키도 삭제합니다-----"+loginCookie);
			loginCookie.setPath("/");
			loginCookie.setMaxAge(0);
			response.addCookie(loginCookie);
			log.info("getAttribute--"+session.getAttribute("userId"));
			service.keepLogin((String)session.getAttribute("userId"), "none", new Date());
		}
		//세션삭제
		if(session.getAttribute("userId") != null) {
			log.info("로그아웃 세션--" + session.getAttribute("userId"));
			session.invalidate();
		}
		return "redirect:/notices/list";
	}
	
	//마이페이지
	@GetMapping("/myPage")
	public ModelAndView userMyPage(HttpSession session) {
		
		String userId = ""+(String)session.getAttribute("userId");
		ModelAndView mv = new ModelAndView();
		
		log.info("userId---" + userId);
		
		if(userId.equals("null")){
			log.info("로그인안됬어요/ 비정상접근");
			mv.setViewName("redirect:/notices/list");
			return mv;
		}
		
		log.info(service.userMyPage((String)session.getAttribute("userId")));
		UserVo vo = service.userMyPage((String)session.getAttribute("userId"));

		log.info("myPage vo----" + vo);
		 
		if(vo.getUserRegWithdrawal() != null) {
			log.info("회원탈퇴계정입니다.");
			
			mv.addObject("userId", vo.getUserId());
			mv.addObject("userRegWithdrawal", vo.getUserRegWithdrawal());
			mv.setViewName("/user/userWithdrawalCancel");
			return mv;
		}else {
			log.info("vo--" + vo);
			mv.addObject("userId", vo.getUserId());
			mv.addObject("userNm", vo.getUserNm());
			mv.addObject("userEmail", vo.getUserEmail());
			mv.addObject("userPhone", vo.getUserPhone());
			mv.addObject("addressZipCode", vo.getAddressZipCode());
			mv.addObject("addressRoadName", vo.getAddressRoadName());
			mv.addObject("addressDetailed", vo.getAddressDetailed());
			mv.setViewName("/user/userMyPage");
			return mv;
		}
	}
		
	//비밀번호 변경 페이지
	@GetMapping("/pwChange")
	public String userPwChange(HttpSession session) {
		String userId = ""+(String)session.getAttribute("userId");
		
		if(userId.equals("null")){
			log.info("로그인안됬어요/ 비정상접근");
			return "redirect:/notices/list";
		}
		
		log.info("비밀번호 변경페이지");
		return "/user/userPwChange";
	}
	
	//비밀번호 변경 post
	@PostMapping("/pwChange")
	public void userPwChange(UserVo vo, HttpSession session, HttpServletResponse response) throws IOException {
		
		log.info("비밀번호변경-*-- vo" + vo);
		vo.setUserId((String)session.getAttribute("userId"));
		
		String pwChk = service.userPwChange(vo);
		response.setContentType("text/html; charset=UTF-8");
		PrintWriter out = response.getWriter();
		
		log.info(pwChk);
		
		if(pwChk.equals("비밀번호 수정 성공")) {
			out.println("<script>alert('비밀번호 수정 성공'); location.href='/user/myPage';</script>");
			out.flush();
		}else if(pwChk.equals("비밀번호 수정 실패")) {
			out.println("<script>alert('비밀번호 수정 실패'); location.href='/user/pwChange';</script>");
			out.flush();
		}else if(pwChk.equals("비밀번호 동일 실패")) {
			out.println("<script>alert('비밀번호가 바꾸기전과 동일합니다. \\n 바꾸시려는 비밀번호를 확인해주세요'); location.href='/user/pwChange';</script>");
			out.flush();
		}
		
	}
	
	//마이페이지 post
	@PostMapping("/myPage")
	public void userMyPage(UserVo vo, HttpSession session, HttpServletResponse response) throws IOException {
		
		log.info("vo----" + vo);
		String userId = (String)session.getAttribute("userId");

		response.setContentType("text/html; charset=UTF-8");
		PrintWriter out = response.getWriter();
		
		if(service.userUpdate(vo, userId).equals("정보수정성공")) {
			log.info("정보수정 성공~");
			out.println("<script>alert('정보수정 성공'); location.href='/user/myPage';</script>");
			out.flush();
		}else {
			out.println("<script>alert('정보수정 실패'); location.href='/user/myPage';</script>");
			out.flush();
		}
	}
	
	//계정생성 페이지
	@GetMapping("/create")
	public String userCreate() {
		
		log.info("회원가입페이지---");
		
		return "/user/userCreate";
		
	}
	
	//계정 생성Post
	@PostMapping("/create")
	public void userCreatePage(UserVo vo, HttpServletRequest request, HttpServletResponse response) throws IOException {
		
		log.info("테스트---" + vo);
		
		String result = service.userCreate(vo, request); //유저회원가입정보중 공백있으면 400에러발생
		
		if(result.equals("success")) {
			response.setContentType("text/html; charset=UTF-8");																//PrintWrtier에서 한글 인코딩이 깨지는 경우 셋팅
			PrintWriter out = response.getWriter();																				//반드시 PrintWriter 객체 선언하기 전에 셋팅해줘야 함
			out.println("<script>alert('정상적으로 회원가입 되었습니다.\\n로그인 페이지로 이동합니다'); location.href='/user/login'</script>");	//response.setCharacterEncoding("utf-8");
			out.flush();	// 현재 출력 버퍼에 저장되어 있는 내용을 웹 브라우저에 전송하고 비운다.
		}else {
			response.setContentType("text/html; charset=UTF-8");																//PrintWrtier에서 한글 인코딩이 깨지는 경우 셋팅
			PrintWriter out = response.getWriter();																				//반드시 PrintWriter 객체 선언하기 전에 셋팅해줘야 함
			out.println("<script>alert('비정상적인 회원가입입니다..\\n회원가입 페이지로 이동합니다'); location.href='/user/create'</script>");	//response.setCharacterEncoding("utf-8");
			out.flush();	// 현재 출력 버퍼에 저장되어 있는 내용을 웹 브라우저에 전송하고 비운다.
		}
	}

	//회원탈퇴
	@GetMapping("/withdrawal")
	public String userWithdrawal(HttpSession session) {
		
		String userId = ""+(String)session.getAttribute("userId");
		
		if(userId.equals("null")){
			log.info("로그인안됬어요/ 비정상접근");
			return "redirect:/notices/list";
		}
		
		log.info("회원탈퇴 페이지");
		return "/user/userWithdrawal";
	}
	
	//회원탈퇴 post
	@ResponseBody
	@PostMapping("/withdrawal")
	public String realUserWithdrawal(@RequestBody UserVo vo, HttpSession session) {
	
		String userId = ""+(String)session.getAttribute("userId");
		
		if(userId.equals("null")){
			log.info("로그인안됬어요/ 비정상접근");
			return "redirect:/notices/list";
		}
		
		
		log.info("회원탈퇴 vo ----" + vo);
		vo.setUserId((String)session.getAttribute("userId"));
		session.invalidate();             							//로그아웃
		return service.realUserWithdrawal(vo);

	}
	
	//회원탈퇴 철회
	@ResponseBody
	@PostMapping("/withdrawalCancel")
	public String userWithrawalCancel(@RequestBody UserVo vo, HttpSession session) {
		
		String userId = ""+(String)session.getAttribute("userId");
		
		if(userId.equals("null")){
			log.info("로그인안됬어요/ 비정상접근");
			return "redirect:/notices/list";
		}
		
		log.info("회원탈퇴 철회 vo----"  + vo );
		vo.setUserId((String)session.getAttribute("userId"));
		
		return service.userWithrawalCancel(vo);
	}
	//유저 아이디 찾기
	@GetMapping("/userFindId")
	public void userFindId() {
		log.info("유저 아이디찾기 페이지--");
	}
	
	//유저 아이디 찾기
	@ResponseBody
	@PostMapping("/userFindId")
	public String userFindIdPost(UserVo vo) throws Exception {
	
		log.info("FindId Vo----" + vo);
		
		return service.userFindIdPost(vo);
		
	}

	@GetMapping("/userFindPw")
	public void userFindPw() {
		log.info("유저 비밀번호찾기 페이지--");
	}
	
	
	@ResponseBody
	@PostMapping("/userFindPw")
	public String userFindPwPost(UserVo vo) throws Exception {
		log.info("유저 비밀번호찾기 페이지--");
		log.info("vo---" + vo);
		
		return service.userFindPwPost(vo);
	}
	
	@ResponseBody
	@PostMapping("/mailCertification")
	public String usermailCertification(UserVo vo,HttpSession session) throws Exception {
		log.info("vo---" +vo);
		
		String result = service.usermailCertification(vo);
		if(result.equals("success")) {
			session.setAttribute("userPwChange", vo.getUserId());
			
			return "success";
		}
		
		return "error";
	}
	
	@GetMapping("/userFindPwChange")
	public void userFindChg() throws IOException {
		log.info("비밀번호 찾기 / 변경페이지");
	}
	
	@PostMapping("/userFindPwChange")
	public void userFindChgPost(UserVo vo,HttpSession session, HttpServletResponse response) throws IOException {		
		
		String userFindPwChange = (String)session.getAttribute("userPwChange");
		response.setContentType("text/html; charset=UTF-8");
		PrintWriter out = response.getWriter();
		
		if(userFindPwChange == null) {
			out.println("<script>alert('비정상적인 접근입니다'); location.href='/notices/list';</script>");
			out.flush();
		}
		
		vo.setUserId(userFindPwChange);
		
		String pwChk = service.userFindPwChange(vo);

		if(pwChk.equals("비밀번호 수정 성공")) {
			session.invalidate();
			out.println("<script>alert('비밀번호 수정 성공'); location.href='/user/login';</script>");
			out.flush();
		}else if(pwChk.equals("비밀번호 수정 실패")) {
			out.println("<script>alert('비밀번호 수정 실패');</script>");
			out.flush();
		}
		
	}
		
	
	//카카오 로그인
	@ResponseBody
	@PostMapping("/kakaoLogin")
	public String kakaoLogin(@RequestBody UserVo vo, HttpSession session) {


		String kakaoResult = service.userKakao(vo);
		log.info(kakaoResult);
		if(kakaoResult.equals("kakaoSuccess")) {
			log.info("카카오 회원가입을 합니다.");
			session.setAttribute("userId", vo.getUserNick());
			return "kakaoSuccess";
		}else if(kakaoResult.equals("kakaoLogin")) {
			log.info("이미 연동되있는 카카오 계정입니다.");
			session.setAttribute("userId", vo.getUserNick());
			return "kakaoLogin";
		}else {
			log.info("카카오 로그인 에러");
			return "kakaoError";
		}
	}
	
	//네이버 로그인
	@GetMapping("/naverLogin")
	public String naverLogin(@RequestParam(value="access_token", required = false) String accessToken, HttpSession session, Model model){
		
		if(accessToken == null ) {
			log.info("토큰값 없습니다 콜백 jsp로 보냅니다.----" + accessToken);
			return "/user/naver/userNaverCallBack";
		}else {
			UserVo vo = service.userNaver(accessToken);
			session.setAttribute("userId", vo.getUserNick());
            return "redirect:/notices/list"; 
		}
		
	}
	
	//구글 로그인
	@ResponseBody
	@PostMapping(value = "/googleLogin", consumes = MediaType.APPLICATION_JSON_UTF8_VALUE)
	public void googleLogin(@RequestBody UserVo vo, HttpSession session) throws GeneralSecurityException, IOException {
		log.info("vo--"+ vo);
		vo = service.userGoogle(vo.getIdToken());
		session.setAttribute("userId", vo.getUserNick());
	}
	
	
	//id,email중복체크
	@ResponseBody
	@PostMapping("/createIdAndEmailCheck")
	public int userIdAndEmailCheck(UserVo vo) {
		
		log.info("userandEmail---" + vo);
		
		return service.userIdAndEmailCheck(vo);
		
	}
	
}
