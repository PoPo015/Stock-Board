package com.stock.domain;

import java.util.List;

import lombok.Data;

@Data
public class StockNewsVo {
	
	private String news_company;
	private String news_title;
	private String news_time;
	private String news_href;
	
	List<StockNewsVo> news_Data; // 뉴스데이터크롤링
	
}
