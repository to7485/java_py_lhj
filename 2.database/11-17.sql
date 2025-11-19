# GRATEST() / LEAST()
# 여러 숫자중 가장 큰 값 / 가장 작은 값을 반환한다.
select 
	GREATEST(10,20,5),
	LEAST(10,20,5);

CREATE TABLE sales (
  id INT PRIMARY KEY,
  product VARCHAR(50),
  price DECIMAL(10,2),
  quantity INT,
  discount_rate DECIMAL(5,2)  -- 할인율(예: 0.15 → 15%)
);

INSERT INTO sales VALUES
(1, 'Keyboard', 29900, 2, 0.10),
(2, 'Mouse',    15900, 3, 0.05),
(3, 'Monitor',  199000, 1, 0.20),
(4, 'USB',       8900, 10, 0.00),
(5, 'Speaker',  45500, 4, 0.15);

# 각 상품의 price 를 3으로 나눈 나머지를 구하시오.
select MOD(PRICE,3) from sales;

# 모든 상품의 discount_rate  를 % 로 표기하기 위해 
# discount_rate * 100 의 값을 소수점 없이 올림 처리하시오
select id,product,price,quantity, concat(ceil(discount_rate*100),'%') discount
from SALES;

# 각 상품의 총 판매 금액(= price × quantity)을 계산하고, 
# 소수점 아래는 전부 버림하여 출력하시오.
select price * quantity from sales;

# 각 상품의 quantity 를 3으로 나누었을 때 몫을 구하시오.
select floor(quantity / 3) from sales;
# 가격을 천 단위로 반올림하여 출력하시오
select price, round(price,-3) from sales;
# 각 상품의 가격의 제곱값을 출력하시오.
select price, power(price,2) from sales;
# 1에서 100 사이의 난수를 생성하시오.
# rand() : 0 ~ 0.9999사이의 난수를 생성
# rand () * 100 -> 0 ~ 99.99
# (rand() * 100) +1 -> 1 ~ 100.99
# floor((rand() * 100) +1) -> 1 ~ 100
select floor(rand()*100)+1 as random_number;

#now() 
#현재 시간을 datetime 형태로 날짜 + 시간으로 돌려준다.
#CURRENT_TIMESTAMP() : NOW()와 같다.
select now();
select CURRENT_TIMESTAMP;

# CURDATE() / CURRENT_DATE
# 오늘 날짜를 반환한다.
select CURDATE();
select CURRENT_DATE;

# CURTIME() / CURRENT_TIME
# 오늘 시간을 반환한다.
select 
	CURTIME(),
	CURRENT_TIME;

# DATE_ADD(날짜,INTERVAL expr unit);
# INTERVAL
# 지금부터 뒤에 오는 시간 단위를 기준으로 날짜를 계산 하겠다.
# INTERVAL 5 DAY -> 5일 이라는 기간
# expr
# 더하거나 빼고싶은 숫자값
# unit
# 기간의 단위를 넣으면 된다.
# DAY 일
# WEEK 주
# MONTH 달
# QUARTER 분기
# YEAR 연도
select
	NOW(),
	DATE_ADD(NOW(), interval 7 day), # 7일 뒤
	DATE_ADD(NOW(), interval 2 MONTH), # 7일 뒤
	DATE_ADD(NOW(), interval 1 QUARTER),
	DATE_ADD(NOW(), interval 1 YEAR); # 7일 뒤

# DATE_SUB()
select
	NOW(),
	DATE_SUB(NOW(), interval 7 day), # 7일 뒤
	DATE_SUB(NOW(), interval 2 MONTH), # 7일 뒤
	DATE_SUB(NOW(), interval 1 QUARTER),
	DATE_SUB(NOW(), interval 1 YEAR); # 7일 뒤

# DATE_DIFF(날짜1, 날짜2);
# 두 날짜의 차이를 일수로 계산을 한다.
# 무조건 날짜1 - 날짜2로 계산이 된다.
select 
	DATEDIFF('2025-11-14','2025-12-14');

# DATE_FORMAT(날짜, 형식)
# 날짜를 문자열로 바꿔서 출력된다.

