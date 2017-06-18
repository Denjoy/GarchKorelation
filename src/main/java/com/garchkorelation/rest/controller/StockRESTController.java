package com.garchkorelation.rest.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.ResponseStatus;
import org.springframework.web.bind.annotation.RestController;

import com.garchkorelation.bean.ChartBean;
import com.garchkorelation.service.StockNameService;
import com.garchkorelation.service.StockService;

@RestController
@RequestMapping(path = { "/rest" })
public class StockRESTController {

	@Autowired
	private StockService stockService;

	@Autowired
	private StockNameService stockNameService;

	@RequestMapping(path = "/refreshStockNames", method = RequestMethod.GET)
	@ResponseStatus(value = HttpStatus.OK)
	public void refreshStockNames() {
		stockNameService.clearAll();
		stockNameService.saveAll();
	}

	@RequestMapping(path = { "/getChart" }, method = RequestMethod.GET)
	@ResponseBody
	public List<ChartBean> getChart() {
		return stockService.getChart();
	}

	@RequestMapping(path = { "/getChartByDate" }, method = RequestMethod.GET)
	@ResponseBody
	public List<ChartBean> getChartByDate(@RequestParam("start") String start, @RequestParam("end") String end, Model model) {
		return stockService.getChartByDate(start, end);
	}
	
	@RequestMapping(path = { "/getChartPrediction" }, method = RequestMethod.GET)
	@ResponseBody
	public List<ChartBean> getChartPrediction(@RequestParam("start") String start, @RequestParam("end") String end, @RequestParam("predictSize") int predictSize, Model model) {
		return stockService.getChartPrediction(start, end, predictSize);
	}
	
	
	

}
