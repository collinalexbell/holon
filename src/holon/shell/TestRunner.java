package holon.shell;

import org.junit.runner.JUnitCore;
import org.junit.runner.Result;
import org.junit.runner.notification.Failure;

public class TestRunner {
   public static void runTests(Class[] classes) {
       System.out.println("Running tests...");
       try{
           Result result = JUnitCore.runClasses(classes);

           System.out.printf("ran %d test, %d failed\n",
                   result.getRunCount(),
                   result.getFailureCount());

           for (Failure failure : result.getFailures()) {
               System.out.println(failure.toString());
           }
       } catch(Exception e) {
           System.out.println(e);
       }
   }

   public static void main(String[] args) {
       try {
           Class c  = TestRunner.class.getClassLoader().loadClass("holon.MassTest");
           Class[] cs = new Class[]{c};
           runTests(cs);
       } catch(Exception e){
           System.out.println(e);
       }
   }
}
