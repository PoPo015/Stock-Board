package com.stock.util;

import java.io.BufferedReader;
import java.io.File;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;

import com.stock.domain.NoticesFileUploadVo;
import com.stock.domain.UserVo;
import com.stock.mapper.FileUploadMapper;
import com.stock.mapper.UserMapper;

@Component
public class SchedulerUtil {

	@Autowired
	private FileUploadMapper mapper;
	
	@Autowired
	private UserMapper userMapper;
	
	
					//초 분 시 일 월 요일 연도 (매월 1일 새벽3시동작) cron좀더 수정필요
					//파일 삭제
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
	
	@Scheduled(cron = "0 0 0 * * *")
//	@Scheduled(cron = "30 * * * * *")
	public void userWithdrawal() {
		
		ArrayList<UserVo> arrayList = (ArrayList<UserVo>)userMapper.userWithrawalList();
		BufferedReader in = null;
		
		
		System.out.println(arrayList.size());
		
		if(arrayList.size() != 0) {
			System.out.println("회원탈퇴할게 있습니다. 탈퇴해야해용");
			
			for(int i=0; i<arrayList.size(); i++) {
				userMapper.userRemove(arrayList.get(i).getUserId());
				System.out.println("유저 삭제완료");
				
				//일단 나중에처리
//				try {
//				URL obj = new URL("http://localhost:5109/user/logout"); // 로그아웃 url 호출
//				HttpURLConnection con = (HttpURLConnection)obj.openConnection();
//				con.setRequestMethod("GET"); 
//				in = new BufferedReader(new InputStreamReader(con.getInputStream(), "UTF-8"));
//
//				String line; 
//				while((line = in.readLine()) != null) { 
//					System.out.println(line); //response를 차례대로 출력 
//				}
//				}catch (Exception e) {
//					e.printStackTrace();
//				}finally {
//					if(in != null) try { in.close(); } catch(Exception e) { e.printStackTrace(); }
//				}
				

			}
		}
		
	}

	
}
