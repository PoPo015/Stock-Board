package com.stock.service.impl;

import java.io.IOException;
import java.security.GeneralSecurityException;
import java.util.Collections;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;
import java.util.regex.Pattern;

import javax.mail.internet.MimeMessage;
import javax.servlet.http.HttpServletRequest;

import org.mindrot.jbcrypt.BCrypt;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Service;

import com.google.api.client.googleapis.auth.oauth2.GoogleIdToken;
import com.google.api.client.googleapis.auth.oauth2.GoogleIdToken.Payload;
import com.google.api.client.googleapis.auth.oauth2.GoogleIdTokenVerifier;
import com.google.api.client.http.javanet.NetHttpTransport;
import com.google.api.client.json.jackson2.JacksonFactory;
import com.google.gson.JsonObject;
import com.google.gson.JsonParser;
import com.stock.domain.UserVo;
import com.stock.mapper.UserMapper;
import com.stock.service.UserService;
import com.stock.util.GetClientIp;
import com.stock.util.NaverLogin;

import lombok.extern.log4j.Log4j;

@Log4j
@Service
public class UserServiceImpl implements UserService {
	
	@Autowired
	private UserMapper mapper;

	@Autowired
	private JavaMailSender mailSender;
	
	@Override
	public int userIdAndEmailCheck(UserVo vo) {
	
		if(vo.getUserId() != null) {
			log.info("아이디 값 있다");
			return mapper.userIdCheck(vo.getUserId());
		}else if(vo.getUserEmail() != null) {
			log.info("이메일 값있다");
			return mapper.EmailCheck(vo.getUserEmail());
		}

		return 1;
		
	}
	
	@Override
	public String userCreate(UserVo vo, HttpServletRequest request) {

		String regId = "^[a-zA-Z0-9]{5,11}$";											//영문,숫자 5~11 미만 정규식
		String regPw = "^(?=.*\\d)(?=.*[~`!@#$%\\^&*()-])(?=.*[a-zA-Z]).{8,12}$";		//정규식 (영문, 숫자, 특수문자 조합, 9~12자리)
		
		if(Pattern.matches(regId, vo.getUserId()) && Pattern.matches(regPw, vo.getUserPw())) {
			String hashPassword = BCrypt.hashpw(vo.getUserPw(), BCrypt.gensalt());		//패스워드 암호화
	
			vo.setUserIp(GetClientIp.getClientIP(request));
			vo.setUserPw(hashPassword);
			
			
			log.info("회원가입합니다----" + vo);
		
			mapper.userCreate(vo);
			return "success";
		}
		
		log.info("비정상적인 회원가입");
		return "error";
	}

	@Override
	public String userLogin(UserVo vo) {
		
		String regId = "^[a-zA-Z0-9]{5,11}$";											//영문,숫자 5~11 미만 정규식
		String regPw = "^(?=.*\\d)(?=.*[~`!@#$%\\^&*()-])(?=.*[a-zA-Z]).{8,12}$";		//정규식 (영문, 숫자, 특수문자 조합, 9~12자리)
		String hashPwCheck = mapper.userPwCheck(vo.getUserId());						//유저 hash pw값 반환
		
		log.info("regId----" + Pattern.matches(regId, vo.getUserId()));
		log.info("regPw----" + Pattern.matches(regPw, vo.getUserPw()));
		log.info("hashPwCheck----"+ hashPwCheck);
		
		
		if(Pattern.matches(regId, vo.getUserId()) && Pattern.matches(regPw, vo.getUserPw()) && hashPwCheck != null) {
			
			log.info("pwcheck---" + hashPwCheck);
			log.info("BcrCheck--" + BCrypt.checkpw(vo.getUserPw(), hashPwCheck));	
			
			if(BCrypt.checkpw(vo.getUserPw(), hashPwCheck)) {							//아이디와 pw가 일치시
				return "로그인 성공";
			}

		}
		
		return "로그인 실패";

	}

