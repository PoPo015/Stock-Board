package com.stock.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.stock.domain.NoticesFileUploadVo;

public interface FileUploadMapper {
	//파일 db 컬럼저장
	public void attach(NoticesFileUploadVo vo); 	
	
	//파일번호 fk업데이트
	public void fileBnoUpdate(@Param("bno")int bno, @Param("fileBno")int fileBno);					

	//파일 삭제
	public void removeFile(int fileBno);
	
	//파일 게시물 가져오기
	public List<NoticesFileUploadVo> fileListGet(int bno);
	

	
}
