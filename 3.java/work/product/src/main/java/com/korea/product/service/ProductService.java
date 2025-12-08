package com.korea.product.service;

import org.springframework.stereotype.Service;

import com.korea.product.dto.ProductDTO;
import com.korea.product.model.ProductEntity;
import com.korea.product.persistence.ProductRepository;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class ProductService {

	private final ProductRepository repository;
	
	public ProductDTO createProduct(ProductEntity entity) {
		
		//했다 쳐
		
		return new ProductDTO(repository.save(entity)); 
	}
}
