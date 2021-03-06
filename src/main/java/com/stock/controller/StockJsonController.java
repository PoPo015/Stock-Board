package com.stock.controller;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileOutputStream;
import java.io.InputStreamReader;
import java.io.PrintStream;
import java.net.HttpURLConnection;
import java.net.URL;
import java.util.ArrayList;
import java.util.Date;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;

import com.stock.domain.StockNewsVo;
import com.stock.domain.StockVo;
import com.stock.service.StockService;

import lombok.extern.log4j.Log4j;

@Controller
@Log4j
@RequestMapping("/stock")
public class StockJsonController {
	
//	@Setter(onMethod_ = @Autowired)
	@Autowired
	private StockService service;

	// list 페이지로 이동
	@GetMapping(value = "/list")
	public void GetList(Model model) {
		
		log.info("리스트출력");
		
	}
	
	//json 배열 db에 담기
	@PostMapping(value = "/VI_ListReg" ,consumes = "application/json")
	public ResponseEntity<String> createList(@RequestBody StockVo vo){
		
		PrintStream ps = null;
		FileOutputStream fos=null;


		//StockVO 객체에 쌓인 데이터 Arraylist에 담기
		ArrayList<StockVo> jsonList = new ArrayList<StockVo>(vo.getListDate());
		
		// 데이터 확인을 위해 객체 생성
		StockVo vo2 = new StockVo();

		//ArrayList에 들어온 인덱스 크기만큼 반복문 돔
		for(int i=0; i<jsonList.size(); i++) {
			
			log.info(jsonList.get(i));
			
			// jsonList데이터 인덱스 i번째 데이터를 vo2에 담음.
			vo2 = jsonList.get(i);
			
			//공백제거
			log.info(vo2.getStk_nm().replaceAll(" ", ""));
			vo2.setStk_nm(vo2.getStk_nm().replaceAll(" ", ""));
			
			//stk_id int형변환
			vo2.setIstk_id(Integer.parseInt(vo2.getStk_id()));
			
			
			// json으로 된 데이터중 중복된 데이터가 있는지 확인, 있다면 1반환 없다면 0 반환 
			int jsonCount = service.getJson(vo2);
			int jsonCountRel = service.getJson2(vo2);
			try {
				File file = new File("C:\\Users\\popo\\Desktop\\stock-toy\\stock-toy\\err\\VI_log.txt");
				fos = new FileOutputStream(file,true); // VI_log파일에 출력 준비
				ps=new PrintStream(fos); // err의 출력을 화면이 아닌, error.log파일로 변경
				System.setErr(ps);
		
			//데이터가 0이라면 없음  - 등록
			if(jsonCount == 0) {
				log.info("데이터가 없습니다 등록합니다");
				//텔레그램 api 호출
				System.out.println("텔레그램 호출");
				telgram(vo2);
				
				service.ViListRegister(vo2);
			}
			
			//데이터가 0이 아니라면 있음 (2중if문으로  데이터의 해제시각까지 조회) 
			if(jsonCount != 0) {
				log.info("j가 0이 아니네요 해제시각을 비교해봅니다");

					if(jsonCountRel == 1) {
						log.info("데이터는 등록 되있으나, 시간이 그대로니 아무것도안합니다");
					}else if(jsonCountRel == 0) {
						log.info("해제 시각만 업데이트합니다");
						service.jsonUpdate(vo2);
					}
				}
			} //for문 end
		catch (Exception e) {
			System.out.println("예외발생 기록합니당");
			System.err.println("-----------------------------------");
			System.err.println("예외발생시간 : " + new Date());  // 현재시간출력
			//e.printStackTrace(System.err);
			System.err.println("예외메시지 : " + e.getMessage());
			System.err.println("-----------------------------------");
			//통신실패
			return new ResponseEntity<String>("error",HttpStatus.NOT_FOUND);
			}
			
		} //create json end

		//성공 200코드 발환
		return new ResponseEntity<String>("success", HttpStatus.OK);
	}	
	
