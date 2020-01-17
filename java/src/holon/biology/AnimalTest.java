package holon.biology;

import org.junit.Test;
import static org.junit.Assert.*;

import java.time.LocalDate;

public class AnimalTest {
	@Test public void testBirthday() {
		Animal a = new Animal(LocalDate.of(1992, 1, 15));
		assertEquals(27, a.getAgeAsOf(LocalDate.of(2019, 10, 9)));
	}
}
