package holon;

import org.junit.Test;
import static org.junit.Assert.*;

import java.util.Set;

public class PhysicalSpaceTest {
	@Test public void testObjectsNear(){
		Location tstLoc = new Location(20, 20, 20);
		PhysicalSpace space = new PhysicalSpace();
		PointObject[] objs =  new PointObject[5];
		Location[] locs = new Location[5];
		//near
		locs[0] = new Location(3,3,3);
		locs[1] = new Location(3,5,3);
		locs[2] = new Location(-3,3,3);
		//far
		locs[3] = new Location(30,3,3);
		locs[4] = new Location(3,50,3);
		
		for(int i=0; i<objs.length; i++) {
			objs[i] = new PointObject();
			space.addObject(objs[i], locs[i]);
		}
		Set<PhysicalObject> near = space.objectsNear(new Location(0,0,0), 10);
		for(int i=0; i<objs.length; i++) {
			boolean isNear = near.contains(objs[i]);
			if(i<3) {
				assertTrue(isNear);
			} else {
				assertFalse(isNear);
			}
		}
	}
}
