package com.stock.domain;

import java.util.Date;

import lombok.Data;

@Data
public class UserVo {
	
	private String userId;				//아이디
	private String userPw;				//패스워드
	private boolean rememberMe;			//로그인유지
	private String newPassword;			//새로운비밀번호
	private String userNm;				//이름
	private String userNick;			//닉네임
	private	String userEmail;			//이메일
 	private String userPhone;			//연락처
	private int addressZipCode;			//우편번호
	private String addressRoadName;		//기본주소
	private String addressDetailed;		//상세주소
	private String userIp;				//유저 ip
	private String proVider;			//회원가입 경로
	private Date userRegWithdrawal; 	//회원탈퇴날짜
	private String idToken; 			//구글 sns 토큰ID
}
