package com.garchkorelation.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.garchkorelation.model.Stock;
import com.garchkorelation.repository.StockRepository;
import com.garchkorelation.util.ReadXMLFile;

@Service("stockService")
public class StockServiceImpl implements StockService{

	@Autowired
	StockRepository stockRepository;
	
	@Override
	public void save(Stock stock) {
		stockRepository.save(stock);
	}

	@Override
	public void clearAll() {
		stockRepository.deleteAll();
	}

	@Override
	public List<Stock> getAll() {
		return stockRepository.findAll();
	}

	@Override
	public void saveAll() {
		List<Stock> stockList = ReadXMLFile.load();
		stockList.forEach(stock -> save(stock));
	}
	
}
