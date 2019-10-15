package holon.tech.text_editor;

import org.junit.Test;
import static org.junit.Assert.*;

public class BufferTest {
    @Test
    public void testSplitsIntoLines() {
        String contents = "abc\ndef\n\ng\n";
        Buffer buf = Buffer.fromString(contents);

        String[] lines = null;
        try {
            lines = buf.getLines(0, 5);
        } catch ( Exception e ) {
            fail("couldn't even get lines");
        }
        assertEquals("abc", lines[0]);
        assertEquals("def", lines[1]);
        assertEquals("", lines[2]);
        assertEquals("g", lines[3]);
        assertEquals("", lines[4]);
    }

    @Test
    public void testGetLinesShouldThrowWhenOutOfBounds() {
        String contents = "a\nb";
        Buffer b = Buffer.fromString(contents);
        try {
            b.getLines(-1, 1);
            fail("Start index of 0 not allowed");
        } catch (Exception e) {}
        try {
            b.getLines(0, 3);
            fail("There are not 3 lines to get");
        } catch (Exception e) {}
        try {
            b.getLines(1, 2);
            fail("There are not 2 lines to get if startInd is 1");
        } catch (Exception e) {}
        try {
            b.getLines(2, 0);
            fail("Start index>sizeBufferInLines-1 not allowed");
        } catch (Exception e) {}
    }
}
