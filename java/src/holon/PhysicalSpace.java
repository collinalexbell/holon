package holon;

import java.util.HashMap;
import java.util.HashSet;
import java.util.Map;
import java.util.Set;

import org.apache.commons.math3.geometry.euclidean.threed.Vector3D;

public class PhysicalSpace {
	Set<PhysicalObject> objs;
	Map<PhysicalObject, Location> objMappedToLocation;
	
	public PhysicalSpace() {
		objs = new HashSet<>();
		objMappedToLocation = new HashMap<>();
	}
	
	void addObject(PhysicalObject obj, Location loc){
		objs.add(obj);
		objMappedToLocation.put(obj, loc);
	}
	
	Set<PhysicalObject> objectsNear(Location loc, double distance) {
		Set<PhysicalObject> rv = new HashSet<>();
		for(PhysicalObject o: objs) {
			Location objLoc = locationOf(o);
			if(loc.distance(objLoc) <= distance) {
				rv.add(o);
			}
		}
		return rv;
	}
	
	Location locationOf(PhysicalObject obj) {
		return objMappedToLocation.get(obj);
	}
	
	void move(PhysicalObject obj, Vector3D vec) {
		Location loc = locationOf(obj);
		loc.add(vec);
	}
}
