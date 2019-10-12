package holon;

public class Mammal extends Animal{
	private FurCoat coat;
	
	public static Mammal newWithCoat(FurCoat c) {
		Mammal ret = new Mammal();
		ret.coat = c;
		return ret;
	}
}
