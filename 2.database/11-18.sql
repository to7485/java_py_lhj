-- 학생 테이블
CREATE TABLE student (
  id INT PRIMARY KEY,
  name VARCHAR(50)
);

INSERT INTO student (id, name) VALUES
(1, '철수'),
(2, '영희'),
(3, '민수');

-- 수강 테이블
CREATE TABLE enroll (
  id INT PRIMARY KEY,
  student_id INT,
  class_name VARCHAR(50),
  constraint STD_FK foreign KEY(STUDENT_ID)references student(id)
);

INSERT INTO enroll (id, student_id, class_name) VALUES
(1, 1, '데이터베이스'),
(2, 1, '자바'),
(3, 2, '데이터베이스');

drop table ENROLL;

# 1. INNER JOIN
# 각 테이블에서 JOIN 조건에 일치되는 데이터만 가져온다.
select * from STUDENT;
select * from ENROLL;

# 수업을 듣고 있는 학생이름과 수업명을 조회하기
select s.name,e.class_name
from enroll e
join student s
on s.id = e.student_id;

-- 상품 테이블
CREATE TABLE product (
  id INT PRIMARY KEY,
  name VARCHAR(50),
  price INT
);

INSERT INTO product VALUES
(1, '노트북', 1200000),
(2, '스마트폰', 800000),
(3, '키보드', 50000),
(4, '마우스', 30000),
(5, '모니터', 200000);

-- 주문 테이블
CREATE TABLE order_list (
  order_id INT PRIMARY KEY,
  product_id INT,
  quantity INT,
  order_date DATE,
  FOREIGN KEY (product_id) REFERENCES product(id)
);

INSERT INTO order_list VALUES
(101, 1, 1, '2025-01-01'),
(102, 3, 2, '2025-01-02'),
(103, 2, 1, '2025-01-02'),
(104, 5, 3, '2025-01-03'),
(105, 1, 1, '2025-01-04');

select * from product;
select * from order_list;

# 1. 상품이름과 주문 수량을 조회하세요
select p.name, ol.quantity
from product p
join order_list ol
on p.id = ol.product_id;
# 2. 주문된 모든 상품의 상품명, 가격, 주문날짜를 조회하세요
select p.name, ol.quantity,p.price, ol.order_date
from product p
join order_list ol
on p.id = ol.product_id;
# 3. 상품 이름이 '노트북'인 주문의 주문id, 주문 수량, 주문 날자를 조회하세요
select ol.order_id, ol.quantity, order_date
from product p
join order_list ol
on p.id = ol.product_id
where p.name = '노트북';
# 4. 2025년 1월 2일에 주문된 상품들의 상품 이름과 수량을 조회하세요
select p.name, ol.quantity
from product p
join order_list ol
on p.id = ol.product_id
where order_date = '2025-01-02';
# 5. 상품명, 수량, 가격, 주문금액(가격x수량)을 함께 출력해주세요
# select절에서 간단한 연산이 가능하다.
select p.name, ol.quantity, p.price, (p.price * ol.quantity) as 주문금액
from product p
join order_list ol
on p.id = ol.product_id;
# 6. 같은 상품을 2번 이상 주문한 적있는 상품의 상품명과 총 주문 횟수를 출력하세요
select p.name ,count(*)
from product p
join order_list ol
on p.id = ol.product_id
group by p.name
having count(*) >=2;

# LEFT OUTER JOIN
# 왼쪽 테이블(기준)은 조건과 상관없이 조회가 되고, 오른쪽 테이블은 매칭되는 것만
# 조회가 되는 JOIN이다.

# FROM 쪽에 쓰는 테이블이 왼쪽테이블이 된다.
#학생테이블과 수강테이블에서 어떤학생이 어떤과목을 수강하는지 조회
select * from STUDENT;
select * from ENROLL;

select S.name ,E.class_name
from student s 
left outer join enroll e
on S.ID = E.student_id;

# 매칭되는 데이터가 없으면 NULL로 채운다.

# 모든 학생 목록 + 수강내역 -> 수강안하는 사람은 NULL로 표시

# 주문을 한 번도 안한 고객 찾기

# 게시판의 게시글에서 댓글이 없는 게시글 찾기

# 사원 중에서 부서 배치가 안된사람 찾기