	@Override
	public UserVo userMyPage(String userId) {

		UserVo vo = mapper.userWithdrawalReg(userId);								//회원탈퇴 했는지 확인

		if(vo != null) {
			log.info("vo (회원탈퇴값이 있어용)");
			return vo;
		}else {
			log.info("회원탈퇴값이 없어요");
			return mapper.userMyPage(userId);
		}
		
		
	}

	@Override
	public String userUpdate(UserVo vo, String userId) {
		
		
		if(vo.getUserId().equals(userId)) {
			log.info("세션계정과 Id계정이 일치함");
			try {
				mapper.userUpdate(vo);												//비정상적인값 입력시 예외처리
			}catch (Exception e) {
				e.printStackTrace();
				return "정보수정실패";
			}
			return "정보수정성공";
		}else {
			log.info("세션계정과 Id계정이 틀림");
			return "정보수정실패";
		}
			
		
		
	}

	@Override
	public String userPwChange(UserVo vo) {
		
		String regPw = "^(?=.*\\d)(?=.*[~`!@#$%\\^&*()-])(?=.*[a-zA-Z]).{8,12}$";		//정규식 (영문, 숫자, 특수문자 조합, 9~12자리)
		String hashPwCheck = mapper.userPwCheck(vo.getUserId());						//해당 user hash 비밀번호를 가져옴
		String hashPassword = BCrypt.hashpw(vo.getNewPassword(), BCrypt.gensalt());		//패스워드 암호화

		log.info("서비스 vo--" + vo);
		
		log.info("hashPw---" + hashPwCheck);
		log.info("hashnew---" + hashPassword);
		if(Pattern.matches(regPw, vo.getUserPw()) && hashPwCheck != null && Pattern.matches(regPw, vo.getNewPassword())) {
			
			log.info("pwcheck---" + hashPwCheck);
			log.info("BcrCheck--" + BCrypt.checkpw(vo.getUserPw(), hashPwCheck));	
			
			if(BCrypt.checkpw(vo.getNewPassword(), hashPwCheck)) {
				log.info("현재 비밀번호와 동일합니다. 다른비밀번호로 설정하세요");
				return "비밀번호 동일 실패";
			}
			
			if(BCrypt.checkpw(vo.getUserPw(), hashPwCheck)) {							//아이디와 pw가 일치시
					log.info("아이디와 pw가 일치합니다. 비밀번호 수정 합니다.");
					mapper.userPwChange(vo.getUserId(), hashPassword);
					return "비밀번호 수정 성공";
			}else {
					log.info("아이디와 pw가 일치하지않습니다.비밀번호 수정 실패.");
					return "비밀번호 수정 실패";
			}
		}
		log.info("비밀번호가 null이거나 , 정규식패턴에 맞지않음");
		return "비밀번호 수정 실패";

	}

	@Override
	public String realUserWithdrawal(UserVo vo) {

		String regPw = "^(?=.*\\d)(?=.*[~`!@#$%\\^&*()-])(?=.*[a-zA-Z]).{8,12}$";		//정규식 (영문, 숫자, 특수문자 조합, 9~12자리)
		String hashPwCheck = mapper.userPwCheck(vo.getUserId());						//해당 user hash 비밀번호를 가져옴
		
		if(Pattern.matches(regPw, vo.getUserPw())) {
			
			if(BCrypt.checkpw(vo.getUserPw(), hashPwCheck)) {							//아이디와 pw가 일치시
				log.info("아이디와 pw가 일치합니다. 회원탈퇴 합니다.");
				mapper.realUserWithdrawal(vo.getUserId());
				return "success";
			}
			
		}
		log.info("아이디와 pw가 일치하지않습니다.");
		return "error";
	}

	@Override
	public String userWithrawalCancel(UserVo vo) {

		String regPw = "^(?=.*\\d)(?=.*[~`!@#$%\\^&*()-])(?=.*[a-zA-Z]).{8,12}$";		//정규식 (영문, 숫자, 특수문자 조합, 9~12자리)
		String hashPwCheck = mapper.userPwCheck(vo.getUserId());						//해당 user hash 비밀번호를 가져옴
		
		log.info("회원탈퇴 철회---" + vo);

		if(Pattern.matches(regPw, vo.getUserPw())) {
			
			if(BCrypt.checkpw(vo.getUserPw(), hashPwCheck)) {							//아이디와 pw가 일치시
				log.info("아이디와 pw가 일치합니다. 회원탈퇴를 철회 합니다.");
				mapper.userWithrawalCancel(vo.getUserId());
				return "success";
			}
			
		}
		return "error";
		
	}

