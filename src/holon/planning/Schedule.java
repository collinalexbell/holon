package holon.planning;

import holon.Event;

import java.util.List;
import java.util.ArrayList;

class Schedule {

    List<Event> events;

    public Schedule() {
        events = new ArrayList();
    }

    public void addEvent(Event e) {
        events.add(e);
    }

    public List<Event> getEvents() {
        return events;
    }
}
