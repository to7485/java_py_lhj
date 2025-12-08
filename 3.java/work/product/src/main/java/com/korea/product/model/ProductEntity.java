package com.korea.product.model;

import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Entity
@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
@Table(name="product")
public class ProductEntity {

	@Id
	@GeneratedValue
	private int id;
	private String name;
	private int price;
	private int stock;
	private String description;
	
	
	
	
	
	
	
	
	
	
	
}
