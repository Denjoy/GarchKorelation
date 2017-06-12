package com.garchkorelation.rest.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseStatus;
import org.springframework.web.bind.annotation.RestController;

import com.garchkorelation.calc.Correlation;
import com.garchkorelation.service.StockService;

@RestController
public class ExtraRest {

	@Autowired
	private StockService stockService;
	
	@RequestMapping(path = { "/test" }, method = RequestMethod.GET)
	@ResponseStatus (value = HttpStatus.OK)
	public void test() {
		System.out.println(Correlation.correlationCoef(stockService.getAll()));
//		stockService.clearAll();
//		stockService.saveAll();
	}
}
