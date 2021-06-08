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
	//user 마이페이지
	public UserVo userMyPage(String userId);
	//user 업데이트
	public String userUpdate(UserVo vo, String userId);
	//user 비밀번호 변경
	public String userPwChange(UserVo vo);
	//user 회원탈퇴
	public String realUserWithdrawal(UserVo vo); 
	//user 회원탈퇴 철회
	public String userWithrawalCancel(UserVo vo);
}
