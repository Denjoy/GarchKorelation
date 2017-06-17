package com.garchkorelation.util;

import java.util.ArrayList;
import java.util.List;

import org.openqa.selenium.By;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.WebElement;
import org.openqa.selenium.chrome.ChromeDriver;

import com.garchkorelation.model.StockName;

import io.github.bonigarcia.wdm.ChromeDriverManager;

public class ParseUtil {

	public static List<StockName> getStockNames() {
		ChromeDriverManager.getInstance().setup();
		WebDriver driver = new ChromeDriver();
		driver.get(StaticVar.STOCK_NAMES_URL);
		List<WebElement> elementsList = driver.findElements(By.xpath("//tr/td/a"));
		List<StockName> stockNameList = new ArrayList<StockName>();
		boolean i = false;
		for (WebElement element : elementsList) {
			if (i) {
				stockNameList.add(new StockName(element.getAttribute("href"), element.getText()));
				i = false;
				continue;
			}
			i = true;
		}
		return stockNameList;

	}
	
	public static String getUrl(String start, String end, String stockName) {
		return "http://investfunds.ua/markets/stocks/"+stockName +"/quotes/?f_s[sdate]="+TimeUtil.convertDateFormat(start)+"&f_s[edate]="+TimeUtil.convertDateFormat(end)+"&get_xml";
	}

}
