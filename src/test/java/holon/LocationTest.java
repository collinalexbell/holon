package holon;

import org.junit.Test;
import static org.junit.Assert.*;

public class LocationTest {
	@Test public void testDistance() {
		Location loc1 = new Location(5,5,-5);
		Location loc2 = new Location(0,0,0);
		
		assertEquals(Math.sqrt(75), loc1.distance(loc2), 0.1);
	}
}