select
	DATE_FORMAT(NOW(),'%Y-%m-%d'),
	DATE_FORMAT(NOW(),'%Y/%m/%d %H:%i:%s'),
	DATE_FORMAT(NOW(),'%Y년 %m월 %d일');

# 자주 쓰는 포맷 기호
# %Y : 4자리 년도(2025)
# %y : 2자리 년도(25)
# %m : 2자리 월(01 ~ 12)
# %M : 글자로 된 월 (January ~ December)
# %d : 2자리 일(01 ~ 31)
# %H : 24시간 형식의 시간( 00 ~ 23)
# %i : 분(00 ~ 59)
# %s : 초(00 ~ 59)
# %w : 요일 이름(Sunday ~ Saturday)

# STR_TO_DATE(str, format);
select
	STR_TO_DATE('2025-11-17','%Y-%m-%d');

# MAKEDATE(년도, 몇번째 날);
select
	MAKEDATE(2025,365);

# YEAR(), MONTH(), DAY()
select
	NOW(),
	YEAR(NOW()),
	MONTH(NOW()),
	DAY(NOW());

# HOUR(), MINUTE(), SECOND()
select
	NOW(),
	HOUR(NOW()),
	MINUTE(NOW()),
	SECOND(NOW());

# DAYOFWEEK(날짜)
# 요일 : 1(일) ~ 7(토)
select
	DAYOFWEEK(NOW());

#DAYNAME(날짜)
# 요일이름을 반환
select 
	DAYNAME(NOW());

# LAST_DAY(날짜)
# 마지막 날짜 구하기
select
	LAST_DAY(NOW());


CREATE TABLE orders (
    id INT PRIMARY KEY AUTO_INCREMENT, # 주문 번호
    customer VARCHAR(50), # 주문자
    order_date DATE, # 주문날짜
    ship_date DATE, # 도착 날짜
    price INT # 가격
	);

INSERT INTO orders (customer, order_date, ship_date, price) VALUES
('홍길동', '2025-01-02', '2025-01-05', 30000),
('이몽룡', '2025-01-10', '2025-01-12', 45000),
('성춘향', '2024-12-28', '2025-01-03', 52000),
('김철수', '2025-02-01', '2025-02-03', 15000),
('박영희', '2025-02-10', NULL, 22000);  -- 아직 배송되지 않음

# order_date 컬럼에서 연(year),월(month),일(day)을 추출해서 주문자와 함께 조회하시오
select customer, YEAR(order_date),MONTH(order_date),day(order_date)
from orders;

# 배송일까지 걸린 일수를 delivery_day라는 별칭으로 조회하세요
# 단, 조회되지 않은 주문은 제외한다.
select *, datediff(ship_date,order_date) as delivery_day
from orders
where ship_date is not null;

# 2025년 1월의 주문건만 조회하세요
select *
from orders
where year(order_date) = 2025
and month(order_date) = 1;

# 모든 주문의 order_date를 기준으로 7일 후를 배송예정일로 계산하여 조회하세요
# 모든 정보 뒤에 배송예정일 컬럼 처럼 보이도록 작성하세요
select *, date_add(order_date, interval 7 day) as 배송예정일
from orders;

# 작년에 주문된 기록만 조회하세요
select *
from orders
where year(order_date)=2024;

# 주문된날의 요일을 출력하세요
select *,dayname(order_date) from orders;

# 학생 점수를 저장한 score 테이블을 먼저 만들고 데이터를 넣는다.
CREATE TABLE score (
  id INT,
  name VARCHAR(30),
  subject VARCHAR(20),
  point INT
);

INSERT INTO score VALUES
(1, '홍길동', '국어', 85),
(2, '김철수', '영어', 90),
(3, '이영희', '수학', 78),
(4, '박민수', '영어', 92),
(5, '최다혜', '국어', NULL);

# count()
# 값의 개수를 반환하는 함수
# count(*) : null을 포함한 모든 행의 개수
# count(컬럼명) : 해당 컬럼에 null값을 제외한 값이 들어있는 행의 개수

select count(*),count(point),count(name)
from score;

# sum()
# null을 제외한 데이터의 총 합을 구한다.
select sum(point)
from score;

