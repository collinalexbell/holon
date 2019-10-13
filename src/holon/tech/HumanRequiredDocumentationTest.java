package holon.tech;

import holon.utilities.HumanRequiredTestUtility;

import org.junit.Test;
import static org.junit.Assert.*;

public class HumanRequiredDocumentationTest {
	@Test public void browserOpenTest() {
		Tech alienware = new Tech();
		Documentation doc = null;
		try {
			doc = new Documentation.Builder()
					.name("doesn't matter")
					.source("https://github.com/SlightlyCyborg")
					.subject(alienware)
					.build();
		} catch(Exception e) {
			fail("Documentation couldn't be created");
		}

		try {
			doc.viewSource();
			if(!HumanRequiredTestUtility.didItHappen("slightlycyborg's github open in browser")) {
				throw new Exception("It failed");
			}
		} catch(Exception e) {
			fail("source could not be viewed");
		}
	}
}
