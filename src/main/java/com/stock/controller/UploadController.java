package com.stock.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.stock.service.FileUpload;

import lombok.extern.log4j.Log4j;

@Log4j
@Controller
@RequestMapping("/upload")
public class UploadController {
	
	@Autowired
	private FileUpload fileUpload;
	
	
}