# avg()
# null을 제외한 데이터의 평균을 구해서 반환
select avg(point)
from score;

#max()
#최대값을 구한다.
select name,max(point)
from score;

#min()
#최소값을 구한다.
select min(point)
from score;

# 집계 함수는 select 절에 일반적인 방법으로는 일반 컬럼들과 함께 사용할 수 없다.

CREATE TABLE employee_salary (
  id INT AUTO_INCREMENT PRIMARY KEY, -- 사원번호
  name VARCHAR(50), -- 이름
  department VARCHAR(50), -- 부서
  salary INT, -- 급여
  bonus_rate DECIMAL(4,2),   -- 보너스율(0.1 = 10%)
  hire_date DATE -- 입사날짜
);

INSERT INTO employee_salary (name, department, salary, bonus_rate, hire_date) VALUES
('홍길동', '개발팀', 4200000, 0.10, '2020-02-01'),
('김유신', '개발팀', 3800000, 0.15, '2021-03-15'),
('강감찬', '영업팀', 3500000, 0.08, '2019-07-10'),
('이순신', '영업팀', 5000000, 0.20, '2018-11-20'),
('유관순', '인사팀', 3000000, 0.05, '2022-01-05'),
('장보고', '인사팀', 3100000, 0.07, '2023-03-10'),
('신사임당', '개발팀', 4500000, 0.12, '2017-06-25'),
('정약용', '영업팀', 3900000, 0.15, '2020-09-01');

# 전체 직원수 구하기
select count(*) from employee_salary;

# 전체 직원의 평균 급여 구하기
select avg(salary) from employee_salary;
# 개발팀의 총 급여 구하기
select sum(salary)
from employee_salary
where department='개발팀';

# 5년 이상 근무한 직원들의 수를 구하세요
select count(*)
from employee_salary
where datediff(now(),hire_date) >= 365 * 5;

# GROUP BY
# 데이터를 특정 기준으로 묶어서 요약하는 방법
# 보통 집계함수와 함께 사용이 되는 경우가 많다.

select * from SALES;

CREATE TABLE sales_prod (
    id INT AUTO_INCREMENT PRIMARY KEY,
    category VARCHAR(20),
    amount INT,
    sale_date DATE
);

INSERT INTO sales_prod (category, amount, sale_date) VALUES
('전자제품', 300000, '2025-01-01'),
('전자제품', 250000, '2025-01-03'),
('생활용품', 15000, '2025-02-02'),
('생활용품', 20000, '2025-03-05'),
('식품', 5000, '2025-04-03');

# 카테고리별 매출의 합계 구하기
select category, sum(amount)
from sales_prod
group by category; -- ~별 -> 카테고리별

# 카테고리별 판매 건수
select category, count(*)
from sales_prod
group by category;

# 월별 매출 합계
select month(sale_date), sum(amount)
from sales_prod
group by month(sale_date);


# employee_salary 테이블에서 부서별 평균 급여와 최고 급여를 조회
select department, avg(salary),max(salary)
from employee_salary
group by department;

# 입사 연도별 직원 수
select year(hire_date), count(*)
from employee_salary
group by year(hire_date);

# 이름에 첫 글자별 직원수
select left(name,1), count(*)
from employee_salary
group by left(name,1);

# 가장 최근 입사자
select name, hire_date
from employee_salary
where hire_date = (select MAX(HIRE_DATE) from EMPLOYEE_SALARY);

# 총 판매금액이 50,000원 이상인 카테고리를 조회하기
select CATEGORY, SUM(AMOUNT)
from SALES_PROD
group by category
having SUM(AMOUNT) >= 50000;

# 똑같은 쿼리를 HAVING 대신 WHERE 쓰면 어떻게 될까?
# 에러 발생
select CATEGORY, SUM(AMOUNT)
from SALES_PROD
# where SUM(AMOUNT) >= 50000
group by category
having SUM(AMOUNT) >= 50000;

# 판매가 2번 이상 발생한 카테고리만 조회하기
select CATEGORY, COUNT(*)
from SALES_PROD
group by category 
having COUNT(*) >=2;

select * from SALES_PROD;

