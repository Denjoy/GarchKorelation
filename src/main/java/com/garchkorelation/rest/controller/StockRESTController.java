package com.garchkorelation.rest.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.ResponseStatus;
import org.springframework.web.bind.annotation.RestController;

import com.garchkorelation.bean.ChartBean;
import com.garchkorelation.calc.Correlation;
import com.garchkorelation.service.StockService;

@RestController
@RequestMapping(path = { "/rest" })
public class StockRESTController {

	@Autowired
	private StockService stockService;

	@RequestMapping(path = "/refreshDB")
	@ResponseStatus(value = HttpStatus.OK)
	public void resfreshDB() {
		stockService.clearAll();
		stockService.saveAll();
	}

	@RequestMapping(path = { "/test" }, method = RequestMethod.GET)
	@ResponseStatus(value = HttpStatus.OK)
	public void test() {
		System.out.println(Correlation.correlationCoef(stockService.getAll()));

	}

	@RequestMapping(path = { "/getChart" }, method = RequestMethod.GET)
	@ResponseBody
	public List<ChartBean> getChart() {
		return stockService.getChart();
	}

}
