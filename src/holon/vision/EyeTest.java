package holon.vision;

import org.junit.Test;
import static org.junit.Assert.*;

import java.awt.image.BufferedImage;

public class EyeTest {
    @Test
    public void testGetPic (){
        Eye eye = new Eye();
        BufferedImage img = v.getImg();
        assertEquals(480, img.getHeight());
        assertEquals(640, img.getWidth());
    }
}
