package com.garchkorelation.serviceImpl;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.garchkorelation.bean.ChartBean;
import com.garchkorelation.model.Stock;
import com.garchkorelation.repository.StockRepository;
import com.garchkorelation.service.StockService;
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

	@Override
	public List<ChartBean> getChart() {
		List<ChartBean> chartList = new ArrayList<ChartBean>();
		for(Stock stock: getAll()) {
			chartList.add(new ChartBean(stock.getDate(), stock.getAsk()));
		}
		return chartList;
	}

	@Override
	public List<ChartBean> getChartByBean() {
//		TODO: JUST DO IT!
		return null;
	}
	
}
