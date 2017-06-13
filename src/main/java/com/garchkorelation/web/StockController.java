package com.garchkorelation.web;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

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
	public String openStockByDate(@RequestParam("start")String start,@RequestParam("end")String end, Model model) {
		model.addAttribute("stockList", stockService.getByDate(start, end));
		return "stock";
	}
	
	@RequestMapping(value = "/header", method = RequestMethod.GET)
	public String header() {
		return "header";
	}
	
	@RequestMapping(value = "/footer", method = RequestMethod.GET)
	public String footer() {
		return "footer";
	}

}
