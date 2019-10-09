package holon;

public class PointObject extends PhysicalObject{
	public PointObject() {
		this(Mass.fromGrams(1));
	}

	public PointObject(Mass m) {
		super(m);
	}
}
