package test;

public class Car {

	public Engine engine;
	
	public Car() {
		// TODO Auto-generated constructor stub
	}
	
	public Car(Engine engine) {
		this.engine = engine;
	}
	
	public void run() {
		engine.start();
	}
	
	public void setEngine(Engine engine) {
		this.engine = engine;
	}
}


