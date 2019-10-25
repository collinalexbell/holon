package holon.planning;

import org.junit.Test;
import static org.junit.Assert.*;

import java.time.ZonedDateTime;
import java.time.ZoneId;
import java.time.LocalDate;

import java.util.List;

import holon.Event;

public class ScheduleTest {
    @Test public void addAndGetAllEvents() {
        Schedule s = new Schedule();

        ZonedDateTime dt = ZonedDateTime.of(2019, 10, 26, 13, 30, 0, 0, ZoneId.of("UTC"));
        Event e1 = new Event("Get up", dt);
        s.addEvent(e1);

        dt = ZonedDateTime.of(2019, 10, 26, 14, 0, 0, 0, ZoneId.of("UTC"));
        Event e2 = new Event("Go running", dt);
        s.addEvent(e2);

        List<Event> events = s.getEvents();
        assertEquals(e1, events.get(0));
        assertEquals(e2, events.get(1));
    }

    @Test public void getEventsForDate() {
        Schedule s = new Schedule();

        ZonedDateTime dt = ZonedDateTime.of(2019, 10, 26, 13, 30, 0, 0, ZoneId.of("UTC"));
        Event doesntMatter = new Event("Thing1", dt);
        s.addEvent(doesntMatter);

        dt = ZonedDateTime.of(2019, 10, 27, 14, 0, 0, 0, ZoneId.of("UTC"));
        Event expected = new Event("Thing2", dt);
        s.addEvent(expected);

        List<Event> events = s.getEventsForDate(LocalDate.from(dt));
        assertEquals(1, events.size());
        assertEquals(expected, events.get(0));
    }
}
