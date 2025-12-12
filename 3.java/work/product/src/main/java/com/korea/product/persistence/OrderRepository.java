package com.korea.product.persistence;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import com.korea.product.model.OrderEntity;

@Repository
public interface OrderRepository extends JpaRepository<OrderEntity, Integer>{
	//JPQL
	//JPA에서 제공하는 쿼리를 실행하기 위해 정의된 객체 지향 쿼리 언어
	//묵시적 조인
	//OrderEntity와 ProductEntity가 @ManyToOne으로 관계가 이미 설정되어 있기 때문에
	//관계 필드(o.product)를 점으로 연결하여 바로 접근할 수 있다.
	@Query("SELECT "
			+ "o.orderId, "
			+ "o.product.productName, "
			+ "o.productCount, "
			+ "o.product.productPrice, "
			+ "(o.productCount * o.product.productPrice) AS totalPrice, "
			+ "o.orderDate "
			+ "FROM OrderEntity o")
	List<Object[]> findAllOrderTotalPrices();
	
	//조회된 결과의 하나의 행이 배열의 요소로 들어가기 때문에 제네릭을 Object[]로 설정
}









