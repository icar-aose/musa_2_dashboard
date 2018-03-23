package util;

import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileReader;
import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;

import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;
import javax.xml.parsers.ParserConfigurationException;
import javax.xml.transform.Transformer;
import javax.xml.transform.TransformerConfigurationException;
import javax.xml.transform.TransformerException;
import javax.xml.transform.TransformerFactory;
import javax.xml.transform.dom.DOMSource;
import javax.xml.transform.stream.StreamResult;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.json.simple.parser.ParseException;
import org.w3c.dom.Attr;
import org.w3c.dom.Document;
import org.w3c.dom.Element;

public class ProcessUtility {
	private static HashMap<String, String> elementsMap = new HashMap<String, String>();
	private static HashMap<String, String> elementsTypeMap = new HashMap<String, String>();

	private static HashMap<String, ArrayList<Integer>> elementSourceMap = new HashMap<String, ArrayList<Integer>>();
	private static HashMap<String, ArrayList<Integer>> elementTargetMap = new HashMap<String, ArrayList<Integer>>();

	private static HashMap<String, ArrayList<Integer>> elementLinkSourceMap = new HashMap<String, ArrayList<Integer>>();
	private static HashMap<String, ArrayList<Integer>> elementLinkTargetMap = new HashMap<String, ArrayList<Integer>>();
	private static ArrayList<String[]> testArray = new ArrayList<>();

