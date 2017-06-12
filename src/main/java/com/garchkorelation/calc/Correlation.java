package com.garchkorelation.calc;

import java.util.List;

import org.apache.commons.math3.stat.correlation.PearsonsCorrelation;

import com.garchkorelation.model.Stock;

public class Correlation {

	public static double correlationCoef(List<Stock> stockList) {
		double[] x = new double[stockList.size()];
		double[] y = new double[stockList.size()];
		int i = 0;
		for (Stock stock : stockList) {
			x[i] = stock.getAsk();
			y[i] = stock.getBid();

			++i;
		}

		return new PearsonsCorrelation().correlation(x, y);
	}

}
