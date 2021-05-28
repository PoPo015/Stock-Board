package com.stock.service;

import org.springframework.web.multipart.MultipartFile;

import com.stock.domain.NoticesFileUploadVo;

public interface FileUploadService {
	
	//파일업로드
	public NoticesFileUploadVo uploadFile(MultipartFile multipartfile);

	//파일 삭제
	public void removeFile(NoticesFileUploadVo vo);
	
}

