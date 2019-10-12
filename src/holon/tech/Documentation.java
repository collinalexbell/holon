package holon.tech;

import java.awt.Desktop;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.ObjectInputStream;
import java.io.ObjectOutputStream;
import java.io.Serializable;
import java.net.MalformedURLException;
import java.net.URISyntaxException;
import java.net.URL;

public class Documentation extends Tech implements Serializable {
	private static final long serialVersionUID = 1L;
	protected String name;
	protected String description;
	protected transient Tech subject;
	protected URL source;
	private Documentation() {}

	public static class Builder {
		Documentation toBuild = new Documentation();
		
		public Builder fromSerialFile(String filename) throws Exception {
			try {
				FileInputStream fileIn = new FileInputStream("/tmp/documentation.ser");
				ObjectInputStream in = new ObjectInputStream(fileIn);
				Object inObj = in.readObject();	
				if(!(inObj instanceof Documentation)) {
					throw new Exception();
				} else {
					toBuild = (Documentation) inObj;
				}
			} catch(IOException e) {
				throw new Exception("This file doesn't exist");
			} catch(Exception e) {
				throw new Exception("Couldn't deserialize file into Documentation");
			}
			return this;
		}
		
		Builder name(String name) {
			toBuild.name = name;
			return this;
		}
		
		Builder description(String description) {
			toBuild.description = description;
			return this;
		}
		
		Builder subject(Tech subject) {
			toBuild.subject = subject;
			return this;
		}
		
		Builder source(String source) throws MalformedURLException {
			toBuild.source = new URL(source);
			return this;
		}
		
		Builder source(URL source) {
			toBuild.source = source;
			return this;
		}
		
		Documentation build() {
			if (toBuild.source == null) {
				throw new IllegalStateException("source needs to be set before building Documentaiton");
			}
			if (toBuild.name == null) {
				throw new IllegalStateException("name needs to be set before building Documentaiton");
			}
			if (toBuild.subject == null) {
				throw new IllegalStateException("subject needs to be set before building Documentaiton");
			}
			return toBuild;
		}
	}
	
	public void viewSource() throws IOException, URISyntaxException {
		if (Desktop.isDesktopSupported() && Desktop.getDesktop().isSupported(Desktop.Action.BROWSE)) {
		    Desktop.getDesktop().browse(source.toURI());
		} else {
			throw new UnsupportedOperationException("can't get Desktop browser");
		}
	}
}
