package holon.planning;

import holon.Event;

import java.util.List;
import java.util.ArrayList;

import java.time.LocalDate;

import java.util.stream.*;
import java.util.function.Predicate;

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

    public List<Event> getEventsForDate(LocalDate date) {
        Predicate<Event> byDate = event -> event.getDate().compareTo(date) == 0;
        List<Event> rv = events.stream().filter(byDate).collect(Collectors.toList());
        return rv;
    }
}
