package com.stock.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

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
	//db 패스워드 암호화된거 가져오기
	public String userPwCheck(String userId);
	//user 마이페이지
	public UserVo userMyPage(String userId);
	//user 업데이트
	public void userUpdate(UserVo vo);
	//user pw 변경
	public void userPwChange(@Param("userId")String userId,@Param("newUserPw")String userPw);
	//user 회원탈퇴
	public void realUserWithdrawal(String userId); 
	//user 회원탈퇴날짜
	public UserVo userWithdrawalReg(String userId);
	//user 회원탈퇴 철회
	public void userWithrawalCancel(String userId);
	//user 회원탈퇴 7일지난 리스트
	public List<UserVo> userWithrawalList();
	//user 회원탈퇴처리
	public void userRemove(String userId);
	//kakao 회원가입 
	public void userKakao(UserVo vo);
	//naver 회원가입
	public void userNaver(UserVo vo);
	//google 회원가입
	public void userGoogle(UserVo vo);
	
}
