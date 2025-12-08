package com.korea.product.controller;

import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RestController;

import com.korea.product.dto.ProductDTO;
import com.korea.product.service.ProductService;

import lombok.RequiredArgsConstructor;

@RestController
@RequiredArgsConstructor
public class ProductController {
	
	private final ProductService service;
	
	@PostMapping("/create")
	public ProductDTO create(@RequestBody ProductDTO dto) {
		return service.createProduct(ProductDTO.toEntity(dto));
	}

}
