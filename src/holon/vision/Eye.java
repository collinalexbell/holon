package holon.vision;

import boofcv.gui.image.ImagePanel;
import boofcv.gui.image.ShowImages;
import boofcv.io.image.UtilImageIO;
import boofcv.io.webcamcapture.UtilWebcamCapture;
import com.github.sarxos.webcam.Webcam;

import javax.swing.JFrame;
import java.awt.event.KeyEvent;
import java.awt.event.KeyAdapter;
import java.awt.event.MouseEvent;
import java.awt.event.MouseAdapter;
import java.awt.image.BufferedImage;

public class Eye {

    Webcam webcam = null;
    public static volatile boolean cont = true;
    public static JFrame jf;

    public Eye() {
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

    public static void main(String[] args) {
        Eye eye = new Eye();
        ImagePanel gui = new ImagePanel();
        gui.addMouseListener(new MouseAdapter() {
            @Override
            public void mouseClicked(MouseEvent e) {
                cont = false;
                jf.dispose();
            }
        });
        gui.addKeyListener(new KeyAdapter() {
            @Override
            public void keyPressed(KeyEvent e){
                cont = false;
            }
            @Override
            public void keyReleased(KeyEvent e){}
            @Override
            public void keyTyped(KeyEvent e) {
                cont = false;
            }
        });

        jf = ShowImages.showWindow(gui,"Webcam",true);


        BufferedImage img;
        while(cont) {
            img = eye.getImg();
            gui.setImageRepaint(img);
        }
    }
}
