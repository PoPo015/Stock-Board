package com.stock.service;

import java.util.List;

import org.springframework.web.multipart.MultipartFile;

import com.stock.domain.NoticesFileUploadVo;

public interface FileUploadService {
	
	//파일업로드
	public NoticesFileUploadVo uploadFile(MultipartFile multipartfile);

	//파일 삭제
	public void removeFile(NoticesFileUploadVo vo);
	
	//파일목록 가져오기
	public List<NoticesFileUploadVo> fileListGet(int bno);
	
}

