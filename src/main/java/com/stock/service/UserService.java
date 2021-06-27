package com.stock.service;

import java.io.IOException;
import java.security.GeneralSecurityException;
import java.util.Date;

import javax.servlet.http.HttpServletRequest;

import com.stock.domain.UserVo;

public interface UserService {
	
	//user,id 중복체크
	public int userIdAndEmailCheck(UserVo vo);
	//user 회원가입
	public String userCreate(UserVo vo,HttpServletRequest request);
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
	//카카오 로그인
	public String userKakao(UserVo vo);
	//구글 로그인
	public UserVo userNaver(String accessToken);
	//네이버 로그인
	public UserVo userGoogle(String accessToken) throws GeneralSecurityException, IOException;
	//자동로그인 쿠키 업데이트
	public void keepLogin(String userId, String sessionId, Date sessionLimit);
	//쿠키값이 있는 지확인
	public UserVo checkLoginBefore(String cookieValue);
	//유저아이디 찾기
	public String userFindIdPost(UserVo vo) throws Exception;
	//유저아이디 찾기
	public String userFindPwPost(UserVo vo) throws Exception;
	
	public String usermailCertification(UserVo vo);
	
	//user 비밀번호 변경
	public String userFindPwChange(UserVo vo);
}
