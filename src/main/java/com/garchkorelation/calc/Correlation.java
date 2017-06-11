package com.garchkorelation.calc;

import org.apache.commons.math3.stat.correlation.PearsonsCorrelation;

public class Correlation {
	
	public static double correlationCoef(double[] x, double[] y) {
		return new PearsonsCorrelation().correlation(y, x);
	}
	
}
