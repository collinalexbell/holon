package holon;

import java.time.ZonedDateTime;

public class Event {
    private ZonedDateTime when;
    private String name;

    public Event(String name, ZonedDateTime when) {
        this.name = name;
        this.when = when;
    }

    public String toString() {;
        String fmtr;
        fmtr = "%s at %02d:%02d %s on %04d-%02d-%02d.";
        String rv = String.format(fmtr, name, when.getHour(), when.getMinute(),
                when.getZone().toString(), when.getYear(), when.getMonthValue(), when.getDayOfMonth());

        return rv;
    }
}
