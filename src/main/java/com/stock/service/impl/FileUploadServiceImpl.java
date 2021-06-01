package com.stock.service.impl;

import java.io.File;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
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
		
		
		//정규식 공백 체크못함(replace 함수로 공백을 붙여서 if로 조건비교하는방식으로 사용)
		String regKind = "^([\\S]+(\\.(?i)(jpg|png|gif|gif|bmp|jpeg))$)";
		int fileSize = 1024*1024*10;
		
		log.info(multipartfile.getOriginalFilename().matches(regKind));
		if(multipartfile.getOriginalFilename().replaceAll(" ", "").matches(regKind) == false || fileSize < multipartfile.getSize()) {
			
			log.info("파일 확장자 or 파일 사이즈 false 반환합니다.");
			
			return vo;
		}
		
		log.info("Service----" + multipartfile.getOriginalFilename());
			
		
		//파일 경로 프로젝트 최상위 경로만 절대경로로 지정해둠.
		String uploadFolder =  "C:\\Users\\popo\\Documents\\stockboard\\src\\main\\webapp\\resources\\images\\" + FileUploadUtil.days();		//파일생성경로
		String thmnail ="";																													//파일썸네일
		String uploadFileName = multipartfile.getOriginalFilename();																		//파일오리지널이름
		String UUIDFileName = FileUploadUtil.getUUID(uploadFileName);																		//파일uuid이름
		File saveFile = new File(uploadFolder, UUIDFileName);																				//폴더경로에 uuid파일 생성

		log.info("uploadFolder---------" + uploadFolder);
		
		
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
		
		String filePath = "C:\\Users\\popo\\Documents\\stockboard\\src\\main\\webapp\\resources\\images\\" +vo.getFilePathDay()+ "\\";
		String regKind = "^([\\S]+(\\.(?i)(jpg|png|gif|gif|bmp|jpeg))$)";
		
		log.info(vo.getFileOriginalNm().matches(regKind));
		
		
		
		if(vo.getFileOriginalNm().replaceAll(" ", "").matches(regKind)) {
			
			log.info("이미지파일입니다. 썸네일도 삭제합니다");
			new File(filePath + "THUMB_" +  vo.getFileOriginalNm()).delete();			//썸네일파일삭제
		}
		
		
		log.info("파일경로--" + filePath);
		new File(filePath + vo.getFileOriginalNm()).delete();		//파일삭제
		mapper.removeFile(vo.getFileBno());
		
	}

	
	@Override
	public List<NoticesFileUploadVo> fileListGet(int bno) {

	    	  log.info("서비스----"+ bno);

	    	  
	    	  
	    	  List<NoticesFileUploadVo> arr = mapper.fileListGet(bno);
	    	  for(int i=0; i< arr.size(); i++) {
	    		
	    		  arr.get(i).setImgFilePath(arr.get(i).getFilePath().substring(arr.get(i).getFilePath().indexOf("\\resources")) + "\\" + arr.get(i).getFileUuidNm() );
	    		  arr.get(i).setFilePathDay(arr.get(i).getFilePath().substring(arr.get(i).getFilePath().indexOf("\\202")+1));
	    		  log.info(arr.get(i));
	    	  }
	    	  	
	    	  return arr;
		}
		
	
	
}
	

	
	
