package com.stock.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

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
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.stock.domain.NoticesLikeAndDislike;
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
	public String noticesRegister2(NoticesVo vo,HttpSession session, @RequestParam(required = false)List<Integer> fileBno) throws Exception {
		
		String title = vo.getTitle();
		String content = vo.getContent();
		//제목값이 공백 / null / 길이가 0일경우
		if(title.length() == 0 || title.equals(" ") || title.equals("null")) {
			return "redirect:/notices/list";
		}
		//내용값이 공백 / null /길이가0일경우
		if(content.length() == 0 || title.equals(" ") || title.equals("null")) {
			return "redirect:/notices/list";
		}
		
		
		if((String)session.getAttribute("userId") == null) {
			return "redirect:/notices/list";
		}
		
		
		vo.setWriter((String)session.getAttribute("userId"));;
		log.info("vo----"+ vo);
		
		service.notices(vo,fileBno);
		
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
	public String noticesDelete(@PathVariable("bno") int bno, HttpSession session, Model model) {
		
		log.info("삭제번호-----" + bno);
		
		service.delete(bno,session);
		
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
	public String noticesModify2(NoticesVo vo, HttpSession session, @RequestParam(required = false)List<Integer> fileBno, Model model) {
		
		String title = vo.getTitle();
		String content = vo.getContent();
		//제목값이 공백 / null / 길이가 0일경우
		if(title.length() == 0 || title.equals(" ") || title.equals("null")) {
			return "redirect:/notices/list";
		}
		//내용값이 공백 / null /길이가0일경우
		if(content.length() == 0 || title.equals(" ") || title.equals("null")) {
			return "redirect:/notices/list";
		}
		
		//비정상적인 수정접근
		if(!vo.getWriter().equals(session.getAttribute("userId"))) {
			log.info("비정상적인 수정. 수정하지않습니다.");
		}

		log.info("수정----" + vo);
		
		service.modify(vo,fileBno);
			
		return "redirect:/notices/list";
	}
	
	//공지사항 댓글 등록
	@PostMapping(value ="/reply", consumes = MediaType.APPLICATION_JSON_UTF8_VALUE)
	public ResponseEntity<NoticesReplyVo> reply(@RequestBody NoticesReplyVo vo, HttpSession session) {
		
		String reply = vo.getReply();
		String replyer = (String)session.getAttribute("userId");
		
		log.info("replyer----" + replyer);
		//제목값이 공백 / null / 길이가 0일경우
		if(reply.length() == 0 || reply.equals(" ") || reply.equals("null")) {
			return new ResponseEntity<NoticesReplyVo>(HttpStatus.INTERNAL_SERVER_ERROR);
		}
		//로그인계정이  null 일경우
		if(replyer.equals("null")) {
			return new ResponseEntity<NoticesReplyVo>(HttpStatus.INTERNAL_SERVER_ERROR);
		}
		log.info("댓글 확인--" + vo);
		service.noticesReply(vo);
		
		return new ResponseEntity<NoticesReplyVo>(vo,HttpStatus.OK);
	}
	
	//공지사항 댓글 목록 로드
	@ResponseBody
	@GetMapping(value="/replyList/{bno}", consumes = MediaType.APPLICATION_JSON_UTF8_VALUE)
	public List<NoticesReplyVo> replyList(@PathVariable("bno")int bno) {
		
		log.info("댓글 목록 실행함수----" + bno);
		service.noticesReplyList(bno);
		
		return 	service.noticesReplyList(bno);
	}
	
	//공지사항 댓글 수정
	@ResponseBody
	@PostMapping(value="/replyModify")
	public String replyModify(@RequestBody NoticesReplyVo vo, HttpSession session) {
		
		String reply = vo.getReply();
		String replyer = (String)session.getAttribute("userId");
		
		//제목값이 공백 / null / 길이가 0일경우
		if(reply.length() == 0 || reply.equals(" ") || reply.equals("null")) {
			return "error";
		}
		//로그인값이 null 0일경우
		if(replyer.equals("null")) {
			return "error";
		}
		
		log.info("댓글수정 vo---" + vo);
		vo.setReplyer(replyer);
		service.noticesReplyModify(vo);
		
		return "success";
	}
	
	//공지사항 댓글삭제
	@ResponseBody
	@PostMapping(value="/replyDelete/{rno}")
	public String replyDelete(@PathVariable("rno") int rno, HttpSession session) {
		
		String replyer = (String)session.getAttribute("userId");
		
		//로그인값이 null 0일경우
		if(replyer.equals("null")) {
			return "error";
		}
		
		log.info("rno----" + rno);
		
		service.noticesReplyDelete(rno, session);
	
		return "success";
	}
	
	//좋아요
	@ResponseBody
	@PostMapping("/like")
	public Map<String, Object> noticesLike(@RequestBody NoticesLikeAndDislike vo, HttpSession session, Model model) {
		
		String result = service.noticesLike(vo, session);
		Map<String, Object> map = new HashMap<String, Object>();
		
		
		if(result.equals("success")) {
			map.put("result", "success");
			map.put("likeCount", service.details(vo.getBno()).getLikeCount());
			return map;
		}else if(result.equals("like")) {
			map.put("result", "like");
			return map;
		}else {
			map.put("result", "error");
		}
		
		return null;
	}
	
	@ResponseBody
	@PostMapping("/disLike")
	public Map<String, Object> noticesDisLike(@RequestBody NoticesLikeAndDislike vo, HttpSession session, Model model) {
		
		String result = service.noticesDisLike(vo, session);
		Map<String, Object> map = new HashMap<String, Object>();
		
		if(result.equals("success")) {
			map.put("result", "success");
			map.put("likeCount", service.details(vo.getBno()).getLikeCount());
			return map;
		}else {
			map.put("result","error");
			return map;
		}
		
				

	}
	
}
