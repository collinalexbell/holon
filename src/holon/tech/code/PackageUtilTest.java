package holon.tech.code;
import org.junit.Test;
import static org.junit.Assert.*;

import java.io.BufferedReader;
import java.io.FileReader;
import java.io.File;
import java.nio.file.Path;
import java.nio.file.Paths;

public class PackageUtilTest {
    @Test public void moveToPackage() {
        Path projectDir = Paths.get("./src");
        PackageUtil util = null;
        try {
             util = new PackageUtil(projectDir.toFile());
        } catch (Exception e) {
            fail(e.getMessage());
        }
        String thisFile = "./src/holon/tech/code/PackageUtilTest.java";
        try {
            util.moveToPackage(new File(thisFile), "holon.tech");
            String thatFile = "./src/holon/tech/PackageUtilTest.java";
            try(BufferedReader b = new BufferedReader(new FileReader(thatFile))) {
                String firstLine = b.readLine();
                assertEquals("package holon.tech;", firstLine);
            } catch (Exception e) {
                fail();
            }
            try {
                util.moveToPackage(new File(thatFile), "holon.tech.code");
            } catch (Exception e) {
                System.out.println("URGENT: test file moved somewhere and not moved back. find it and move it back");
                fail(e.getMessage());
            }
        } catch (Exception e) {
            fail(e.getMessage());
        }
    }
}
