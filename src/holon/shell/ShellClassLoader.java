package holon.shell;

import java.io.File;
import java.nio.file.Files;
import java.net.URL;
import java.util.HashMap;
import java.util.Map;

public class ShellClassLoader extends ClassLoader {

    String baseDir;
    Map<String, Class> classes;

    public ShellClassLoader(String classPath){
        super();
        classes = new HashMap<>();
        baseDir = classPath;
    }

    public Class loadClass(String name) throws ClassNotFoundException {
        Class c = classes.get(name);
        if (c != null) {
            return c;
        }
        c = findClass(name);
        if (c != null) {
            classes.put(name, c);
            return c;
        }

        return super.loadClass(name);
    }

    public Class findClass(String name) {
        String[] components = name.split("\\.");
        StringBuffer pathBuff = new StringBuffer(baseDir);
        for(String pathElement : components) {
            pathBuff.append(pathElement);
            if(pathElement != components[components.length-1]) {
                pathBuff.append("/");
            } else {
                pathBuff.append(".class");
            }
        }


        try {
            File f = new File(pathBuff.toString());
            byte[] b = Files.readAllBytes(f.toPath());
            return defineClass(name, b, 0, b.length);
        } catch (Exception e) {
            return null;
        }
    }
}
