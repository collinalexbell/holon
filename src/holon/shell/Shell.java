package holon.shell;

import java.util.logging.Logger;
import java.io.*;

import java.lang.reflect.Method;
import java.lang.ClassLoader;
import java.net.URLClassLoader;
import java.util.Vector;
import java.net.URL;



public class Shell implements Runnable{
    String usr, host;
    File dir;
    Logger logger = Logger.getLogger("shell");
    BufferedReader in;
    PrintStream out = System.out;

    private Shell() {
        initPath();
        initSystemProps();
        initConsole();
    };

    private void initConsole() {
        InputStreamReader reader = new InputStreamReader(System.in);
        in = new BufferedReader(reader);
    }

    private void initPath() {
        String path = System.getenv().get("PATH");
    }

    private void initSystemProps() {
        try{
            usr = System.getProperty("user.name", "noface");
            dir = new File(System.getProperty("user.home", "/"));
            host = System.getProperty("machine.name", "holon");
        } catch (SecurityException e) {
            logger.warning("Shell's security manager prevents it from checking system properties");
        } catch (Exception e) {
            logger.severe("Either system property key was empty or null");
        }
    }

    public static Shell getHomeShell(){
        Shell s = new Shell();
        return s;
    }

    public static void main(String[] args) {
        Shell s = getHomeShell();
        s.run();

    }

    private void shellLoop() {
        String command = "";

        while(!command.equals("exit")) {
            showPrompt();
            command = getCommand();
            String[] args = {};
            runJavaProgram(command, args);
        }
    }

    public void runJavaProgram(String packageName, String[] args) {
        ClassLoader classLoader = new ShellClassLoader("/home/alex/Projects/holon/build/classes/");

        try {
            Class c = classLoader.loadClass(packageName);
            Method main = c.getMethod("main", String[].class);
            Object result = main.invoke(null, new Object[]{args});
        } catch (Exception e) {
            System.out.println(e);
            //System.out.printf("Couldn't run java program: %s\n", packageName);
        }
    }

    public void run() {
        printWelcome();
        shellLoop();
        printGoodbye();
    }

    private void printWelcome() {
        out.println("holon.shell booting up ...");
    }

    private void printGoodbye() {
        out.println("holon.shell shutting down ...");
    }

    private String preProcessCommand(String command) {
        return command.trim();
    }

    private String getCommand() {
        String command = "";
        try {
            command = in.readLine();
            return preProcessCommand(command);
        } catch (Exception e) {
            return command;
        }
    }

    private void showPrompt() {
        out.printf("[%s@%s %s]$", usr, host, dir.getName());
    }
}
