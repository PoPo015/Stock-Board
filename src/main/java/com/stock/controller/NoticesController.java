package com.stock.controller;

import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.stock.domain.NoticesReplyVo;
import com.stock.domain.NoticesVo;
import com.stock.service.NoticesService;
import com.stock.util.Criteria;
import com.stock.util.PageDTO;

import lombok.extern.log4j.Log4j;

@Controller
@RequestMapping("/notices")
@Log4j
public class NoticesController {

	@Autowired
	private NoticesService service;
	
	//공지사항 메인페이지
	@GetMapping("/list")
	public void noticesList(Criteria cri,Model model) {
		
			log.info("번호찾기--" + service.getList(cri).get(0).getTotal());
			log.info("일반페이징--" + service.getList(cri));
			model.addAttribute("noticesList", service.getList(cri));
			model.addAttribute("page", new PageDTO(cri, service.getList(cri).get(0).getTotal()));
	
	}
	
	//공지사항 작성
	@GetMapping("/register")
	public void noticesRegister() {

	}
	
	//공지사항 작성
	@PostMapping("/register")
	public String noticesRegister2(NoticesVo vo) throws Exception {

		log.info("vo----"+ vo);
		service.notices(vo);
		
		return "redirect:/notices/list";
	}
	
	//공지사항 상세보기
	@GetMapping("/details/{bno}")
	public String noticesDetails(@PathVariable("bno") int bno, Model model) {
		
		log.info("디테일----" + bno);

		model.addAttribute("details", service.details(bno));
		
		return "/notices/details";
	
	}
	//공지사항 삭제
	@GetMapping("/delete/{bno}")
	public String noticesDelete(@PathVariable("bno") int bno, Model model) {
		
		log.info("삭제번호-----" + bno);
		
		service.delete(bno);
		
		return "redirect:/notices/list";

	}	
	
	//공지사항 수정
	@GetMapping("/modify/{bno}")
	public String noticesModify(@PathVariable("bno")int bno, Model model) {
	
		log.info("수정번호-----" + bno);
		
		model.addAttribute("details",service.details(bno));
		
		return "notices/modify";
	}
	
	//공지사항 수정
	@PostMapping("/modify")
	public String noticesModify2(NoticesVo vo, Model model) {
	
		log.info("수정----" + vo);
		
		service.modify(vo);
			
		return "redirect:/notices/list";
	}
	
	//공지사항 댓글 등록
	@RequestMapping(value ="/reply", consumes = MediaType.APPLICATION_JSON_UTF8_VALUE)
	public ResponseEntity<NoticesReplyVo> reply(@RequestBody NoticesReplyVo vo) {
		
		vo.setRegTime(new Date());
		
		log.info("댓글 확인--" + vo);
		service.noticesReply(vo);
		
		return new ResponseEntity<NoticesReplyVo>(vo,HttpStatus.OK);
	}
	
	@ResponseBody
	@RequestMapping(value="/replyList/{bno}", consumes = MediaType.APPLICATION_JSON_UTF8_VALUE)
	public List<NoticesReplyVo> replyList(@PathVariable("bno")int bno) {
		
		log.info("댓글 목록 실행함수----" + bno);
		service.noticesReplyList(bno);
		
		return 	service.noticesReplyList(bno);
		
	}
}
