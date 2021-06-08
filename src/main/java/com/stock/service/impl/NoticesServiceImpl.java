package com.stock.service.impl;

import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestParam;

import com.stock.domain.NoticesReplyVo;
import com.stock.domain.NoticesVo;
import com.stock.mapper.FileUploadMapper;
import com.stock.mapper.NoticesMapper;
import com.stock.service.NoticesService;
import com.stock.util.Criteria;
import com.stock.util.PageDTO;

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
		if(vo.getWriter().equals("관리자")) {
			mapper.noticesRegister(vo);
		}
		
		
		//파일 bno가 form에 담겨옴 업데이트.
		if(fileBno != null) {
			
			for(int i = 0; i<fileBno.size(); i++) {
				log.info("fileBno있다---" + fileBno.get(i));
				log.info("값저장된 bno----" + vo.getBno());
				fileMapper.fileBnoUpdate(vo.getBno(), fileBno.get(i));
				log.info("업데이트합니다");
			}
			
		}

		
		
			
//			SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss",Locale.KOREA);
//			String time1 = simpleDateFormat.format(new Date());
//			log.info("time1----" + time1);
//			vo.setRegTime(time1);
//			log.info("등록 시간-----" + vo);
//			
	
	}

	@Override
	public List<NoticesVo> noticesList() {
			
		return mapper.noticesList();
		
	}

	//트랜잭션 
	@Transactional
	@Override
	public NoticesVo details(int bno) {

		mapper.viewsCount(bno);
		
		return mapper.details(bno);
		
	}

	@Override
	public void delete(int bno) {

		log.info("servicedelete-----" +bno);
		
		mapper.delete(bno);
		
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
	public void noticesReplyDelete(int rno) {

		mapper.noticesReplyDelete(rno);

	}



}
