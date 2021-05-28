package com.stock.service.impl;

import java.io.File;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.http.codec.multipart.FilePart;
import org.springframework.stereotype.Service;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.multipart.MultipartFile;

import com.stock.domain.NoticesFileUploadVo;
import com.stock.mapper.FileUploadMapper;
import com.stock.service.FileUploadService;
import com.stock.util.FileUploadUtil;

import lombok.extern.log4j.Log4j;

@Log4j
@Service
public class FileUploadServiceImpl implements FileUploadService {

	@Autowired
	private FileUploadMapper mapper;

	@Override
	public NoticesFileUploadVo uploadFile(MultipartFile multipartfile) {
		
		NoticesFileUploadVo vo = new NoticesFileUploadVo();
		
		log.info("Service----" + multipartfile.getOriginalFilename());
			
		
		//파일 경로 리팩토링필요(정적으로 때려박음)
		String uploadFolder = "C:\\Users\\popo\\Documents\\stockboard\\src\\main\\webapp\\resources\\images\\" + FileUploadUtil.days();		//파일생성경로
		String thmnail ="";																													//파일썸네일
		String uploadFileName = multipartfile.getOriginalFilename();																		//파일오리지널이름
		String UUIDFileName = FileUploadUtil.getUUID(uploadFileName);																		//파일uuid이름
		File saveFile = new File(uploadFolder, UUIDFileName);																				//폴더경로에 uuid파일 생성

		vo.setFilePath(uploadFolder);																										//파일경로 vo에지정
		vo.setFileUuidNm(UUIDFileName);																										//파일파일uuid vo에지정
		vo.setFileOriginalNm(uploadFileName);																								//파일오리지널이름 vo에지정
		vo.setFileSize((int)multipartfile.getSize());																						//파일사이즈 vo에지정
		vo.setFileKind(uploadFileName.substring(uploadFileName.lastIndexOf(".")+1).toUpperCase());											//오리지널이름에서 확장자명을 찾아서,대문자변경
		
		log.info("파일vo----" + vo);
        log.info("voBno 실행전---" + vo.getFileBno());
        vo.setImgFilePath(vo.getFilePath().substring(vo.getFilePath().indexOf("\\resources"))+"\\THUMB_"+ UUIDFileName.replaceAll(" ", "%20"));	//공백% 20로치환
        vo.setFilePathDay(vo.getFilePath().substring(vo.getFilePath().lastIndexOf("\\") +1));													//날짜별 값 저장
        
        try {
        	multipartfile.transferTo(saveFile);          			  																		 //파일 생성
           if(FileUploadUtil.getImage(UUIDFileName, uploadFolder) != null) {       															 //섬네일일경우 
        	   thmnail = FileUploadUtil.days() +"\\"+ FileUploadUtil.getImage(UUIDFileName, uploadFolder);									 //섬네일 생성
           }else {
        	   thmnail = UUIDFileName;
           }
           log.info(thmnail);
           mapper.attach(vo);																												 //DB에 저장
           log.info("voBno 실행후1---" + vo);
           log.info("voBno 실행후2---" + vo.getFileBno());
           
        }catch (Exception e) {
           e.printStackTrace();
        }
        return vo;
	}

	@Override
	public void removeFile(NoticesFileUploadVo vo) {
		
		log.info("서비스vo----" + vo);
		
		String filePath = "C:\\Users\\popo\\Documents\\stockboard\\src\\main\\webapp\\resources\\images\\"
							+vo.getFilePathDay()+"\\"+vo.getFileOriginalNm();
		
		log.info("파일경로--" + filePath);
		File fileName = new File(filePath);

		
		fileName.delete();
		mapper.removeFile(vo.getFileBno());
		
	}
  
		
	}

	
	
