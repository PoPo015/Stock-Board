package com.stock.util;

import java.io.File;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;
import org.springframework.stereotype.Service;

import com.stock.domain.NoticesFileUploadVo;
import com.stock.mapper.FileUploadMapper;

@Component
public class SchedulerUtil {

	@Autowired
	private FileUploadMapper mapper;
	
					//초 분 시 일 월 요일 연도 (매월 1일 새벽3시동작) cron좀더 수정필요
	@Scheduled(cron ="0 0 3 1 * *") 
	public void nullFileRemove() {

		System.out.println("1일입니다 잘못된 파일값들을 삭제합니다.");
		
		List<NoticesFileUploadVo> vo = mapper.nullFile();
		
		for(int i =0; i<vo.size(); i++) {
			System.out.println(vo.get(i));
			

			String regKind = "^([\\S]+(\\.(?i)(jpg|png|gif|gif|bmp|jpeg))$)";
			
			
			if(vo.get(i).getFileOriginalNm().replaceAll(" ", "").matches(regKind)) {
				
				System.out.println("썸네일파일도 삭제합니다.");
				System.out.println(vo.get(i).getFilePath() + "\\THUMB_" +  vo.get(i).getFileUuidNm());
				new File(vo.get(i).getFilePath() + "\\THUMB_" +  vo.get(i).getFileUuidNm()).delete();			//썸네일파일삭제
			}
			

			System.out.println("일반파일도 삭제합니다.");
			System.out.println(vo.get(i).getFilePath() + "\\" +vo.get(i).getFileUuidNm());
			new File(vo.get(i).getFilePath() + "\\" +vo.get(i).getFileUuidNm()).delete();		//파일삭제
			mapper.removeFile(vo.get(i).getFileBno());
			
		}
		
	}

	
}
