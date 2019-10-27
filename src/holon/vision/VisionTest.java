package holon.vision;

import org.junit.Test;
import static org.junit.Assert.*;

import java.awt.image.BufferedImage;

public class VisionTest {
    @Test
    public void testGetPic (){
        Vision v = new Vision();
        BufferedImage img = v.getImg();
        assertEquals(480, img.getHeight());
        assertEquals(640, img.getWidth());
    }
}
