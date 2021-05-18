package com.stock.service;

import java.util.List;

import com.stock.domain.NoticesReplyVo;
import com.stock.domain.NoticesVo;
import com.stock.util.Criteria;

public interface NoticesService {

	//공지사항 등록
	public void notices(NoticesVo vo) throws Exception;
	
	//공지사항 출력
	public List<NoticesVo> noticesList();
	
	//공지사항 상세보기
	public NoticesVo details(int bno);
	
	//공지사항 삭제
	public void delete(int bno);
	
	//공지사항 수정
	public void modify(NoticesVo vo);

	//일반 페이징list
	public List<NoticesVo> getList(Criteria cri);
	
	//검색 페이징list
	public List<NoticesVo> serach(Criteria cri);
	
	//댓글 등록
	public NoticesReplyVo noticesReply(NoticesReplyVo vo);
	
	//댓글 리스트
	public List<NoticesReplyVo> noticesReplyList(int bno);
	
	//댓글수정
	public void noticesReplyModify(NoticesReplyVo vo);
	
	//댓글삭제
	public void noticesReplyDelete(int rno);
}
