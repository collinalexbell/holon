package holon.tech;

import org.junit.Test;
import static org.junit.Assert.*;

import java.io.FileOutputStream;
import java.io.IOException;
import java.io.ObjectOutputStream;
import java.net.MalformedURLException;
import java.net.URL;

public class DocumentationTest {
		
	@Test public void builderThrowsExceptionIfInvalidState() {
		Documentation.Builder builder = new Documentation.Builder();
		Tech alienArtifact = new Tech();

		try {
			builder.build();
			fail("builder should throw");
		} catch (Exception e) {}

		builder.name("foo");

		try {
			builder.build();
			fail("builder should throw");
		} catch (Exception e) {}

		builder.subject(alienArtifact);
		try {
			builder.source("http://google.com");
		} catch (MalformedURLException e) {
			fail("broken URL");
		}
		
		try {
			Documentation d = builder.build();
		} catch (Exception e) {
			fail("build failed when it was supposed to succeed");
		}
	}
	
	@Test public void documentationFromBuilderIsComplete() {
		String description = "description";
		String name = "name";
		Tech subject = new Tech();
		URL source = null;
		try {
			source = new URL("http://google.com");
		} catch (MalformedURLException e1) {
			// TODO Auto-generated catch block
			fail("can't make url from 'http://google.com' . shouldn't happen");
		}
		Documentation docWStringUrl = null;
		Documentation docWUrl = null;
		Documentation.Builder builder= new Documentation.Builder();
		try {
			builder.name(name).
				description(description).
				source(source.toString()).
				subject(subject);
			docWStringUrl = builder.build();
			builder.source(source);
			docWUrl = builder.build();
		} catch(Exception e) {
			fail("Build threw exception");
		}
		assertDoc(docWStringUrl, name, description, subject, source);
		assertDoc(docWUrl, name, description, subject, source);
	}

	private void assertDoc(Documentation doc, String name, String description, Tech subject, URL source) {
		assertEquals(name, doc.name);
		assertEquals(description, doc.description);
		assertEquals(subject, doc.subject);
		assertEquals(source, doc.source);
	}
	
	@Test public void serialization() {
		Tech alienware = new Tech();
		Documentation doc = null;
		try {
			doc = new Documentation.Builder()
					.name("doesn't matter")
					.source("https://github.com/SlightlyCyborg")
					.subject(alienware)
					.build();
		} catch (Exception e) {
			fail("failed to create documentation");
		}
		try {
			FileOutputStream fileOut = new FileOutputStream("/tmp/documentation.ser");
			ObjectOutputStream out = new ObjectOutputStream(fileOut);
			out.writeObject(doc);
			out.close();
			fileOut.close();

		} catch (IOException e) {
			fail("failed to serialize");
		}
		Documentation doc2 = null;
		try {
			 doc2 = new Documentation.Builder()
					.fromSerialFile("/tmp/documentation.ser")
					.subject(alienware)
					.build();
					
		} catch(Exception e) {
			fail("couldn't deserialize");
		}
		assertEquals(doc.name, doc2.name);
		assertEquals(doc.subject, doc2.subject);
	}
}
