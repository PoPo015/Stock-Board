package com.stock.service;

import org.springframework.http.ResponseEntity;
import org.springframework.web.multipart.MultipartFile;

import com.stock.domain.NoticesFileUploadVo;

public interface FileUploadService {

	public NoticesFileUploadVo uploadFile(MultipartFile multipartfile);

}
