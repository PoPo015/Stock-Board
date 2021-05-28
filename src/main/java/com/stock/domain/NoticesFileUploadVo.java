package com.stock.domain;

import java.util.Date;

import lombok.Data;

@Data
public class NoticesFileUploadVo {

//	file_bno number(10),                        --파일번호
//	file_notices_bno number(10),                --게시글번호
//	file_original_nm varchar2(100),             --파일오리지널이름
//	file_UUID_nm varchar2(100),                 --파일UUID이름
//	file_upload_reg date default sysdate,       --파일등록시간
//	file_change_reg date,                       --파일변경시간
//	file_size number(10),                         --파일사이즈
//	file_kind varchar2(100),                       --파일종류

	private int fileBno;
	private int fileNoticesBno;
	private String fileOriginalNm;
	private String fileUuidNm;
	private String filePath;
	private Date fileUploadReg;
	private Date fileChangeReg;
	private int fileSize;
	private String fileKind;
	
	private String imgFilePath;					//크롬 보안이슈로 인한 이미지 파일경로지정
	private String filePathDay;					//파일경로 폴더날짜
}
