package com.stock.domain;

import java.util.Date;

import lombok.Data;

@Data
public class NoticesLikeAndDislike {

	private String userId;	//유저아이디
	
	private int bno;		//게시글번호
	
	private boolean checkLikeAndDislike;	
	
	private Date LikeAndDislikeReg;
	
	
}
