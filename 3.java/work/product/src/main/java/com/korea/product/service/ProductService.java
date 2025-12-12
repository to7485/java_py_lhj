package com.korea.product.service;

import java.util.List;

import org.springframework.stereotype.Service;

import com.korea.product.model.ProductEntity;
import com.korea.product.persistence.ProductRepository;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class ProductService {
	
	//ProductRepository 주입하기
	private final ProductRepository p_repository;

	public List<ProductEntity> findAll() {
		return p_repository.findAll();
	}

	

	public List<ProductEntity> create(ProductEntity entity) {
		//entity를 Controller로 부터 전달받아서 영속계층으로 전달하여 db에 저장
		p_repository.save(entity);

		//db에 저장된 모든 내용을 조회하여 반환
		return findAll(); //Service클래스에 있는 findAll()메서드를 호출
		
	}
	
	
	
	
	
	
	
	
	
	
	
	
	

}
