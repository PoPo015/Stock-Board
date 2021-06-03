package com.stock.service;

import javax.servlet.http.HttpServletRequest;

import com.stock.domain.UserVo;

public interface UserService {
	
	//user,id 중복체크
	public int userIdAndEmailCheck(UserVo vo);
	//user 회원가입
	public void userCreate(UserVo vo,HttpServletRequest request);
	//user 로그인
	public String userLogin(UserVo vo);

}
