package holon;

import java.time.LocalDate;
import java.time.Period;
import java.util.Date;

public class Animal {
	private LocalDate birthDate;
	private int age;
	private int calorieStores;
	int exhaustionThreshold() {
		return 0;
	}
	void burnCalories(int cals) throws Exception {
		if(cals > (calorieStores - exhaustionThreshold())) {
			throw new Exception("Not enough calories to burn");
		}
		calorieStores -= cals;
	}
	
	protected Animal() {
		this.birthDate = LocalDate.now();
	}
	
	protected Animal(LocalDate birthDate) {
		this.birthDate = birthDate;
	}
	
	public int getAge() {
		return getAgeAsOf(LocalDate.now());
	}

	public int getAgeAsOf(LocalDate d) {
		Period p = Period.between(birthDate, d);
		return p.getYears();
	}
}