	//vi News 크롤링 데이터담기
	@PostMapping(value = "/VI_NewsReg" ,consumes = "application/json")
	public ResponseEntity<String> createList2(@RequestBody StockNewsVo vo){

		PrintStream ps = null;
		FileOutputStream fos=null;
		try {
			File file = new File("C:\\Users\\popo\\Desktop\\stock-toy\\stock-toy\\err\\VI_News_log.text");
			fos = new FileOutputStream(file,true); // VI_News_log파일에 출력 준비
			ps=new PrintStream(fos); // err의 출력을 화면이 아닌, error.log파일로 변경
			System.setErr(ps);
			
		ArrayList<StockNewsVo> jsonList = new ArrayList<StockNewsVo>(vo.getNews_Data());

		log.info(jsonList);
		// 데이터 확인을 위해 객체 생성
		StockNewsVo vo2 = new StockNewsVo();
	
		//ArrayList에 들어온 인덱스 크기만큼 반복문 돔
		for(int i=0; i<jsonList.size(); i++) {

			vo2 = jsonList.get(i);
			int jsonNewsCount = service.getJsonNews(vo2);
			log.info("등록된 데이터 있나?" + jsonNewsCount);
			
			
			if(jsonNewsCount == 0) {
				log.info("뉴스크롤링 데이터가 없습니다 ,등록합니다");
				
//				log.info("뉴스 텔레그램 쏩니다");
//				Newstelgram(vo2);
				
				service.ViNewsRegister(vo2);
			}
			
			if(jsonNewsCount != 0) {
				log.info("시간 업데이트합니다");
				service.jsonNewsUpdate(vo2);
			}
			
		} //end for
	}catch (Exception e) {
			System.out.println("예외발생 기록합니당");
			System.err.println("-----------------------------------");
			System.err.println("예외발생시간 : " + new Date());  // 현재시간출력
			//e.printStackTrace(System.err);
			System.err.println("예외메시지 : " + e.getMessage());
			System.err.println("-----------------------------------");
			//통신실패
			return new ResponseEntity<String>("error",HttpStatus.NOT_FOUND);
		}
		//성공 200코드 발환
		return new ResponseEntity<String>("success", HttpStatus.OK);
	}	
	
	//텔레그램 post
	public static void telgram(StockVo vo) {
		//개인토큰
		String Token = "1562896344:AAHwPvDokCioksBsj8XaFrD3n08fGEGCy2U";
		//채널토큰
		String chanel = "-1001492869181";
		//아이디
		String chat_id = "581572532";
		
		BufferedReader in = null;
		
		try {
			 URL obj = new URL("https://api.telegram.org/bot" + Token + "/sendmessage?chat_id=" + chanel + "&text=번호:" + vo.getIstk_id() + "                                            종목코드:" + vo.getStk_cd() + "                                                   종목명:" + vo.getStk_nm() + "                                          발동가격:" + vo.getStk_pri() + "                                           상승률:" + vo.getStk_inc() + "                                         발동시각:" + vo.getStk_act());
			 
			 HttpURLConnection con = (HttpURLConnection)obj.openConnection();
			 con.setRequestMethod("GET");
			 in = new BufferedReader(new InputStreamReader(con.getInputStream(), "UTF-8"));
			 String line;
			 
			 while((line = in.readLine()) != null) { // response를 차례대로 출력
				 System.out.println(line);
			 }
		}catch (Exception e) {
			e.printStackTrace();
		}finally {
			 if(in != null) try { in.close(); } catch(Exception e) { e.printStackTrace(); }
		}
			 
	}
	
	
//	//텔레그램 post
//		public static void Newstelgram(StockNewsVO vo) {
//			//개인토큰
//			String Token = "1562896344:AAHwPvDokCioksBsj8XaFrD3n08fGEGCy2U";
//			//채널토큰
//			String chanel = "-1001492869181";
//			//아이디
//			String chat_id = "581572532";
//			
//			BufferedReader in = null;
//			
//			try {
//				 URL obj = new URL("https://api.telegram.org/bot" + Token + "/sendmessage?chat_id=" + chat_id + "&text=:"+ vo.getNews_title() +vo.getNews_href());   
//				
//	 			HttpURLConnection con = (HttpURLConnection)obj.openConnection();
//				 con.setRequestMethod("GET");
//				 in = new BufferedReader(new InputStreamReader(con.getInputStream(), "UTF-8"));
//				 String line;
//				 
//				 while((line = in.readLine()) != null) { // response를 차례대로 출력
//					 System.out.println(line);
//				 }
//			}catch (Exception e) {
//				e.printStackTrace();
//			}finally {
//				 if(in != null) try { in.close(); } catch(Exception e) { e.printStackTrace(); }
//			}
//				 
//		}
//	
	
}