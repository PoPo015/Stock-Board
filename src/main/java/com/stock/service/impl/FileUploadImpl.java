package com.stock.service.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.stock.mapper.FileUploadMapper;
import com.stock.service.FileUpload;

import lombok.extern.log4j.Log4j;

@Log4j
@Service
public class FileUploadImpl implements FileUpload {

	@Autowired
	private FileUploadMapper mapper;

	@Override
	public void test() {
		
	}
	
	
}