	@Override
	public String userKakao(UserVo vo) {

		int userIdCheck = mapper.userIdCheck(vo.getUserId());
		vo.setUserNick("(kakao)"+vo.getUserNick());
		
		if(userIdCheck == 0) {
			log.info("카카오 계정이없습니다. 카카오 회원가입합니다.");
			vo.setProVider("kakao");
			mapper.userKakao(vo);
			return "kakaoSuccess";
		}else if(userIdCheck == 1) {
			log.info("카카오계정이 이미 있습니다. 로그인만합니다");
			return "kakaoLogin";
		}
	
		
		return "kakaoError";
	}

	@Override
	public UserVo userNaver(String accessToken) {

			String token = accessToken; // 네이버 로그인 접근 토큰;
	        String header = "Bearer " + token; // Bearer 다음에 공백 추가
	        String apiURL = "https://openapi.naver.com/v1/nid/me";
	        UserVo vo = new UserVo();
	        Map<String, String> requestHeaders = new HashMap<>();
	        requestHeaders.put("Authorization", header);
	        String responseBody = NaverLogin.get(apiURL,requestHeaders);
	        
	        System.out.println(responseBody);
	        
	        JsonParser jParser = new JsonParser();
	        JsonObject jObject = (JsonObject) jParser.parse(responseBody);
	        log.info("object----" + jObject);
	        
	        JsonObject response = (JsonObject)jObject.get("response");
	        //네이버는 "아이디값" 이런식으로 뽑혀져서 문자열 자르기함
	        String userId = ((String)response.get("id").toString().substring(1,response.get("id").toString().length()-1));
	        log.info("userId---" + userId);
	        String userNick = ("(naver)" + (String)response.get("nickname").toString().substring(1,response.get("nickname").toString().length()-1));
	        log.info("userNick---" + userNick);
 	        String userEmail = ((String)response.get("email").toString().substring(1,response.get("email").toString().length()-1));
 	        log.info("userEmail---" + userEmail);
	        String userPhone = (String)response.get("mobile").toString().substring(1,response.get("mobile").toString().length()-1);
	        log.info("userPhone---" + userPhone);
	        String UserNm = (String)response.get("name").toString().substring(1,response.get("name").toString().length()-1);
	        log.info("setUserNm---" + UserNm);
	       
	        vo.setUserId(userId);
	        vo.setUserNick(userNick);
	        vo.setUserEmail(userEmail);
	        vo.setUserPhone(userPhone);
	        vo.setUserNm(UserNm);
	        vo.setProVider("naver");
	        log.info("vo --" + vo);
	        
	        
	        int userIdCheck = mapper.userIdCheck(vo.getUserId());
		        if(userIdCheck == 0) {
		        	log.info("계정이 없습니다. 회원가입 합니다.");
		        	mapper.userKakao(vo);
		        }else {
		        	log.info("계정이 있습니다. 로그인합니다.");
		        }
	        
	        return vo;
	}

