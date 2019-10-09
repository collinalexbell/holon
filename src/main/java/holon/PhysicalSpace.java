package holon;

import java.util.HashMap;
import java.util.HashSet;
import java.util.Map;
import java.util.Set;

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
			Location objLoc = objMappedToLocation.get(o);
			if(loc.distance(objLoc) <= distance) {
				rv.add(o);
			}
		}
		return rv;
	}
}
