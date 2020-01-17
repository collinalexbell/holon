package holon;

import org.apache.commons.math3.geometry.euclidean.threed.Vector3D;

public abstract class PhysicalObject {
	PhysicalSpace space;
	PhysicalObject(PhysicalSpace space, Mass m){
		this.space = space;
		this.mass = m;
	}
	
	public void move(Vector3D v) {
		if(space != null)
			space.move(this, v);
	}
	
	Mass mass;
}
