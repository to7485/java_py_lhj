package com.korea.product.controller;

import java.util.List;
import java.util.stream.Collectors;

import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.korea.product.dto.ProductDTO;
import com.korea.product.dto.ResponseDTO;
import com.korea.product.model.ProductEntity;
import com.korea.product.service.ProductService;

import lombok.RequiredArgsConstructor;

@RestController
@RequiredArgsConstructor
@RequestMapping("product")
@CrossOrigin(originPatterns = "*", allowCredentials = "false")
public class ProductController {

	private final ProductService p_service;
	
	//조회하기
	@GetMapping
	public ResponseEntity<?> productList(){
		 List<ProductEntity> entites = p_service.findAll();
		 System.out.println(entites);
		return eToDTO(entites);
	}
	
	//사용자가 전달한 데이터를 받아서 db에 저장
	//상품추가하기
	@PostMapping
	public ResponseEntity<?> createProduct(@RequestBody ProductDTO dto){
		//인자로 넘어온 dto를 ProductDTO.toEntity()메서드를 이용해서 ProductEntity 타입으로 변환
		ProductEntity entity = ProductDTO.toEntity(dto);
		//변환한 entity를 service 계층으로 전달
		List<ProductEntity> entites = p_service.create(entity);
		
		//eToDTO메스드를 호출하면서 db에서 가져온 데이터들이 담긴 List를 인자로 전달한다.
		return eToDTO(entites);
		
	}
	
	
	
	
	
	
	
	
	
	
	
	
	
	//db에서 넘어온 데이터들이 들어있는 list를 매개변수로 전달받는다.
	private static ResponseEntity<?> eToDTO(List<ProductEntity> entites){
		//리스트에서 스트림을 생성하고
		List<ProductDTO> dtos = entites.stream()
				//map을 통해서 ProductEntity타입의 데이터들을 ProductDTO타입으로 변경
	 			.map(ProductDTO::new)
	 			//다시 List로 반환받아서 dtos List에 저장
	 			.collect(Collectors.toList());
		
		//ResponseDTO객체를 Builder타입으로 생성해서 List타입의 data필드에 우리가 만든 dtos를 주입한다.
		ResponseDTO<ProductDTO> response = ResponseDTO.<ProductDTO>builder()
											.data(dtos)
											.build();
		//ResponseEntity의 body에 response객체를 전달
		return ResponseEntity.ok().body(response);
	}
	
	
	
	
	
	
	
	
}