	@Override
	public UserVo userGoogle(String accessToken) throws GeneralSecurityException, IOException {
		log.info("access--" + accessToken);
		UserVo vo = new UserVo();
		GoogleIdTokenVerifier verifier = new GoogleIdTokenVerifier.Builder(new NetHttpTransport(), new JacksonFactory())
			    // Specify the CLIENT_ID of the app that accesses the backend:
			    .setAudience(Collections.singletonList("821344491779-sgqahrsao6njue7ahrhl4b4daauraeor.apps.googleusercontent.com"))
			    // Or, if multiple clients access the backend:
			    //.setAudience(Arrays.asList(CLIENT_ID_1, CLIENT_ID_2, CLIENT_ID_3))
			    .build();

			// (Receive idTokenString by HTTPS POST)

			GoogleIdToken idToken = verifier.verify(accessToken);
			if (idToken != null) {
			  Payload payload = idToken.getPayload();

			  // Print user identifier
			  String userId = payload.getSubject();
			  System.out.println("User ID: " + userId);

			  // Get profile information from payload
			  String email = payload.getEmail();
//			  boolean emailVerified = Boolean.valueOf(payload.getEmailVerified());
			  String name = (String) payload.get("name");
//			  String pictureUrl = (String) payload.get("picture");
//			  String locale = (String) payload.get("locale");
//			  String familyName = (String) payload.get("family_name");
//			  String givenName = (String) payload.get("given_name");
			  int userIdCheck = mapper.userIdCheck(userId);
			  	if(userIdCheck == 0) {
			  		log.info("구글 계정이없습니다 회원가입합니다.");
			  		vo.setUserId(userId);
			  		vo.setUserEmail(email);
			  		vo.setUserNm(name);
			  		vo.setUserNick("(google)" + name);
			  		vo.setProVider("google");
			  		mapper.userGoogle(vo);
			  	}else {
			  		vo.setUserNick("(google)" + name);
			  	}
			} else {
			  System.out.println("Invalid ID token.");
			}
		return vo;
	}

	@Override
	public void keepLogin(String userId, String sessionId, Date sessionLimit) {
		log.info("userId---" + userId);
		log.info("sessionId---" + sessionId);
		log.info("sessionLimit---" + sessionLimit);
		
		HashMap<String, Object> sessionCookie = new HashMap<String, Object>();
		sessionCookie.put("userId", userId);
		sessionCookie.put("sessionId",sessionId);
		sessionCookie.put("sessionLimit", sessionLimit);
		mapper.keepLogin(sessionCookie);
	}

	@Override
	public UserVo checkLoginBefore(String cookieValue) {
		return mapper.checkLoginBefore(cookieValue);
	}

	@Override
	public String userFindIdPost(UserVo vo) throws Exception {
		//유저 아이디 이메일 있는지 체크.
		int checkCnt = mapper.userNameAndEmailCheck(vo);
			
			if(checkCnt == 1) {
				log.info("유저 아이디와 이메일이 일치하는게 있다. 이메일 인증번호 생성을하고, return 합시다~");
				
				String subject = "test 메일";
				String content = "메일 테스트 내용" + "<img src=\"https://t1.daumcdn.net/cfile/tistory/214DCD42594CC40625\">";
				String from = "kst005103@gmail.com";
		        String to = vo.getUserEmail();
		        
		        try {
		            MimeMessage mail = mailSender.createMimeMessage();
		            MimeMessageHelper mailHelper = new MimeMessageHelper(mail,true,"UTF-8");
		            // true는 멀티파트 메세지를 사용하겠다는 의미
		            
		            /*
		             * 단순한 텍스트 메세지만 사용시엔 아래의 코드도 사용 가능 
		             * MimeMessageHelper mailHelper = new MimeMessageHelper(mail,"UTF-8");
		             */
		            
		            mailHelper.setFrom(from);
		            // 빈에 아이디 설정한 것은 단순히 smtp 인증을 받기 위해 사용 따라서 보내는이(setFrom())반드시 필요
		            // 보내는이와 메일주소를 수신하는이가 볼때 모두 표기 되게 원하신다면 아래의 코드를 사용하시면 됩니다.
		            //mailHelper.setFrom("보내는이 이름 <보내는이 아이디@도메인주소>");
		            mailHelper.setTo(to);
		            mailHelper.setSubject(subject);
		            mailHelper.setText(content, true);
		            // true는 html을 사용하겠다는 의미입니다.
		            
		            /*
		             * 단순한 텍스트만 사용하신다면 다음의 코드를 사용하셔도 됩니다. mailHelper.setText(content);
		             */
		            
		            mailSender.send(mail);
		            
		        } catch(Exception e) {
		            e.printStackTrace();
		        }
				
				return "success";
			}
		
		
		return "error";
	}

}
