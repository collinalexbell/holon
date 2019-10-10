package holon;

public class PointObject extends PhysicalObject{
	public PointObject(PhysicalSpace space) {
		this(space, Mass.fromGrams(1));
	}

	public PointObject(PhysicalSpace space, Mass m) {
		super(space, m);
	}
}
