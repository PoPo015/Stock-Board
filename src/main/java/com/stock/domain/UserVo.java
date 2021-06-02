package com.stock.domain;

import lombok.Data;

@Data
public class UserVo {
	
	private String userId;				//아이디
	private String userPw;				//패스워드
	private String userNm;				//이름
	private	String userEmail;			//이메일
 	private String userPhone;			//연락처
	private int addressZipCode;			//우편번호
	private String addressRoadName;		//기본주소
	private String addressDetailed;		//상세주소
	private String userIp;				//유저 ip

	private boolean certification; //서버에서 검증할 변수
	
}
