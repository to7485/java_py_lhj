package com.korea.product.service;

import java.util.List;
import java.util.Optional;

import org.springframework.stereotype.Service;

import com.korea.product.dto.OrderDTO;
import com.korea.product.dto.ProductDTO;
import com.korea.product.model.OrderEntity;
import com.korea.product.model.ProductEntity;
import com.korea.product.persistence.OrderRepository;
import com.korea.product.persistence.ProductRepository;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class OrderService {

	private final OrderRepository orderRepository;
	private final ProductRepository productRepository;
	
	//주문내역 조회하기
	public List<OrderDTO> getAllOrderTotalPrices(){
		System.out.println("서비스 넘어옴");
		//select한 결과를 List에 담는다.
		List<Object[]> results = orderRepository.findAllOrderTotalPrices();
		//toListOrderDTO():List<Object[]> -> List<OrderDTO>
		return OrderDTO.toListOrderDTO(results);
	}
	
	//주문하기 기능
	public List<ProductDTO> save(OrderDTO dto){
		//productId, productCount;
		
		//1. 상품의 존재 여부를 먼저 확인
		Optional<ProductEntity> option = productRepository.findById(dto.getProductId());
		ProductEntity productEntity;
		if(option.isPresent()) {
			productEntity = option.get();
		} else {
			throw new IllegalArgumentException("상품을 찾을 수 없다");
		}
		
		//재고가 있는지 확인
		if(productEntity.getProductStock() < dto.getProductCount()) {
			throw new RuntimeException("재고가 부족합니다, 현재 재고 : " + productEntity.getProductStock());
		}
		
		//주문하기
		OrderEntity order = OrderEntity.builder()
								.product(productEntity)
								.productCount(dto.getProductCount())
								.build();
		
		orderRepository.save(order);
		
		//재고 감소(productEntity의 재고 - 주문한 개수)
		
		//db에 수정된 재고로 다시 업데이트
		
		//전체 상품목록을 조회해서 반환
		
		
	}
	
	
	
	
	
	
	
	
	
	
}
