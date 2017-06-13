package com.garchkorelation.web;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.garchkorelation.service.StockService;

@Controller
@RequestMapping("/stock")
public class StockController {
	
	@Autowired
	private StockService stockService;
	
	@RequestMapping(value = "", method = RequestMethod.GET)
	public String openStockAll(Model model) {
		model.addAttribute("stockList", stockService.getAll());
		return "stock";
	}
	
	@RequestMapping(value = "/byDate", method = RequestMethod.GET)
	public String openStockByDate(@PathVariable("start_date")String start_date,@PathVariable("end_date")String end_date, Model model) {
		model.addAttribute("stockList", stockService.getAll());
		return "stock";
	}

}
