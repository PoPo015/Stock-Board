package com.stock.service.impl;

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
	public int userLogin(UserVo vo) {

//		final String regId = "^[A-Za-z[0-9]]{5,12}$";															//id정규식
//		final String regPw = "^(?=.*[A-Za-z])(?=.*[0-9])(?=.*[$@$!%*#?&])[A-Za-z[0-9]$@$!%*#?&]{5,15}$";		//pw정규식
		
//		if(regId.matches(vo.getUserId()) && regPw.matches(vo.getUserPw())) {

			String hashPassword = BCrypt.hashpw(vo.getUserPw(), BCrypt.gensalt());		//패스워드 암호화
	
			vo.setUserPw(hashPassword);
			
			log.info(mapper.userLogin(vo));
			
			return mapper.userLogin(vo);
//		}
		
//		return 2;
	}

}
