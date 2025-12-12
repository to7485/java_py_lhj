package com.korea.product.controller;

import java.util.List;

import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.korea.product.dto.OrderDTO;
import com.korea.product.dto.ProductDTO;
import com.korea.product.dto.ResponseDTO;
import com.korea.product.service.OrderService;

import lombok.RequiredArgsConstructor;

@RestController
@RequiredArgsConstructor
@RequestMapping("orders")
@CrossOrigin(originPatterns = "*", allowCredentials = "false")
public class OrderController {

	private final OrderService orderService;
	
	@GetMapping("/total")
	public ResponseEntity<?> getAllOrderTotals(){
		//service 계층에서 전체 데이터를 조회하여 List<OrderDTO>에 대입한다.
		List<OrderDTO> list = orderService.getAllOrderTotalPrices();
		//ResponseDTO의 data필드에 넣는다.
		ResponseDTO<OrderDTO> response = ResponseDTO.<OrderDTO>builder()
													.data(list)
													.build();
		
		//http 코드 200과 함께 body에 응답(response)을 실어서 보낸다.
		System.out.println(response.getData());
		return ResponseEntity.ok().body(response);
	}
	
	@PostMapping
	public ResponseEntity<?> saveOrder(@RequestBody OrderDTO dto){
		List<ProductDTO> list = orderService.save(dto);
	}
}







