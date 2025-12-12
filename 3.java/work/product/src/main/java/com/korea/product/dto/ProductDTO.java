package com.korea.product.dto;

import java.time.LocalDateTime;

import com.korea.product.model.ProductEntity;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class ProductDTO {

	private int productId; //제품id
	private String productName; //상품명
	private int productStock; //재고
	private int productPrice; //가격
	private LocalDateTime registerDate;
	private LocalDateTime updateDate;
	
	//Entity -> DTO
	public ProductDTO(ProductEntity entity) {
		this.productId = entity.getProductId();
		this.productName = entity.getProductName();
		this.productStock = entity.getProductStock();
		this.productPrice = entity.getProductPrice();
		this.registerDate = entity.getRegisterDate();
		this.updateDate = entity.getUpdateDate();
	}
	
	//DTO -> Entity
	public static ProductEntity toEntity(ProductDTO dto) {
		return ProductEntity.builder()
				.productId(dto.getProductId())
				.productName(dto.getProductName())
				.productStock(dto.getProductStock())
				.productPrice(dto.getProductPrice())
				.registerDate(dto.getRegisterDate())
				.updateDate(dto.getUpdateDate())
				.build();
	}
	
	
	
	
	
	
	
	
}
