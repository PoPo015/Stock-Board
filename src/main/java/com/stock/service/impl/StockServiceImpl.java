package com.stock.service.impl;


import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.stock.domain.StockNewsVo;
import com.stock.domain.StockVo;
import com.stock.mapper.StockMapper;
import com.stock.service.StockService;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Log4j
@Service
public class StockServiceImpl implements StockService {
	
	@Setter(onMethod_ = @Autowired)
	private StockMapper mapper;
	
	
	@Override
	public int ViListRegister(StockVo vo) {

		log.info("service ------"+vo);
		
		return mapper.ViListRegister(vo);
	}

	@Override
	public int ViNewsRegister(StockNewsVo vo) {

		return mapper.ViNewsRegister(vo);
	}

	//json 중복됬는지 조회
	@Override
	public int getJson(StockVo vo) {

		return	mapper.getJson(vo);
	
	}

	@Override
	public int getJson2(StockVo vo) {
		
		return mapper.getJson2(vo);
	}

	@Override
	public void jsonUpdate(StockVo vo) {

		mapper.jsonUpdate(vo);
	}

	@Override
	public List<StockVo> getList() {

		return mapper.getList();
	
	}

	@Override
	public int getJsonNews(StockNewsVo vo) {
		
		return mapper.getJsonNews(vo);
	
	}

	@Override
	public List<StockNewsVo> getNewsList(String test1) {
		
		return mapper.getNewsList(test1);
	
	}

	@Override
	public void jsonNewsUpdate(StockNewsVo vo) {

		 mapper.jsonNewsUpdate(vo);
	}




}
