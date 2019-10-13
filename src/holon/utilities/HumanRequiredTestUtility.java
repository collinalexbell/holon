package holon.utilities;

import org.junit.Test;
import static org.junit.Assert.*;

import javax.swing.JOptionPane;

public class HumanRequiredTestUtility {
	public static boolean didItHappen(String thingToHappen) {
		int reply = JOptionPane.showConfirmDialog(null, "Did "+thingToHappen+"?", "Yes/No",  JOptionPane.YES_NO_OPTION);
		if (reply == JOptionPane.YES_OPTION)
		{
			return true;
		}
		return false;
	}
}
