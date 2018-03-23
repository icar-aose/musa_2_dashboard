package org.msgagent;

import java.io.File;
import java.io.IOException;
import java.net.URI;
import java.nio.file.FileSystem;
import java.nio.file.FileSystems;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.HashMap;
import java.util.Map;

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

import dbBean.ConcreteCapability;

public class WriteXMLFile {

	public File CreateXML(File jarFile, String filePath, ConcreteCapability conc) throws IOException {
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
			idConcrete.appendChild(doc.createTextNode(conc.getIdConcreteCapability().toString()));
			concrete.appendChild(idConcrete);

			// idAbstract elements
			Element idAbstract = doc.createElement("idAbstract");
			idAbstract
					.appendChild(doc.createTextNode(conc.getAbstractCapability().getIdAbstratCapability().toString()));
			concrete.appendChild(idAbstract);

			// name elements
			Element name = doc.createElement("name");
			name.appendChild(doc.createTextNode(conc.getName()));
			concrete.appendChild(name);

			// classe elements
			Element classe = doc.createElement("classe");
			classe.appendChild(doc.createTextNode(conc.getClassname()));
			concrete.appendChild(classe);

			// ipworkspace elements
			Element ipworkspace = doc.createElement("ipworkspace");
			ipworkspace.appendChild(doc.createTextNode(conc.getIpWorkspace()));
			concrete.appendChild(ipworkspace);

			// wpname elements
			Element wpname = doc.createElement("wpname");
			wpname.appendChild(doc.createTextNode(conc.getWpname()));
			concrete.appendChild(wpname);

			// agentname elements
			Element agentname = doc.createElement("agentname");
			agentname.appendChild(doc.createTextNode(conc.getAgent()));
			concrete.appendChild(agentname);

			// write the content into xml file
			TransformerFactory transformerFactory = TransformerFactory.newInstance();
			Transformer transformer = transformerFactory.newTransformer();
			DOMSource source = new DOMSource(doc);
			File filetosend = new File(filePath + "/manifest.xml");
			StreamResult result = new StreamResult(filetosend);
			transformer.transform(source, result);
			System.out.println("File saved!");
			addXmltoJar(filetosend, jarFile);

			return filetosend;

		} catch (ParserConfigurationException pce) {
			pce.printStackTrace();
			return null;
		} catch (TransformerException tfe) {
			tfe.printStackTrace();
			return null;
		}
	}

	public void addXmltoJar(File xmlFile, File jarFile) throws IOException {

		/* Define ZIP File System Properies in HashMap */
		Map<String, String> zip_properties = new HashMap<>();
		/* We want to read an existing ZIP File, so we set this to False */
		zip_properties.put("create", "false");
		/* Specify the encoding as UTF -8 */
		zip_properties.put("encoding", "UTF-8");
		/* Specify the path to the ZIP File that you want to read as a File System */
		URI zip_disk = URI.create("jar:" + jarFile.toURI().toString());
		/* Create ZIP file System */
		try (FileSystem zipfs = FileSystems.newFileSystem(zip_disk, zip_properties)) {
			/* Create a Path in ZIP File */
			Path ZipFilePath = zipfs.getPath(xmlFile.getName());
			/* Path where the file to be added resides */
			Path addNewFile = Paths.get(xmlFile.getAbsolutePath());
			/* Append file to ZIP File */
			Files.copy(addNewFile, ZipFilePath);

		}
	}
}