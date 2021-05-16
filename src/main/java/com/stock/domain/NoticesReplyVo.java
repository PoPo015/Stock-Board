package com.stock.domain;

import java.util.Date;

import lombok.Data;

@Data
public class NoticesReplyVo {

	private int rno;		//댓글번호
	private int bno;		//게시글번호
	private String reply;	//댓글내용
	private String replyer;	//댓글작성자
	private Date regTime;	//댓글 작성시간
	private Date updateTime;//댓글수정시간
	
}
