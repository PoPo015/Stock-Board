package com.stock.domain;

import java.util.Date;

import lombok.Data;

@Data
public class NoticesVo {

	private int bno;		//번호
	private String title;	//제목
	private String content;	//내용
	private String writer;	//작성자
	private Date regTime;	//작성시간
	private Date updateTime;//수정시간
	private int viewsCount;	//조회수
	private int likeCount;	//좋아요수
	private int replyCount;	//댓글수
	private String fileName;//파일이름
	
	private int total; //게시물개수
	
}
