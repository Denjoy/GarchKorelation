package com.garchkorelation.service;

import java.util.List;

import com.garchkorelation.model.StockName;

public interface StockNameService {

	public void save(StockName stockName);
	
	public void saveAll();
	
	public List<StockName> getAll();
	
	public List<String> getNames();
	
	public List<String> getURLs();
	
	public void clearAll();

}
