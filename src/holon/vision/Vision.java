package holon.vision;

import boofcv.gui.image.ImagePanel;
import boofcv.gui.image.ShowImages;
import boofcv.io.image.UtilImageIO;
import boofcv.io.webcamcapture.UtilWebcamCapture;
import com.github.sarxos.webcam.Webcam;

import java.awt.event.MouseAdapter;
import java.awt.event.MouseEvent;
import java.awt.image.BufferedImage;

public class Vision {

    Webcam webcam = null;

    public Vision() {
        webcam = Webcam.getWebcams().get(0);
        webcam.open();
    }

    @Override
    public void finalize() {
        webcam.close();
    }

    public BufferedImage getImg() {
        BufferedImage image = webcam.getImage();
        return image;
    }
}