# 상품 목록에서 재고가 0인 제품 찾기

# 상품명과 주문 ID를 출력하되, 주문이 없는 상품도 조회해주세요
select p.name, ol.order_id
from product p
left join order_list ol
on p.id = ol.product_id;

# 주문이 한 번도 없는 상품의 모든 내용을 조회해주세요
select p.*,ol.order_date
from product p
left join order_list ol
on p.id = ol.product_id
where ol.order_id is null;

# LEFT OUTER JOIN 상품별 총 주문 수량을 계산하세요
# 상품명, 총 주문수량 조회하기
select P.NAME, IFNULL(SUM(OL.QUANTITY),0)
from product p
left join order_list ol
on p.id = ol.product_id
group by P.NAME;

# IFNULL(컬럼명,대체값);

# RIGHT OUTER JOIN
# 오른쪽 테이블을 기준으로 전부 출력하는 JOIN
# JOIN 쪽에 써지는 테이블

select S.NAME, E.class_name 
from student s 
right join ENROLL E
on S.ID = E.STUDENT_ID;

# CROSS JOIN (모든 경우의수를 다 조회함)

CREATE TABLE color (
  name VARCHAR(20)
);

INSERT INTO color VALUES ('빨강'), ('파랑');

CREATE TABLE size (
  name VARCHAR(20)
);

INSERT INTO size VALUES ('S'), ('M'), ('L');

select * from COLOR;
select * from size;

# 색상과 사이즈의 모든 조합을 만들어보자.
# ON을 따로 작성하지 않아도 된다.
# 모든 행을 무조건 서로 짝짓는다.
select C.NAME, S.NAME
from COLOR C
cross join size S;

# 옵션 조합 만들기
# 색상, 사이즈의 모든 조합을 미리 만들어보고 싶을 때

# 예약시스템에서 예약 가능한 모든 슬롯 만들기
# 날짜 리스트와 시간 리스트 경우의 수를 다 만든다.

# 주의할 점
# A테이블이 1000개 의 행
# B테이블이 5000개의 행
# 1000 x 5000 = 5,000,000개의 행

create table DAYS(
	ID INT primary key,
	DAY_OF_WEEK VARCHAR(10)
);

create table TIME_SLOTS(
	ID INT primary key,
	TIME_SLOT VARCHAR(20)
);

insert into DAYS values
(1,'월'),
(2,'화'),
(3,'수'),
(4,'목'),
(5,'금');

insert into TIME_SLOTS values
(1, '09:00'),
(2, '10:00'),
(3, '11:00'),
(4, '13:00'),
(5, '14:00');

# DAYS 테이블과 TIME_SLOTS 테이블을 CROSS 조인하기
# 월,수, 금 요일만 조회하기
select D.DAY_OF_WEEK, T.TIME_SLOT
from DAYS D
cross join TIME_SLOTS T
where D.DAY_OF_WEEK in('월','수','금');

# SELF JOIN
# 하나의 테이블을 두 번 불러서 서로 JOIN하는 것

#employee라는 이름의 테이블 만들기
# id 정수타입 pk
# name 문자열타입 50바이트
# manager_id 정수타입

create table employee(
	id int primary key,
	name varchar(50),
	manager_id int
);

insert into EMPLOYEE values
(1, '대표',NULL),
(2, '팀장', 1),
(3, '사원A',2),
(4, '사원B',2);

# 사원의 이름과 해당 사원의 상사의 이름을 조회
select E1.NAME as 사원이름 , E2.NAME as 상사
from EMPLOYEE E1
left join EMPLOYEE E2
on E1.MANAGER_ID = E2.ID;

# ON VS WHERE
# JOIN은 반드시 ON으로 관계를 연결해야 한다.

# 수업이 데이터베이스인 수강 이력이 있는 학생만 조회
select S.NAME, E.CLASS_NAME
from STUDENT S
left join enroll e 
on S.ID = E.student_id
where E.class_name ='데이터베이스';

# 모든 학생을 다 보여주되, 수업명은'데이터베이스'가 아니면 NULL
select S.NAME, E.CLASS_NAME
from STUDENT S
left join enroll e 
on S.ID = E.student_id and E.class_name ='데이터베이스';

# 특히 OUTER JOIN을 할 때 ON과 WHERE의 위치에 따라 결과가 달라질 수 있다.

