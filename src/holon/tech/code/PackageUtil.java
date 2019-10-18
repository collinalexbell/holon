package holon.tech.code;

import java.io.File;
import java.nio.file.Files;
import java.io.FileReader;
import java.io.BufferedReader;
import java.io.FileWriter;
import java.nio.file.Path;
import java.nio.file.Paths;

public class PackageUtil {

    File srcDir;

    private static boolean filesAreParentChild(File parent, File child) {
        //recursive base cases
        if(child == null) return false;
        if(parent.equals(child)) return true;

        return filesAreParentChild(parent, child.getParentFile());
    }

    public PackageUtil(File srcDir) throws Exception {
        if(srcDir == null || !srcDir.isDirectory()){
            String msg = "srcDir is not a directory";
            throw new Exception(msg);
        }
        this.srcDir = srcDir;
    }

    private File packageDir(String packageName) {
        return new File(srcDir
                + File.separator
                + packageName.replace(".", File.separator));
    }

    private static void changePackageInSrc(File srcFile, String packageName) throws Exception{
        StringBuffer code = new StringBuffer();
        String line;
        Boolean found = false;
        try (BufferedReader b = new BufferedReader(new FileReader(srcFile))) {
            while((line = b.readLine()) != null) {
                //only the first instance of "package" should be changed
                //this prevents changing fn code that has "package" in it
                //for example, this function would get clobbered
                if(!found && line.contains("package")) {
                    line = String.format("package %s;", packageName);
                    found = true;
                }
                code.append(line);
                code.append("\n");
            }
        } catch (Exception e) {
            throw new Exception("couldn't read class file");
        }

        try (FileWriter w = new FileWriter(srcFile)) {
            w.write(code.toString());
        } catch (Exception e) {
            throw new Exception("couldn't write to class file");
        }

    }

    public static void moveFileToDir(File f, File dir) {
        File dest = new File(dir.getPath() + File.separator + f.getName());
        f.renameTo(dest);
    }

    public void moveToPackage(File classToMove, String packageName) throws Exception{
        if(!filesAreParentChild(srcDir, classToMove)) {
            String msg = "classToMove is not available in the srcDir";
            throw new Exception(msg);
        }

        if(!classToMove.isFile()) {
            String msg = "classToMove doesn't exist";
            throw new Exception(msg);
        }

        File destDir = packageDir(packageName);
        if(destDir.isFile()) {
            String msg = "destDir is already a file";
            throw new Exception(msg);
        }

        destDir.mkdirs();
        changePackageInSrc(classToMove, packageName);
        moveFileToDir(classToMove, destDir);
    }
}
