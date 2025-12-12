package com.korea.product.persistence;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.repository.ListPagingAndSortingRepository;
import org.springframework.stereotype.Repository;

import com.korea.product.model.ProductEntity;

// JpaRepository<T, ID> : Spring Data JPA를 사용할 때 Repository
//계층을 개발하는 데 있어 핵심적이고 중요한 인터페이스다.
//상위에 여러개의 인터페이스를 상속받아 JPA 기반의 강력한 기능을 제공한다.
//CrudRepository<T, ID> : CRUD 기본기능을 제공한다.
//ㄴ save(), findAll(), findById(), delete()
//ListPagingAndSortingRepository<T, ID> : 데이터 페이징과 정렬 기능을 추가로 제공한다.

//인터페이스를 상속하면 다른 인터페이스에 있는 추상메서드를 가져다 쓸 수 있다.

@Repository
public interface ProductRepository extends JpaRepository<ProductEntity, Integer>{

	//공통적인 기능은 따로 정의하지 않아도 사용할 수 있다.
	
	//ProductRepository만의 기능이 있다면 추상메서드를 만들어서 사용할 수 있다.
}









