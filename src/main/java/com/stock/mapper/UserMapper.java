package com.stock.mapper;

import com.stock.domain.UserVo;

public interface UserMapper {
	//user id중복체크
	public int userIdCheck(String userId);
	//user email중복체크
	public int EmailCheck(String email);
	//user 회원가입
	public void userCreate(UserVo vo);
	//user 로그인
	public int userLogin(UserVo vo);
	
}
