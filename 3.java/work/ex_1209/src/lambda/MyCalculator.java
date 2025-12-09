package lambda;

//함수형 인터페이스로 사용하기 위해서는 인터페이스에 무조건 하나의 추상메서드만 존재해야 한다.
@FunctionalInterface
public interface MyCalculator {

	//상수
	//추상메서드
	int plus(int num1, int num2);
}