# 카테고리별 평균 결제 금액이 100,000이상인것만 조회하기
select CATEGORY, AVG(AMOUNT)
from SALES_PROD
group by category
having AVG(AMOUNT) >= 100000;


# employee_salary 테이블에서 인원이 2명이상인 부서만 조회하세요.
# 부서명과 인원수를 조회해주세요
select department, count(*)
from employee_salary
group by department
having count(department) >= 2;

# 2020년 이후에 입사한 직원들을 대상으로, 부서별 평균 급여가 4,000,000이상인
# 부서만 부서명, 평균급여 조회하기
select department, avg(salary)
from employee_salary
where hire_date >= '2020-01-01' # 부서별로 그룹화를 하기 전에 조건을 실행한다.
group by department
having avg(salary) >= 4000000;

# 전체 평균 금액보다 큰 금액 조회
# 전체 평균 금액이 얼만데?
select  *
from sales_prod
where amount > (select avg(amount)from sales_prod);

# 평균 금액이 20000 이상인 카테고리만 찾고 그 카테고리에 해당하는 행을 조회
# IN() : 여러 값 중 하나라도 같으면 참
select *
from SALES_PROD
where CATEGORY in (select CATEGORY 
					from SALES_PROD 
					group by CATEGORY 
					having AVG(AMOUNT)>= 15000);

select CATEGORY 
from SALES_PROD 
group by CATEGORY 
having AVG(AMOUNT)>= 5000;

# ANY() : 여러 값들 중 하나라도 조건을 만족하면 참
# 전자제품 카테고리의 금액들 중 어느 하나보다라도 큰 AMOUNT를 가진 행을 조회해라
select *
from SALES_PROD
where AMOUNT > ANY(
select AMOUNT
from SALES_PROD
where CATEGORY = '전자제품');

select AMOUNT
from SALES_PROD
where CATEGORY = '전자제품';

# where AMOUNT > ANY(300000, 250000);
# AMOUNT가 30만보다 크거나 25만 보다 크기만 하면 둘 중 하나라도 만족하면 참이다.
# AMOUNT > 30만 OR AMOUNT > 25만

# ALL() : 여러 값들 전부에 대해 조건을 만족해야 참
select *
from SALES_PROD
where AMOUNT > ALL(
select AMOUNT
from SALES_PROD
where CATEGORY = '전자제품');

# AMOUNT > 30만 AND AMOUNT > 25만

# 카테고리별로 금액이 최대인 행만 골라오는 쿼리
select *
from SALES_PROD
where (CATEGORY, AMOUNT) in (select CATEGORY, MAX(AMOUNT) 
								from SALES_PROD 
								group by CATEGORY);

select CATEGORY, MAX(AMOUNT) 
								from SALES_PROD 
								group by CATEGORY;


# (CATEGORY, AMOUNT) in (서브쿼리)
# CATEGORY,AMOUNT 쌍이, 서브쿼리에서 나온 (CATEGORY, MAX(AMOUNT))쌍 중
# 완전히 일치하면 참이다.

# FROM절에서 사용되는 서브쿼리(인라인 뷰)
# SELECT 결과를 가상의 테이블처럼 FROM 절에서 사용한다.
# 복잡한 계산 결과를 다시 조회할 때 유용하다.

select CATEGORY, avg_amount
FROM(
	select CATEGORY,AVG(AMOUNT) as avg_amount
	from SALES_PROD
	group by CATEGORY
) as t;

#sales_prod 테이블 사용하기
# 전체 평균 매출(amount)보다 높은 매출을 조회하세요
select *
from sales_prod
where amount > (select avg(amount) from sales_prod);

select *
from sales_prod
where amount > 118,000;

select avg(amount) from sales_prod; -- 118,000

# employees 테이블에서 가장 늦게 입사한 직원 1명의 정보를 조회하세요

# 가장 늦게 입사한 사람이 누군데? -> 먼저 쿼리로 만들어야 함
select max(hire_date) from employees; 

select * from employees
where hire_date = (select max(hire_date) from employees);

# salaries테이블
# 평균 급여보다 급여를 많이받는 사원들의 정보를 조회





