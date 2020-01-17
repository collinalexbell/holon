package holon;

public class Mass {
	private double grams;
	
	public static Mass fromGrams(double grams) {
		Mass rv = new Mass();
		rv.grams = grams;
		return rv;
	}

	public static Mass fromKilograms(double kilograms) {
		Mass rv = new Mass();
		rv.grams = kilograms * 1000;
		return rv;
	}
	
	public double grams() {
		return grams;
	}
	
	public double kilograms() {
		return grams / 1000;
	}
}
