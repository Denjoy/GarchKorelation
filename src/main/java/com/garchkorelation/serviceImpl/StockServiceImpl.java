package com.garchkorelation.serviceImpl;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.garchkorelation.bean.ChartBean;
import com.garchkorelation.model.Stock;
import com.garchkorelation.repository.StockRepository;
import com.garchkorelation.service.StockService;
import com.garchkorelation.util.ParseUtil;
import com.garchkorelation.util.ReadXMLFile;
import com.garchkorelation.util.TimeUtil;

@Service("stockService")
public class StockServiceImpl implements StockService {

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
	public List<Stock> getByDate(String start, String end) {
		List<Stock> stockList = new ArrayList<Stock>();
		for (Stock stock : getAll()) {
			if (TimeUtil.isBetweenDates(stock.getDate(), start, end))
				stockList.add(stock);
		}
		return stockList;
	}

	@Override
	public void saveAll(String urlString) {
		List<Stock> stockList = ReadXMLFile.load(urlString);
		stockList.forEach(stock -> save(stock));
	}

	@Override
	public List<ChartBean> getChart() {
		return stockListToChartBeanList(getAll());
	}

	@Override
	public List<ChartBean> getChartByDate(String start, String end) {
		List<ChartBean> chartList = new ArrayList<ChartBean>();
		for (Stock stock : getByDate(start, end)) {
			chartList.add(new ChartBean(stock.getDate(), stock.getAsk()));
		}

		return chartList;
	}

	private List<ChartBean> stockListToChartBeanList(List<Stock> stockList) {
		List<ChartBean> chartList = new ArrayList<ChartBean>();
		for (Stock stock : stockList) {
			chartList.add(new ChartBean(stock.getDate(), stock.getAsk()));
		}
		return chartList;
	}

	@Override
	public void fillDB(String start, String end, String stockName) {
		System.out.println("start fill DB");
		saveAll(ParseUtil.getUrl(start, end, stockName));
		System.out.println("DONE!!!!");
	}

}
