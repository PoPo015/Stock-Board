package com.stock.mapper;

import java.util.ArrayList;

import com.stock.domain.NoticesFileUploadVo;

public interface FileUploadMapper {

	public void attach(NoticesFileUploadVo vo); 	//파일 db 컬럼저장

//	public int insertbno(); 					//게시글 번호등록
//	
//	public void deleteAttach(String SfileCut); // 파일삭제
//	
//	public ArrayList<NoticesFileUploadVo> fileListGet(int bno); //게시물 번호 파일가져오기

	
}
