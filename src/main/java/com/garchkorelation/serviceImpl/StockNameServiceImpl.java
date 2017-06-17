package com.garchkorelation.serviceImpl;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.garchkorelation.model.StockName;
import com.garchkorelation.repository.StockNameRepository;
import com.garchkorelation.service.StockNameService;
import com.garchkorelation.util.ParseUtil;


@Service("stockNameService")
public class StockNameServiceImpl implements StockNameService{
	
	@Autowired
	private StockNameRepository stockNameRepository;

	@Override
	public void save(StockName stockName) {
		stockNameRepository.save(stockName);
		
	}

	@Override
	public void saveAll() {
		for(StockName stockName : ParseUtil.getStockNames()) {
			stockNameRepository.save(stockName);
		}
	}

	@Override
	public void clearAll() {
		stockNameRepository.deleteAll();
	}

	@Override
	public List<StockName> getAll() {
		return stockNameRepository.findAll();
	}

	@Override
	public List<String> getNames() {
		List<String> nameList = new ArrayList<String>();
		for(StockName stockName : getAll()) {
			nameList.add(stockName.getName());
		}
		return nameList;
	}

	@Override
	public List<String> getURLs() {
		List<String> urlList = new ArrayList<String>();
		for(StockName stockName : getAll()) {
			urlList.add(stockName.getUrlName());
		}
		return urlList;
	}

}
