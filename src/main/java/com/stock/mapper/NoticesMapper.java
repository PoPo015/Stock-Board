package com.stock.mapper;

import java.util.List;

import com.stock.domain.NoticesReplyVo;
import com.stock.domain.NoticesVo;
import com.stock.util.Criteria;

public interface NoticesMapper {

	//공지사항 등록
	public void noticesRegister(NoticesVo vo);

	//공지사항 출력 페이징x
	public List<NoticesVo> noticesList();
	
	//공지사항 상세보기
	public NoticesVo details(int bno);
	
	//공지사항 삭제
	public void delete(int bno);
	
	//공지사항 수정
	public void modify(NoticesVo vo);
	
	//공지사항 페이징리스트
	public List<NoticesVo> getList(Criteria cri);
	
	//공지사항 검색페이징리스트
	public List<NoticesVo> serach(Criteria cri);

	//댓글 등록
	public void noticesReply(NoticesReplyVo vo);
}
