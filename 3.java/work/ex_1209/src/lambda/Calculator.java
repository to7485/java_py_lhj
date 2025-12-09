package lambda;

public class Calculator implements MyCalculator{

	@Override
	public int plus(int num1, int num2) {
		return num1 + num2;
	}

}
