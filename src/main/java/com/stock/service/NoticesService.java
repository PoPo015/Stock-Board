package com.stock.service;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.web.bind.annotation.RequestParam;

import com.stock.domain.NoticesLikeAndDislike;
import com.stock.domain.NoticesReplyVo;
import com.stock.domain.NoticesVo;
import com.stock.util.Criteria;

public interface NoticesService {

	//공지사항 등록
	public void notices(NoticesVo vo, @RequestParam(required = false)List<Integer> fileBno) throws Exception;
	
	//공지사항 출력
	public List<NoticesVo> noticesList();
	
	//공지사항 상세보기
	public NoticesVo details(int bno);
	
	//공지사항 삭제
	public void delete(int bno,HttpSession session);
	
	//공지사항 수정
	public void modify(NoticesVo vo,@RequestParam(required = false)List<Integer> fileBno);

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
	//좋아요
	public String noticesLike(NoticesLikeAndDislike vo, HttpSession session);
	//좋아요 취소
	public String noticesDisLike(NoticesLikeAndDislike vo, HttpSession session);
}
