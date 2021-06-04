package com.stock.service.impl;

import java.util.regex.Pattern;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.mindrot.jbcrypt.BCrypt;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.stock.domain.UserVo;
import com.stock.mapper.UserMapper;
import com.stock.service.UserService;
import com.stock.util.GetClientIp;

import lombok.extern.log4j.Log4j;

@Log4j
@Service
public class UserServiceImpl implements UserService {
	
	@Autowired
	private UserMapper mapper;
	
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
	public void userCreate(UserVo vo, HttpServletRequest request) {

		String hashPassword = BCrypt.hashpw(vo.getUserPw(), BCrypt.gensalt());		//패스워드 암호화

		vo.setUserIp(GetClientIp.getClientIP(request));
		vo.setUserPw(hashPassword);
		
		
		log.info("회원가입합니다----" + vo);
	
		mapper.userCreate(vo);
		
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

		return mapper.userMyPage(userId);
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

}
