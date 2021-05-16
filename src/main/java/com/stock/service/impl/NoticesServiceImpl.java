package com.stock.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.ui.Model;

import com.stock.domain.NoticesReplyVo;
import com.stock.domain.NoticesVo;
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
	
	@Override
	public void notices(NoticesVo vo) throws Exception {
		
		log.info("vo----" + vo);
		
		if(vo.getWriter().equals("관리자")) {
			
//			SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss",Locale.KOREA);
//			String time1 = simpleDateFormat.format(new Date());
//			log.info("time1----" + time1);
//			vo.setRegTime(time1);
//			log.info("등록 시간-----" + vo);
//			
			mapper.noticesRegister(vo);
		}
	
	}

	@Override
	public List<NoticesVo> noticesList() {
			
		return mapper.noticesList();
		
	}

	@Override
	public NoticesVo details(int bno) {

		log.info(mapper.details(bno));
		
		return mapper.details(bno);
		
	}

	@Override
	public void delete(int bno) {

		log.info("servicedelete-----" +bno);
		
		mapper.delete(bno);
		
	}

	@Override
	public void modify(NoticesVo vo) {

		log.info("서비스 수정---" + vo );
		
		mapper.modify(vo);
	}

	@Override
	public List<NoticesVo> getList(Criteria cri) {
		if(cri.getKeyword() != null && cri.getType() != null) {
			log.info("키워드있다~!!!!!~~"+cri);
			log.info("검색 페이징 리턴---" + mapper.serach(cri));
			return mapper.serach(cri);
		} else if((cri.getKeyword() == null && cri.getType() == null)) {
			log.info("키워드없음~~~"+cri);
			log.info("일반페이징 리턴---" + mapper.getList(cri));
			return mapper.getList(cri);
		}
		return null;
	}

	@Override
	public List<NoticesVo> serach(Criteria cri) {
		return mapper.serach(cri);
	}

	@Override
	public void noticesReply(NoticesReplyVo vo) {

		log.info("서비스 댓글vo---" + vo);
		
		mapper.noticesReply(vo);
		
	}



}
