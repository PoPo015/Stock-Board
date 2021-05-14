package com.stock.service;

import java.util.List;

import com.stock.domain.StockNewsVo;
import com.stock.domain.StockVo;

public interface StockService {

	public int ViListRegister(StockVo vo);
	//뉴스 크롤링데이터 등록
	public int ViNewsRegister(StockNewsVo vo);
	
	public int getJson(StockVo vo);
	
	public int getJson2(StockVo vo);

	public void jsonUpdate(StockVo vo);
	
	//VI NEWS 시간 업데이트
	public void jsonNewsUpdate(StockNewsVo vo);
	
	public int getJsonNews(StockNewsVo vo);
	
	//vi news list 데이터 조회
	public List<StockNewsVo> getNewsList(String test1);
	
	public List<StockVo> getList();
}
