package com.garchkorelation.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;

import com.garchkorelation.model.Stock;

public interface StockRepository  extends JpaRepository<Stock, Long> {

}
