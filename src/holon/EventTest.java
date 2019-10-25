package holon;

import org.junit.Test;
import static org.junit.Assert.*;
import java.time.ZonedDateTime;
import java.time.ZoneId;

public class EventTest {
    @Test public void testToString() {
        ZonedDateTime dt = ZonedDateTime.of(
                2013, 9, 3, 0, 30, 0, 0, ZoneId.of("UTC"));
        Event e = new Event("Yelvis became a parody star", dt);
        String expected = "Yelvis became a parody star at 00:30 UTC on 2013-09-03.";
        assertEquals(expected, e.toString());
    }
}
