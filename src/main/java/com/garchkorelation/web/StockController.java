package com.garchkorelation.web;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.garchkorelation.service.StockService;

@Controller
@RequestMapping("/stock")
public class StockController {
	
	@Autowired
	private StockService stockService;
	
	@RequestMapping(value = "", method = RequestMethod.GET)
	public String openStock(Model model) {
		model.addAttribute("stockList", stockService.getAll());
		return "stock";
	}

}