	public static Document generateXMIFromJSON(JSONObject jsonObject) {

		DocumentBuilderFactory docFactory = DocumentBuilderFactory.newInstance();
		DocumentBuilder docBuilder;
		Document doc = null;
		try {
			docBuilder = docFactory.newDocumentBuilder();
			// root elements
			doc = docBuilder.newDocument();
			Element rootElement = doc.createElement("definitions");
			addAttributeToElement(doc, rootElement, "xmlns", "http://www.omg.org/spec/BPMN/20100524/MODEL");
			addAttributeToElement(doc, rootElement, "xmlns:bpmndi", "http://www.omg.org/spec/BPMN/20100524/DI");
			addAttributeToElement(doc, rootElement, "xmlns:dc", "http://www.omg.org/spec/DD/20100524/DC");
			addAttributeToElement(doc, rootElement, "xmlns:di", "http://www.omg.org/spec/DD/20100524/DI");
			addAttributeToElement(doc, rootElement, "xmlns:tns",
					"http://sourceforge.net/bpmn/definitions/_1419237461760");
			addAttributeToElement(doc, rootElement, "xmlns:xsd", "http://www.w3.org/2001/XMLSchema");
			addAttributeToElement(doc, rootElement, "xmlns:xsi", "http://www.w3.org/2001/XMLSchema-instance");
			addAttributeToElement(doc, rootElement, "xmlns:yaoqiang", "http://bpmn.sourceforge.net");
			addAttributeToElement(doc, rootElement, "exporter", "");
			addAttributeToElement(doc, rootElement, "xmlns:xsi", "http://www.w3.org/2001/XMLSchema-instance");
			addAttributeToElement(doc, rootElement, "exporterVersion", "2.2.5 (GPLv3, Non-Commercial)");

			insertBoby(doc, rootElement, jsonObject);

			Integer id = (int) Math.floor((Math.random() * 100000000) + 1);

			addAttributeToElement(doc, rootElement, "id", "_" + id.toString());
			addAttributeToElement(doc, rootElement, "name", "");
			addAttributeToElement(doc, rootElement, "targetNamespace",
					"http://sourceforge.net/bpmn/definitions/_1419237461760");
			addAttributeToElement(doc, rootElement, "typeLanguage",
					"http://www.omg.org/spec/BPMN/20100524/MODEL http://bpmn.sourceforge.net/schemas/BPMN20.xsd");
			addAttributeToElement(doc, rootElement, "xsi:schemaLocation",
					"http://www.omg.org/spec/BPMN/20100524/MODEL http://bpmn.sourceforge.net/schemas/BPMN20.xsd");

			doc.appendChild(rootElement);

			// aggiungo tutti gli altri elementi al root

			// write the content into xml file
			TransformerFactory transformerFactory = TransformerFactory.newInstance();
			Transformer transformer = transformerFactory.newTransformer();
			DOMSource source = new DOMSource(doc);
			StreamResult result = new StreamResult(new File("/Users/antonellacavaleri/Desktop/fileTEST.xml"));

			// Output to console for testing
			// StreamResult result = new StreamResult(System.out);

			transformer.transform(source, result);

			System.out.println("File created!");

		} catch (ParserConfigurationException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (TransformerConfigurationException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (TransformerException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return doc;

	}

	private static void addAttributeToElement(Document doc, Element element, String attrName, String value) {
		Attr attr = doc.createAttribute(attrName);
		attr.setValue(value);
		element.setAttributeNode(attr);

	}

	private static void insertBoby(Document doc, Element rootElement, JSONObject jsonObject) {

		// insert item element
		JSONArray itemsList = (JSONArray) jsonObject.get("items");
		Iterator iterator = itemsList.iterator();

		while (iterator.hasNext()) {
			JSONObject itemObj = (JSONObject) iterator.next();

			Element item = doc.createElement("itemDefinition");
			addAttributeToElement(doc, item, "id", itemObj.get("Name").toString());
			addAttributeToElement(doc, item, "itemKind", itemObj.get("Type").toString());
			addAttributeToElement(doc, item, "structureRef", itemObj.get("Name").toString());

			rootElement.appendChild(item);
		}

		JSONArray cellsList = (JSONArray) jsonObject.get("cells");
		// Iterator cellsIteratorMap = cellsList.iterator();
		// creo una mappa per gli di con tutti gli elementi
		Integer i = 0;
		for (int j = 0; j < cellsList.size(); j++) {
			JSONObject cellsObj = (JSONObject) cellsList.get(j);
			elementsMap.put(cellsObj.get("id").toString(), "_" + i.toString());
			elementsTypeMap.put("_" + i.toString(), cellsObj.get("type").toString());
			i++;
		}
		Iterator cellsIterator = cellsList.iterator();
		while (cellsIterator.hasNext()) {
			JSONObject cellsObj = (JSONObject) cellsIterator.next();

			if (cellsObj.get("type").toString().equals("bpmn.Message")) {
				// Aggiungo un elemento message
				Element cell = doc.createElement("message");

				JSONObject attributeObject = (JSONObject) cellsObj.get("attrs");
				JSONObject labelObject = (JSONObject) attributeObject.get(".label");

				addAttributeToElement(doc, cell, "id", elementsMap.get(cellsObj.get("id").toString()).toString());
				addAttributeToElement(doc, cell, "name", labelObject.get("text").toString());
				if (!cellsObj.get("dataItemRef").equals(""))
					addAttributeToElement(doc, cell, "itemRef", cellsObj.get("dataItemRef").toString());

				rootElement.appendChild(cell);
			}

		}

		Element process = doc.createElement("process");
		addAttributeToElement(doc, process, "id", "PROCESS_1");
		addAttributeToElement(doc, process, "name", jsonObject.get("process_name").toString());
		addAttributeToElement(doc, process, "isClosed", "false");
		addAttributeToElement(doc, process, "isExecutable", "true");
		addAttributeToElement(doc, process, "processType", "None");

		rootElement.appendChild(process);

		defineFlowElement(doc, process, jsonObject);

		Iterator allCellsIterator = cellsList.iterator();
		while (allCellsIterator.hasNext()) {
			JSONObject cellsObj = (JSONObject) allCellsIterator.next();

			if (cellsObj.get("type").toString().equals("bpmn.DataObject")) {
				defineDataObjectElement(doc, process, cellsObj);
			}
			if (cellsObj.get("type").toString().equals("bpmn.Activity")) {
				defineActivityElement(doc, process, cellsObj, jsonObject);
			}
			if (cellsObj.get("type").toString().equals("bpmn.Gateway")) {
				defineGatewayElement(doc, process, cellsObj);
			}
			if (cellsObj.get("type").toString().equals("bpmn.Event")) {
				defineEventElement(doc, process, cellsObj);
			}

		}

	}

	private static void defineEventElement(Document doc, Element process, JSONObject cellsObj) {
		String eventType = cellsObj.get("eventType").toString();
		String eventTag = "startEvent";
		if (eventType.equals("end"))
			eventTag = "endEvent";

		Element eventElement = doc.createElement(eventTag);
		addAttributeToElement(doc, eventElement, "id", elementsMap.get(cellsObj.get("id").toString()));
		JSONObject attributeObject = (JSONObject) cellsObj.get("attrs");
		JSONObject labelObject = (JSONObject) attributeObject.get(".label");
		if (labelObject != null) {
			String text = labelObject.get("text").toString();
			addAttributeToElement(doc, eventElement, "name", text);
		} else
			addAttributeToElement(doc, eventElement, "name", "");

		String eventTriggerType = cellsObj.get("trigger_type").toString();
		if (eventTriggerType.equals("parallelmultiple"))
			addAttributeToElement(doc, eventElement, "parallelMultiple", "true");

		else if (eventType.equals("start") || eventType.equals("intermediate"))
			addAttributeToElement(doc, eventElement, "parallelMultiple", "false");

		if (eventType.equals("start"))
			addAttributeToElement(doc, eventElement, "isInterrupting", "true");
		if (eventType.equals("intermediate"))
			addAttributeToElement(doc, eventElement, "isInterrupting", "false");

		// aggiungo il tag relativo ai link in ingresso ed in uscita
		allTagLink(doc, eventElement, cellsObj);

		switch (eventTriggerType) {

		case "message":
			Element messageEventDefinitiontElement = doc.createElement("messageEventDefinition");
			addAttributeToElement(doc, messageEventDefinitiontElement, "id",
					elementsMap.get(cellsObj.get("id").toString()) + "_EM_1");
			eventElement.appendChild(messageEventDefinitiontElement);
			break;
		case "timer":
			Element timerEventDefinitionElement = doc.createElement("timerEventDefinition");
			addAttributeToElement(doc, timerEventDefinitionElement, "id",
					elementsMap.get(cellsObj.get("id").toString()) + "_ET_1");
			eventElement.appendChild(timerEventDefinitionElement);

			break;
		case "conditional":
			Element conditionalEventDefinitionElement = doc.createElement("conditionalEventDefinition");
			addAttributeToElement(doc, conditionalEventDefinitionElement, "id",
					elementsMap.get(cellsObj.get("id").toString()) + "_EC_1");
			eventElement.appendChild(conditionalEventDefinitionElement);
			break;
		case "signal":
			Element signalEventDefinitionElement = doc.createElement("signalEventDefinition");
			addAttributeToElement(doc, signalEventDefinitionElement, "id",
					elementsMap.get(cellsObj.get("id").toString()) + "_ES_1");
			eventElement.appendChild(signalEventDefinitionElement);
			break;

		case "error":
			Element errorEventDefinitionElement = doc.createElement("errorEventDefinition");
			addAttributeToElement(doc, errorEventDefinitionElement, "id",
					elementsMap.get(cellsObj.get("id").toString()) + "_EER_1");
			eventElement.appendChild(errorEventDefinitionElement);
			break;

		case "compensation":
			Element compensateEventDefinitionElement = doc.createElement("compensateEventDefinition");
			addAttributeToElement(doc, compensateEventDefinitionElement, "id",
					elementsMap.get(cellsObj.get("id").toString()) + "_ECM_1");
			eventElement.appendChild(compensateEventDefinitionElement);
			break;

		case "terminate":
			Element terminateEventDefinitionElement = doc.createElement("terminateEventDefinition");
			addAttributeToElement(doc, terminateEventDefinitionElement, "id",
					elementsMap.get(cellsObj.get("id").toString()) + "_ET_1");
			eventElement.appendChild(terminateEventDefinitionElement);
			break;
		case "escalation":
			Element escalationEventDefinitionElement = doc.createElement("escalationEventDefinition");
			addAttributeToElement(doc, escalationEventDefinitionElement, "id",
					elementsMap.get(cellsObj.get("id").toString()) + "_ESC_1");
			eventElement.appendChild(escalationEventDefinitionElement);
			break;
		}

		process.appendChild(eventElement);
	}

	private static void defineGatewayElement(Document doc, Element process, JSONObject cellsObj) {
		String gatewayType = cellsObj.get("gatewayType").toString();
		String gatewayTag = "exclusiveGateway";
		if (gatewayType.equals("parallel"))
			gatewayTag = "parallelGateway";
		if (gatewayType.equals("inclusive"))
			gatewayTag = "inclusiveGateway";
		Element gatewayElement = doc.createElement(gatewayTag);
		addAttributeToElement(doc, gatewayElement, "id", elementsMap.get(cellsObj.get("id").toString()));

		JSONObject attributeObject = (JSONObject) cellsObj.get("attrs");
		JSONObject labelObject = (JSONObject) attributeObject.get(".label");
		if (labelObject != null) {
			String text = labelObject.get("text").toString();
			addAttributeToElement(doc, gatewayElement, "name", text);
		} else
			addAttributeToElement(doc, gatewayElement, "name", "");

		if (gatewayType.equals("inclusive"))
			addAttributeToElement(doc, gatewayElement, "gatewayDirection", "Unspecified");
		else
			addAttributeToElement(doc, gatewayElement, "gatewayDirection", "Diverging");

		// aggiungo il tag relativo ai link in ingresso ed in uscita
		allTagLink(doc, gatewayElement, cellsObj);

		process.appendChild(gatewayElement);

	}

	private static void defineActivityElement(Document doc, Element process, JSONObject cellsObj,
			JSONObject jsonObject) {

		String taskType = cellsObj.get("taskType").toString();
		String taskTag = "";
		if (taskType.equals("default"))
			taskTag = "task";
		else
			taskTag = taskType + "Task";
		Element taskElement = doc.createElement(taskTag);
		addAttributeToElement(doc, taskElement, "completionQuantity", "1");
		addAttributeToElement(doc, taskElement, "id", elementsMap.get(cellsObj.get("id").toString()));
		addAttributeToElement(doc, taskElement, "isForCompensation", "false");
		addAttributeToElement(doc, taskElement, "name", cellsObj.get("content").toString());
		addAttributeToElement(doc, taskElement, "startQuantity", "1");
		if (taskType.equals("receive") || taskType.equals("send") || taskType.equals("service")
				|| taskType.equals("user"))
			addAttributeToElement(doc, taskElement, "implementation", "##WebService");
		if (taskType.equals("receive"))
			addAttributeToElement(doc, taskElement, "instantiate", "false");
		// aggiungo il tag relativo ai link in ingresso ed in uscita
		allTagLink(doc, taskElement, cellsObj);

		// aggiungo i tag relativi ai data object
		allTagLinkDataObject(doc, taskElement, cellsObj);
		// aggiungo il tag relativo agli eventi di tipo boundary eventualmente presenti
		process.appendChild(taskElement);

		allBoundaryEvent(doc, process, cellsObj, jsonObject);

	}

	private static void allBoundaryEvent(Document doc, Element process, JSONObject cellsObj, JSONObject jsonObject) {
		JSONArray embeds = (JSONArray) cellsObj.get("embeds");
		if (embeds != null) {
			for (int i = 0; i < embeds.size(); i++) {
				Element boundaryEventElement = doc.createElement("boundaryEvent");
				addAttributeToElement(doc, boundaryEventElement, "attachedToRef", elementsMap.get(cellsObj.get("id")));
				addAttributeToElement(doc, boundaryEventElement, "cancelActivity", "true");
				addAttributeToElement(doc, boundaryEventElement, "id", elementsMap.get(embeds.get(i).toString()));

				// Recupero le informazioni relative all'elemnto boundary
				JSONArray cells = (JSONArray) jsonObject.get("cells");
				for (int j = 0; j < cells.size(); j++) {
					JSONObject cell = (JSONObject) cells.get(j);
					String cellId = cell.get("id").toString();
					if (cellId.equals(embeds.get(i).toString())) {

						JSONObject attributeObject = (JSONObject) cell.get("attrs");
						JSONObject labelObject = (JSONObject) attributeObject.get(".label");
						String text = labelObject.get("text").toString();

						if (!text.equals("")) {
							addAttributeToElement(doc, boundaryEventElement, "name", text);

						} else
							addAttributeToElement(doc, boundaryEventElement, "name", "");

						String eventTriggerType = cell.get("trigger_type").toString();
						if (eventTriggerType.equals("parallelmultiple"))
							addAttributeToElement(doc, boundaryEventElement, "parallelMultiple", "true");

						else
							addAttributeToElement(doc, boundaryEventElement, "parallelMultiple", "false");

						switch (eventTriggerType) {

						case "message":
							Element messageEventDefinitiontElement = doc.createElement("messageEventDefinition");
							addAttributeToElement(doc, messageEventDefinitiontElement, "id",
									elementsMap.get(embeds.get(i).toString()) + "_ED_1");
							boundaryEventElement.appendChild(messageEventDefinitiontElement);
							break;
						case "timer":
							Element timerEventDefinitionElement = doc.createElement("timerEventDefinition");
							addAttributeToElement(doc, timerEventDefinitionElement, "id",
									elementsMap.get(embeds.get(i).toString()) + "_ED_1");
							boundaryEventElement.appendChild(timerEventDefinitionElement);

							break;
						case "conditional":
							Element conditionalEventDefinitionElement = doc.createElement("conditionalEventDefinition");
							addAttributeToElement(doc, conditionalEventDefinitionElement, "id",
									elementsMap.get(embeds.get(i).toString()) + "_ED_1");
							boundaryEventElement.appendChild(conditionalEventDefinitionElement);
							break;
						case "signal":
							Element signalEventDefinitionElement = doc.createElement("signalEventDefinition");
							addAttributeToElement(doc, signalEventDefinitionElement, "id",
									elementsMap.get(embeds.get(i).toString()) + "_ED_1");
							boundaryEventElement.appendChild(signalEventDefinitionElement);
							break;

						case "error":
							Element errorEventDefinitionElement = doc.createElement("errorEventDefinition");
							addAttributeToElement(doc, errorEventDefinitionElement, "id",
									elementsMap.get(embeds.get(i).toString()) + "_ED_1");
							boundaryEventElement.appendChild(errorEventDefinitionElement);
							break;

						case "compensation":
							Element compensateEventDefinitionElement = doc.createElement("compensateEventDefinition");
							addAttributeToElement(doc, compensateEventDefinitionElement, "id",
									elementsMap.get(embeds.get(i).toString()) + "_ED_1");
							boundaryEventElement.appendChild(compensateEventDefinitionElement);
							break;

						case "terminate":
							Element terminateEventDefinitionElement = doc.createElement("terminateEventDefinition");
							addAttributeToElement(doc, terminateEventDefinitionElement, "id",
									elementsMap.get(embeds.get(i).toString()) + "_ED_1");
							boundaryEventElement.appendChild(terminateEventDefinitionElement);
							break;
						case "escalation":
							Element escalationEventDefinitionElement = doc.createElement("escalationEventDefinition");
							addAttributeToElement(doc, escalationEventDefinitionElement, "id",
									elementsMap.get(embeds.get(i).toString()) + "_ED_1");
							boundaryEventElement.appendChild(escalationEventDefinitionElement);
							break;
						}

					}

				}
				process.appendChild(boundaryEventElement);

			}
		}
	}

	private static void allTagLinkDataObject(Document doc, Element taskElement, JSONObject cellsObj) {

		Boolean asObject = false;
		for (int i = 0; i < testArray.size(); i++) {
			String idSource = testArray.get(i)[1];
			String idTarget = testArray.get(i)[2];

			if (idSource.equals(elementsMap.get(cellsObj.get("id")))) {

				// recupero l'elemnto source
				String idTargetNew = testArray.get(i)[2];
				// recupero il tipo dell'elemtno target
				String typeTarget = elementsTypeMap.get(idTargetNew);
				if (typeTarget.equals("bpmn.DataObject")) {
					if (!asObject) {
						Element ioSpecificationElement = doc.createElement("ioSpecification");
						asObject = true;

						setDataOut(doc, ioSpecificationElement, cellsObj);
						setDataInput(doc, ioSpecificationElement, cellsObj);

						setInputSet(doc, ioSpecificationElement, cellsObj);
						setOutputSet(doc, ioSpecificationElement, cellsObj);

						taskElement.appendChild(ioSpecificationElement);
					}

					Element dataInputAssociationElement = doc.createElement("dataInputAssociation");
					addAttributeToElement(doc, dataInputAssociationElement, "id", testArray.get(i)[0].toString());

					Element sourceRefElement = doc.createElement("sourceRef");
					sourceRefElement.appendChild(doc.createTextNode(idTargetNew.toString()));
					Element targetRefElement = doc.createElement("targetRef");
					targetRefElement.appendChild(doc.createTextNode("Din" + idSource + "" + idTargetNew.toString()));

					dataInputAssociationElement.appendChild(sourceRefElement);
					dataInputAssociationElement.appendChild(targetRefElement);
					taskElement.appendChild(dataInputAssociationElement);
				}
			}
			if (idTarget.equals(elementsMap.get(cellsObj.get("id")))) {
				// recupero l'elemnto source
				String idSourceNew = testArray.get(i)[1];
				// recupero il tipo dell'elemtno target
				String typeSource = elementsTypeMap.get(idSourceNew);
				if (typeSource.equals("bpmn.DataObject")) {
					if (!asObject) {
						Element ioSpecificationElement = doc.createElement("ioSpecification");
						asObject = true;

						setDataOut(doc, ioSpecificationElement, cellsObj);
						setDataInput(doc, ioSpecificationElement, cellsObj);

						setInputSet(doc, ioSpecificationElement, cellsObj);
						setOutputSet(doc, ioSpecificationElement, cellsObj);

						taskElement.appendChild(ioSpecificationElement);
					}

					Element dataOutputAssociationElement = doc.createElement("dataOutputAssociation");
					addAttributeToElement(doc, dataOutputAssociationElement, "id", testArray.get(i)[0].toString());

					Element sourceRefElement = doc.createElement("sourceRef");
					sourceRefElement.appendChild(doc.createTextNode("Dout" + idTarget + "" + idSourceNew.toString()));
					Element targetRefElement = doc.createElement("targetRef");
					targetRefElement.appendChild(doc.createTextNode(idSourceNew.toString()));

					dataOutputAssociationElement.appendChild(sourceRefElement);
					dataOutputAssociationElement.appendChild(targetRefElement);
					taskElement.appendChild(dataOutputAssociationElement);
				}
			}

		}

	}

	private static void setInputSet(Document doc, Element ioSpecificationElement, JSONObject cellsObj) {
		Boolean hasInputSet = false;
		if (!hasInputSet) {
			hasInputSet = true;
			Element inputSetElement = doc.createElement("inputSet");
			for (int i = 0; i < testArray.size(); i++) {
				String idSource = testArray.get(i)[1];
				if (idSource.equals(elementsMap.get(cellsObj.get("id").toString()))) {
					String idTargetElement = testArray.get(i)[2];
					String typeTargetElement = elementsTypeMap.get(idTargetElement);
					if (hasInputSet)
						if (typeTargetElement.equals("bpmn.DataObject")) {
							Element dataInputRefsElement = doc.createElement("dataInputRefs");
							inputSetElement.appendChild(dataInputRefsElement);
							dataInputRefsElement.appendChild(doc.createTextNode("Din" + idSource + idTargetElement));
						}
				}
				ioSpecificationElement.appendChild(inputSetElement);
			}

		}
	}

	private static void setOutputSet(Document doc, Element ioSpecificationElement, JSONObject cellsObj) {
		Boolean hasOutputSet = false;
		if (!hasOutputSet) {
			hasOutputSet = true;
			Element outputSetElement = doc.createElement("outputSet");
			for (int i = 0; i < testArray.size(); i++) {
				String idTarget = testArray.get(i)[2];
				if (idTarget.equals(elementsMap.get(cellsObj.get("id").toString()))) {
					String idSourceElement = testArray.get(i)[1];
					String typeSourceElement = elementsTypeMap.get(idSourceElement);
					if (hasOutputSet)
						if (typeSourceElement.equals("bpmn.DataObject")) {
							Element dataOutputRefsElement = doc.createElement("dataOutputRefs");
							outputSetElement.appendChild(dataOutputRefsElement);
							dataOutputRefsElement.appendChild(doc.createTextNode("Dout" + idTarget + idSourceElement));
						}
				}
				ioSpecificationElement.appendChild(outputSetElement);
			}

		}

	}

	private static void setDataOut(Document doc, Element ioSpecificationElement, JSONObject cellsObj) {
		for (int i = 0; i < testArray.size(); i++) {
			String idTarget = testArray.get(i)[2];
			if (idTarget.equals(elementsMap.get(cellsObj.get("id").toString()))) {
				String sourceElementID = testArray.get(i)[1];
				String typesourceElement = elementsTypeMap.get(sourceElementID);
				if (typesourceElement.equals("bpmn.DataObject")) {
					Element dataOutputElement = doc.createElement("dataOutput");
					addAttributeToElement(doc, dataOutputElement, "id",
							"Dout" + testArray.get(i)[2] + testArray.get(i)[1]);
					addAttributeToElement(doc, dataOutputElement, "isCollection", "false");
					ioSpecificationElement.appendChild(dataOutputElement);
				}
			}
		}
	}

	private static void setDataInput(Document doc, Element ioSpecificationElement, JSONObject cellsObj) {
		for (int i = 0; i < testArray.size(); i++) {
			String idSource = testArray.get(i)[1];
			if (idSource.equals(elementsMap.get(cellsObj.get("id").toString()))) {
				String targetElementID = testArray.get(i)[2];
				String typetargetElement = elementsTypeMap.get(targetElementID);
				if (typetargetElement.equals("bpmn.DataObject")) {
					Element dataInputElement = doc.createElement("dataInput");
					addAttributeToElement(doc, dataInputElement, "id",
							"Din" + testArray.get(i)[1] + testArray.get(i)[2]);
					addAttributeToElement(doc, dataInputElement, "isCollection", "false");
					ioSpecificationElement.appendChild(dataInputElement);
				}

			}

		}

	}

	private static void allTagLink(Document doc, Element taskElement, JSONObject cellsObj) {

		for (int i = 0; i < testArray.size(); i++) {
			String idSource = testArray.get(i)[1];
			String idTarget = testArray.get(i)[2];

			if (idTarget == elementsMap.get(cellsObj.get("id").toString())) {
				// recupero l'elemnto source
				String idSourceNew = testArray.get(i)[1];
				// recupero il tipo dell'elemtno target
				String typeSource = elementsTypeMap.get(idSourceNew);
				if (typeSource.equals("bpmn.Message")) {
					addAttributeToElement(doc, taskElement, "messageRef", idSourceNew);
				}
				if (!typeSource.equals("bpmn.Message") && !typeSource.equals("bpmn.DataObject")) {
					// creo un nuovo elemento outgoing
					if (typeSource.equals("bpmn.DataObject")) {
					}
					Element outgoingElement = doc.createElement("outgoing");
					outgoingElement.appendChild(doc.createTextNode(testArray.get(i)[0]));
					taskElement.appendChild(outgoingElement);

				}

			}

			if (idSource.equals(elementsMap.get(cellsObj.get("id").toString()))) {
				// recupero l'elemnto target
				String idTargetNew = testArray.get(i)[2];
				// recupero il tipo dell'elemtno target
				String typeTarget = elementsTypeMap.get(idTargetNew);
				if (typeTarget.equals("bpmn.Message")) {
					addAttributeToElement(doc, taskElement, "messageRef", idTargetNew);
				}
				if (!typeTarget.equals("bpmn.Message") && !typeTarget.equals("bpmn.DataObject")) {
					Element incomingElement = doc.createElement("incoming");
					if (typeTarget.equals("bpmn.DataObject"))

						incomingElement.appendChild(doc.createTextNode(testArray.get(i)[0]));
					taskElement.appendChild(incomingElement);
				}

			}

		}

	}

	private static void defineDataObjectElement(Document doc, Element process, JSONObject cellsObj) {

		Element dataObjectElement = doc.createElement("dataObject");
		addAttributeToElement(doc, dataObjectElement, "id",
				"DO_PROCESS_1" + elementsMap.get(cellsObj.get("id").toString()));
		addAttributeToElement(doc, dataObjectElement, "isCollection", "false");
		JSONObject attributeObject = (JSONObject) cellsObj.get("attrs");
		JSONObject labelObject = (JSONObject) attributeObject.get(".label");
		// elimino dal nome del data Object l'eventuale stato presente
		String textLabel = labelObject.get("text").toString().trim();
		if ((labelObject.get("text").toString()).indexOf("[") > 0)
			textLabel = (labelObject.get("text").toString()).substring(0,
					(labelObject.get("text").toString()).indexOf("["));

		addAttributeToElement(doc, dataObjectElement, "name", textLabel.trim());

		if (!cellsObj.get("dataItemRef").toString().equals(""))
			addAttributeToElement(doc, dataObjectElement, "itemSubjectRef", cellsObj.get("dataItemRef").toString());

		Element dataObjectReferenceElement = doc.createElement("dataObjectReference");
		addAttributeToElement(doc, dataObjectReferenceElement, "dataObjectRef",
				"DO_PROCESS_1" + elementsMap.get(cellsObj.get("id").toString()));
		addAttributeToElement(doc, dataObjectReferenceElement, "id",
				elementsMap.get(cellsObj.get("id").toString()).toString());
		// se contiene uno state allora aggiungo il tag dataState
		process.appendChild(dataObjectElement);
		process.appendChild(dataObjectReferenceElement);
		String dataObjectState = cellsObj.get("dataState").toString();
		if (!dataObjectState.equals("")) {
			Element dataStateElement = doc.createElement("dataState");
			addAttributeToElement(doc, dataStateElement, "name", dataObjectState);

			dataObjectReferenceElement.appendChild(dataStateElement);
		}

	}

	public static void defineFlowElement(Document doc, Element rootElement, JSONObject jsonObject) {

		JSONArray cellsList = (JSONArray) jsonObject.get("cells");
		ArrayList<Integer> targetToElement = new ArrayList<>();
		ArrayList<Integer> targetLinkToElement = new ArrayList<>();

		ArrayList<Integer> sourceToElement = new ArrayList<>();
		ArrayList<Integer> sourceLinkElement = new ArrayList<>();

		Iterator cellsIterator = cellsList.iterator();
		while (cellsIterator.hasNext()) {
			JSONObject cellsObj = (JSONObject) cellsIterator.next();
			if (cellsObj.get("elementType").toString().equals("link")) {

				if (cellsObj.get("linkType").toString().equals("sequence-flow")) {
					Element sequenceFlowElement = doc.createElement("sequenceFlow");
					addAttributeToElement(doc, sequenceFlowElement, "id",
							elementsMap.get(cellsObj.get("id").toString()).toString());
					JSONObject targetObject = (JSONObject) cellsObj.get("target");
					// memorizzo l'id dell'elemento target

					addAttributeToElement(doc, sequenceFlowElement, "targetRef",
							elementsMap.get(targetObject.get("id").toString()).toString());

					JSONObject sourceObject = (JSONObject) cellsObj.get("source");
					addAttributeToElement(doc, sequenceFlowElement, "sourceRef",
							elementsMap.get(sourceObject.get("id").toString()).toString());

					JSONArray labelObject = (JSONArray) cellsObj.get("labels");
					JSONObject labelFirst = (JSONObject) labelObject.get(0);
					JSONObject attrs = (JSONObject) labelFirst.get("attrs");
					JSONObject name = (JSONObject) attrs.get("text");

					addAttributeToElement(doc, sequenceFlowElement, "name", name.get("text").toString());

					sourceToElement = elementTargetMap.get(elementsMap.get(targetObject.get("id").toString()));
					String[] newElementArray = new String[3];
					newElementArray[0] = elementsMap.get(cellsObj.get("id")); // inserisco come primo elemento l'id del
																				// LINK
					newElementArray[1] = elementsMap.get(targetObject.get("id"));
					newElementArray[2] = elementsMap.get(sourceObject.get("id"));
					testArray.add(newElementArray);

					JSONArray labelConditionObject = (JSONArray) cellsObj.get("labels");
					JSONObject labelConditionObjectFirst = (JSONObject) labelConditionObject.get(1);
					JSONObject attrsCondition = (JSONObject) labelConditionObjectFirst.get("attrs");
					JSONObject text = (JSONObject) attrsCondition.get("text");
					String contentText = text.get("text").toString();
					if (!contentText.equals("")) {
						Element conditionExpressionElement = doc.createElement("conditionExpression");
						conditionExpressionElement
								.appendChild(doc.createTextNode(contentText.substring(1, contentText.length() - 1)));
						sequenceFlowElement.appendChild(conditionExpressionElement);
					}
					rootElement.appendChild(sequenceFlowElement);

				}

				if (cellsObj.get("linkType").toString().equals("message-flow")) {
					Element associationElement = doc.createElement("association");
					addAttributeToElement(doc, associationElement, "id",
							elementsMap.get(cellsObj.get("id").toString()).toString());
					JSONObject targetObject = (JSONObject) cellsObj.get("target");
					addAttributeToElement(doc, associationElement, "targetRef",
							elementsMap.get(targetObject.get("id").toString()).toString());

					JSONObject sourceObject = (JSONObject) cellsObj.get("source");
					addAttributeToElement(doc, associationElement, "sourceRef",
							elementsMap.get(sourceObject.get("id").toString()).toString());

					String[] newElementArray = new String[3];
					newElementArray[0] = elementsMap.get(cellsObj.get("id")); // inserisco come primo elemento l'id del
																				// LINK
					newElementArray[1] = elementsMap.get(targetObject.get("id"));
					newElementArray[2] = elementsMap.get(sourceObject.get("id"));
					testArray.add(newElementArray);

					addAttributeToElement(doc, associationElement, "associationDirection", "None");

					rootElement.appendChild(associationElement);
				}

				if (cellsObj.get("linkType").toString().equals("data-flow")) {
					String[] newElementArray = new String[3];
					JSONObject targetObject = (JSONObject) cellsObj.get("target");
					JSONObject sourceObject = (JSONObject) cellsObj.get("source");
					newElementArray[0] = elementsMap.get(cellsObj.get("id")); // inserisco come primo elemento l'id del
																				// LINK
					newElementArray[1] = elementsMap.get(targetObject.get("id"));
					newElementArray[2] = elementsMap.get(sourceObject.get("id"));
					testArray.add(newElementArray);

				}

			}
		}
	}

	public static void main(String[] args) {
		JSONParser parser = new JSONParser();
		Object obj;
		try {
			// obj = parser.parse(new
			// FileReader("/Users/antonellacavaleri/Downloads/testBoundary.json"));
			obj = parser.parse(new FileReader("/Users/antonellacavaleri/Desktop/EmailVoting.json"));
			JSONObject jsonObject = (JSONObject) obj;
			generateXMIFromJSON(jsonObject);
		} catch (FileNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (ParseException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

	}
}
