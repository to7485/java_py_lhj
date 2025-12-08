package test;

public class Main {
	public static void main(String[] args) {
		Car car = new Car();
		
		//필드 주입
		//car.engine = new Engine();
		
		//setter주입
		//car.setEngine(new Engine());
		
		car.run();
		
		//생성자 주입
		Car myCar = new Car(new Engine());
		
		
		
		
		
		
	}
}
