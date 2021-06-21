package com.stock.service.impl;

import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.RequestParam;

import com.stock.domain.NoticesLikeAndDislike;
import com.stock.domain.NoticesReplyVo;
import com.stock.domain.NoticesVo;
import com.stock.mapper.FileUploadMapper;
import com.stock.mapper.NoticesMapper;
import com.stock.service.NoticesService;
import com.stock.util.Criteria;

import lombok.extern.log4j.Log4j;

@Log4j
@Service
public class NoticesServiceImpl implements NoticesService {

	@Autowired
	private NoticesMapper mapper;
	
	@Autowired
	private FileUploadMapper fileMapper;
	
	@Override
	public void notices(NoticesVo vo, @RequestParam(required = false)List<Integer> fileBno) throws Exception {
		
		log.info("vo----" + vo);	
		
			mapper.noticesRegister(vo);

		//파일 bno가 form에 담겨옴 업데이트.
		if(fileBno != null) {
			
			for(int i = 0; i<fileBno.size(); i++) {
				log.info("fileBno있다---" + fileBno.get(i));
				log.info("값저장된 bno----" + vo.getBno());
				fileMapper.fileBnoUpdate(vo.getBno(), fileBno.get(i));
				log.info("업데이트합니다");
			}
			
		}
		
	}

	@Override
	public List<NoticesVo> noticesList() {
			
		return mapper.noticesList();
		
	}

	@Transactional
	@Override
	public NoticesVo details(int bno) {

		mapper.viewsCount(bno);
		
		return mapper.details(bno);
		
	}

	@Override
	public void delete(int bno,HttpSession session) {


		String userId = (String)session.getAttribute("userId");
		NoticesVo vo = mapper.details(bno);
		
		
		if(vo.getWriter().equals(userId)) {
			log.info("로그인한 계정과, 게시글작성자가 동일합니다.삭제합니다");
			mapper.delete(bno);
		}else {
			log.info("비정상적인 삭제.");
		}
		
	}

	@Override
	public void modify(NoticesVo vo,@RequestParam(required = false)List<Integer> fileBno) {

		log.info("서비스 수정---" + vo );
		
		//파일 bno가 form에 담겨옴 업데이트.
		if(fileBno != null) {
			
			for(int i = 0; i<fileBno.size(); i++) {
				log.info("fileBno있다---" + fileBno.get(i));
				log.info("값저장된 bno----" + vo.getBno());
				fileMapper.fileBnoUpdate(vo.getBno(), fileBno.get(i));
				log.info("업데이트합니다");
			}
			
		}

		mapper.modify(vo);
	}

	@Override
	public List<NoticesVo> getList(Criteria cri) {
		if(cri.getKeyword() != null && cri.getType() != null) {
			log.info("키워드있다~!!!!!~~"+cri);
//			log.info("검색 페이징 리턴---" + mapper.serach(cri));
			log.info("검색 페이징 리턴---");
			return mapper.serach(cri);
		} else if((cri.getKeyword() == null && cri.getType() == null)) {
			log.info("키워드없음~~~"+cri);
//			log.info("일반페이징 리턴---" + mapper.getList(cri));
			log.info("일반페이징 리턴---");
			return mapper.getList(cri);
		}
		return null;
	}

	@Override
	public List<NoticesVo> serach(Criteria cri) {
		return mapper.serach(cri);
	}

	@Override
	public NoticesReplyVo noticesReply(NoticesReplyVo vo) {

		mapper.noticesReply(vo);
		vo.setRegTime(new Date());
		vo.setRno(vo.getRno());
		
		return vo;
	}

	
	@Override
	public List<NoticesReplyVo> noticesReplyList(int bno) {

		log.info("댓글목록--" + mapper.noticesReplyList(bno));
		
		return mapper.noticesReplyList(bno);
	}

	@Override
	public void noticesReplyModify(NoticesReplyVo vo) {

		mapper.noticesReplyModify(vo);
	}

	@Override
	public void noticesReplyDelete(int rno,HttpSession session) {
		
		NoticesReplyVo vo = new NoticesReplyVo();
		vo.setRno(rno);
		vo.setReplyer((String) session.getAttribute("userId"));
		
		log.info("댓글삭제 vo--" + vo);
		mapper.noticesReplyDelete(vo);

	}

	@Transactional
	@Override
	public String noticesLike(NoticesLikeAndDislike vo, HttpSession session) {
		
		final String userId = (String)session.getAttribute("userId");		//user id
		int LikeCheck;												//게시글에 좋아요되있는지?
		
		
		log.info("LiKEVo----" + vo);
		
		if(userId != null) {
			log.info("로그인 계정--" + userId);
			vo.setUserId(userId);
			log.info("vo----like" +vo);
			
			LikeCheck = mapper.noticesLike(vo);
			
			log.info("이 계정이 이 게시글에 좋아요 되있나요?" + LikeCheck);
			
			if(LikeCheck == 0 && vo.isCheckLikeAndDislike() == true) {
				mapper.likeUp(vo);
				log.info("좋아요 +1합니다.");
				mapper.likeInsert(vo);
				log.info("like테이블에 정보를 등록합니다. 중복방지.");
				return "success";
			}else if(LikeCheck == 1) {
				return "like";
			}
		}
		
		log.info("로그인이 안되있습니다.");
		return "error";
	}

	@Transactional
	@Override
	public String noticesDisLike(NoticesLikeAndDislike vo, HttpSession session) {
		
		final String userId=(String)session.getAttribute("userId");
		int LikeCheck;
		log.info("로그인계정 아이디 session---" + userId);
		
		
		if(userId != null ) {
			vo.setUserId(userId);
			LikeCheck = mapper.noticesLike(vo);
			
			if(LikeCheck == 1) {
				log.info("좋아요취소 합니다");
				mapper.noticesDisLike(vo);
				log.info("좋아요 테이블에서 삭제합니다");
				mapper.likeDelete(vo);
				
				return "success";
			}
		}
		log.info("비정상적인 취소");
		return "error";
	}

}
