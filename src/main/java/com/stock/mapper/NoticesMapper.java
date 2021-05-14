package com.stock.mapper;

import java.util.List;

import com.stock.domain.NoticesVo;
import com.stock.util.Criteria;

public interface NoticesMapper {

	//공지사항 등록
	public void noticesRegister(NoticesVo vo);

	//공지사항 출력
	public List<NoticesVo> noticesList();
	
	//공지사항 상세보기
	public NoticesVo details(int bno);
	
	//공지사항 삭제
	public void delete(int bno);
	
	//공지사항 수정
	public void modify(NoticesVo vo);
	
	public List<NoticesVo> getList(Criteria cri);

	public List<NoticesVo> serach(Criteria cri);
	
	public int serachTotal(Criteria cri);
	//게시물 총개수
	public int totalCount();
}
