package com.stock.mapper;

import org.apache.ibatis.annotations.Param;

import com.stock.domain.NoticesFileUploadVo;

public interface FileUploadMapper {
	//파일 db 컬럼저장
	public void attach(NoticesFileUploadVo vo); 	
	
	//파일번호 fk업데이트
	public void fileBnoUpdate(@Param("bno")int bno, @Param("fileBno")int fileBno);					

	//파일 삭제
	public void removeFile(int fileBno);
	
//	public ArrayList<NoticesFileUploadVo> fileListGet(int bno); //게시물 번호 파일가져오기

	
}
