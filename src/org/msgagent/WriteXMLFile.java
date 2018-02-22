package org.msgagent;

import java.io.File;
import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;
import javax.xml.parsers.ParserConfigurationException;
import javax.xml.transform.Transformer;
import javax.xml.transform.TransformerException;
import javax.xml.transform.TransformerFactory;
import javax.xml.transform.dom.DOMSource;
import javax.xml.transform.stream.StreamResult;

import org.w3c.dom.Document;
import org.w3c.dom.Element;

public class WriteXMLFile {

public File CreateXML(String idC,String idA, String nameC,String classeC,String ipworkspaceC, String wpnameC){
	  try {

		DocumentBuilderFactory docFactory = DocumentBuilderFactory.newInstance();
		DocumentBuilder docBuilder = docFactory.newDocumentBuilder();

		// root elements
		Document doc = docBuilder.newDocument();
		Element rootElement = doc.createElement("Capability");
		doc.appendChild(rootElement);

		// concrete elements
		Element concrete = doc.createElement("Concrete");
		rootElement.appendChild(concrete);
		
		// idConcrete elements
		Element idConcrete = doc.createElement("idConcrete");
		idConcrete.appendChild(doc.createTextNode(idC));
		concrete.appendChild(idConcrete);

		// idAbstract elements
		Element idAbstract = doc.createElement("idAbstract");
		idAbstract.appendChild(doc.createTextNode(idA));
		concrete.appendChild(idAbstract);
		
		// name elements
		Element name = doc.createElement("name");
		name.appendChild(doc.createTextNode(nameC));
		concrete.appendChild(name);

		// classe elements
		Element classe = doc.createElement("classe");
		classe.appendChild(doc.createTextNode(classeC));
		concrete.appendChild(classe);

		// ipworkspace elements
		Element ipworkspace = doc.createElement("ipworkspace");
		ipworkspace.appendChild(doc.createTextNode(ipworkspaceC));
		concrete.appendChild(ipworkspace);

		// wpname elements
		Element wpname = doc.createElement("wpname");
		wpname.appendChild(doc.createTextNode(wpnameC));
		concrete.appendChild(wpname);
		
		// write the content into xml file
		TransformerFactory transformerFactory = TransformerFactory.newInstance();
		Transformer transformer = transformerFactory.newTransformer();
		DOMSource source = new DOMSource(doc);
		File filetosend= new File("file.xml");
		StreamResult result = new StreamResult(filetosend);

		// Output to console for testing
		// StreamResult result = new StreamResult(System.out);

		transformer.transform(source, result);

		System.out.println("File saved!");
		return filetosend;
		
	  } catch (ParserConfigurationException pce) {
		pce.printStackTrace();
		return null;
	  } catch (TransformerException tfe) {
		tfe.printStackTrace();
		return null;
	  }
	}
}