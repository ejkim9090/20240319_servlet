package kh.mclass.common;

import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import javax.xml.parsers.SAXParser;
import javax.xml.parsers.SAXParserFactory;

import org.xml.sax.Attributes;
import org.xml.sax.SAXException;
import org.xml.sax.helpers.DefaultHandler;
import org.xml.sax.helpers.ParserAdapter;

class Item {
	public String Title="";
	public String Link="";	
}

public class AladinXML extends DefaultHandler{
	public List<Item> Items;
	private Item currentItem;
	private boolean inItemElement = false;
	private String tempValue;
	
	public AladinXML() {
		Items  = new ArrayList<Item>();
	}
	
	@Override
	public void startElement(String namespace, String localName, String qName, Attributes atts) {
		System.out.println("startElement: " + localName);
		if (localName.equals("item")) {
			System.out.println("item: " + currentItem);
			currentItem = new Item();
			inItemElement = true;
		} else if (localName.equals("title")) {
			System.out.println("title: " + tempValue);
			tempValue = "";
		} else if (localName.equals("link")) {
			System.out.println("title: " + tempValue);
			tempValue = "";
		}
	}
	
	@Override
	public void characters(char[] ch, int start, int length) throws SAXException{
		System.out.println("characters" + length);

		tempValue = tempValue + new String(ch,start,length);
	}

	@Override
	public void endElement(String namespaceURI, String localName,String qName) {
		System.out.println("endElement"+ namespaceURI);
		if(inItemElement){
			if (localName.equals("item")) {
				System.out.println("item: " + currentItem);
				Items.add(currentItem);
				currentItem = null;
				inItemElement = false;
			} else if (localName.equals("title")) {
				System.out.println("item: " + tempValue);
				currentItem.Title = tempValue;
			} else if (localName.equals("link")) {
				System.out.println("link: " + tempValue);
				currentItem.Link = tempValue;
			}
		}
	}

	public void parseXml(String xmlUrl) throws Exception {
		System.out.println("parseXml" + xmlUrl);
            SAXParserFactory spf = SAXParserFactory.newInstance();
            SAXParser sp = spf.newSAXParser();
            ParserAdapter pa = new ParserAdapter(sp.getParser());
            pa.setContentHandler(this);
			pa.parse(xmlUrl);
	}

	private final String BASE_URL = "http://www.aladdin.co.kr/ttb/api/ItemSearch.aspx?";

	public String GetUrl(String searchWord) throws Exception {
		Map<String,String> hm = new HashMap<String,String>();
		hm.put("ttbkey", "ttbhagalaz04301822001");
		hm.put("Query", URLEncoder.encode(searchWord, "UTF-8"));
		hm.put("QueryType", "Title");
		hm.put("MaxResults", "10");
		hm.put("start", "1");
		hm.put("SearchTarget", "Book");
		hm.put("output", "xml");

		StringBuffer sb = new StringBuffer();
		Iterator<String> iter = hm.keySet().iterator();
		while (iter.hasNext()) {
			String key = iter.next();
			String val  = hm.get(key);
			sb.append(key).append("=").append(val).append("&");
		}

		return BASE_URL + sb.toString();
	}
	public void testAladdinOpenAPI(String searchWord) {
		String url;
		System.out.println("aa1");
		try {
			System.out.println("aa2");
			url = GetUrl(searchWord);
			System.out.println("aa4" + url);
			this.parseXml(url);
		} catch (Exception e) {
			e.printStackTrace();
		}
		System.out.println("aa3");
		for(Item item : this.Items){
			System.out.println(item.Title + " : " + item.Link);
		}
	}
}