# ON : 조인 조건 -> 어떤 기준으로 두 테이블을 연결할지 정하는 절
# WHERE : 조인이 끝난 뒤 결과에서 필요한 행만 골라내는 필터

select * from EMPLOYEES;
limit 10;

# 직원이름, 부서명을 조회해라
select FIRST_NAME, DEPT_NAME
from EMPLOYEES E
join DEPT_EMP DE
on E.emp_no = DE.emp_no
join departments d
on DE.dept_no = D.dept_no
where DE.TO_DATE = '9999-01-01'; -- 현재를 의미

# 사원의 현재 부서 정보를 조회
select E.emp_no ,E.first_name ,E.last_name ,D.dept_name
from EMPLOYEES E
join DEPT_EMP DE on E.emp_no = DE.emp_no
join departments d on DE.dept_no =D.dept_no
where DE.TO_DATE = '9999-01-01';

# View는 가상의 테이블이다.
/*create VIEW 뷰 이름 AS
 * 	SELECT문
 * */

create view V_EMPLOYEE_DEPT as
select 	E.emp_no ,
		E.first_name ,
		E.last_name ,
		D.dept_name
from EMPLOYEES E
join DEPT_EMP DE on E.emp_no = DE.emp_no
join departments d on DE.dept_no =D.dept_no
where DE.TO_DATE = '9999-01-01';

select * from V_EMPLOYEE_DEPT;
# VIEW로 만든 테이블은 INSERT,UPDATE,DELETE는 안된다.
# 원본테이블이 바뀌면 알아서 같이 수정된다

# 언제 View를 만드는 것이 좋은가
# 1. 복잡한 join과 조건이 반복될 때
# 2. 비즈니스 규칙을 숨겨놓을 때

# employees랑 salaries 테이블을 사용하여
# 사원번호, 이름, 성, 급여순으로 조회
# 급여는 현재 급여만 조회
# view 이름은 v_employee_sal

create view v_employee_sal as
select e.emp_no, e.first_name,e.last_name,s.salary
from employees e
join salaries s 
on e.emp_no = s.emp_no
where s.to_date ='9999-01-01';

# 현재 얼마를 받는지는 알 수 있지만
# 그동안 얼마나 받아왔는지는 알 수 없다.
select * from v_employee_sal;

# 부서별 부서장의 정보 조회하기
create view v_dept_manager as
select d.dept_no,
		d.dept_name,
		e.emp_no,
		e.first_name,
		e.last_name
from dept_manager dm 
join departments d 
on dm.dept_no = d.dept_no
join employees e
on dm.emp_no = e.emp_no
where dm.to_date = '9999-01-01';

select * from v_dept_manager;

# 부서이름이 Marketing인 사람의 모든 정보를 조회하세요

select * from v_dept_manager
where dept_name = 'Marketing';

# V_EMPLOYEE_DEPT와 v_employee_sal를 join하여
# 사번, 이름, 부서명, 급여를 모두 조회하는 새로운 뷰를 만든다.
# 뷰 이름은 v_emp_dept_salary
# 뷰를 이용해 부서명이 'Development'인 사원의 사번, 이름, 급여를
# 조회하는 select 작성하기

create view v_emp_dept_salary as
select d.emp_no,
		d.first_name,
		d.last_name,
		d.dept_name,
		s.salary
from V_EMPLOYEE_DEPT d
join v_employee_sal s
on d.emp_no = s.emp_no;

select * from v_emp_dept_salary;

select emp_no, first_name, last_name, salary
from v_emp_dept_salary
where dept_name='Development';

# 현재를 기준으로 부서별 사원 수를 집계하는 뷰 만들기
# 사용 테이블은 dept_emp, departments
# 뷰 이름은 v_dept_emp_count
# 이 뷰를 이용해 사원 수가 200명 이상인 부서만 부서명, 인원수를 조회하시오.

create view V_DEPT_EMP_COUNT as
select D.DEPT_NAME,
		COUNT(*) as EMP_COUNT
from DEPARTMENTS D
join DEPT_EMP DE on D.DEPT_NO = DE.DEPT_NO
where DE.TO_DATE = '9999-01-01'
group by D.DEPT_NAME;

select * from V_DEPT_EMP_COUNT
where EMP_COUNT >= 20000;







