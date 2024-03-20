package kh.mclass.model.service;

import java.io.InputStreamReader;
import java.io.PrintWriter;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Properties;

import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;
import javax.xml.parsers.ParserConfigurationException;

import org.w3c.dom.Document;
import org.w3c.dom.Node;
import org.w3c.dom.NodeList;
import org.xml.sax.SAXException;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.fasterxml.jackson.dataformat.xml.XmlMapper;
import com.google.gson.Gson;

import kh.mclass.jdbc.common.JdbcTemplate;
import kh.mclass.jdbc.model.vo.OpenApiVo;

import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.File;
import java.io.FileReader;
import java.io.FileWriter;
import java.io.IOException;
import java.io.InputStream;

//http://apis.data.go.kr/B552584/ArpltnInforInqireSvc/getCtprvnRltmMesureDnsty
public class OpenApiService {
	// openapi.serviceKey.ArpltnInforInqireSvc
	private Properties prop = new Properties();
	private String searchArg1;
	private String searchArg2;
	private String fileDir;


	public void getCommonOpenApi(String searchArg1, String searchArg2 , String fileDir) throws IOException  {
		String basedUrl = "http://openapi.molit.go.kr/OpenAPI_ToolInstallPackage/service/rest/RTMSOBJSvc/getRTMSDataSvcAptTradeDev";
//		String type = "json";
		String type = "xml";
		boolean fileSaveOption = true;
		if(fileSaveOption) {
			this.searchArg1 = searchArg1;
			this.searchArg2 = searchArg2;
			this.fileDir = fileDir;
		}

		prop.load(new FileReader(JdbcTemplate.class.getResource("./").getPath() + "driver.properties"));
		System.out.println(JdbcTemplate.class.getResource("./").getPath() + "driver.properties");
		StringBuilder urlBuilder = new StringBuilder(basedUrl); /* URL */
		urlBuilder.append("?" + URLEncoder.encode("serviceKey", "UTF-8") + "=" + URLEncoder.encode(prop.getProperty("openapi.serviceKey.common"), "UTF-8")); 
//		urlBuilder.append("&" + URLEncoder.encode("returnType", "UTF-8") + "=" + URLEncoder.encode("json", "UTF-8")); /* xml 또는 json */
		urlBuilder.append("&" + URLEncoder.encode("pageNo", "UTF-8") + "=" + URLEncoder.encode("1", "UTF-8")); 
		urlBuilder.append("&" + URLEncoder.encode("numOfRows", "UTF-8") + "=" + URLEncoder.encode("10", "UTF-8")); 
		urlBuilder.append("&" + URLEncoder.encode("LAWD_CD", "UTF-8") + "=" + URLEncoder.encode(searchArg1, "UTF-8")); 
		urlBuilder.append("&" + URLEncoder.encode("DEAL_YMD", "UTF-8") + "=" + URLEncoder.encode(searchArg2, "UTF-8")); 

		System.out.println(urlBuilder.toString());
		StringBuilder sb = send(urlBuilder, "json", fileSaveOption);
		System.out.println(sb.toString());	
		
		
		Map<String, Object> map = null;
		switch(type.toLowerCase()) {
		case "json":
			map = getMapByJson(sb);
			break;
		case "xml":
			map = getMapByXml(sb);
			break;
		}
// TODO
		
	}
	
	private StringBuilder send(StringBuilder urlBuilder, String type, boolean fileSaveOption) throws IOException  {
		URL url = new URL(urlBuilder.toString());
		HttpURLConnection conn = (HttpURLConnection) url.openConnection();
		conn.setRequestMethod("GET");
		conn.setRequestProperty("Content-type", "application/json");
		System.out.println("Response code: " + conn.getResponseCode());

		// 방법 1 
		BufferedReader rd;
		if (conn.getResponseCode() >= 200 && conn.getResponseCode() <= 300) {
			rd = new BufferedReader(new InputStreamReader(conn.getInputStream()));
		} else {
			rd = new BufferedReader(new InputStreamReader(conn.getErrorStream()));
		}
		
		PrintWriter bw = null;
		System.out.println("========");
		System.out.println(fileDir);
		if(fileSaveOption) {
			File path = new File(fileDir);
			if(!path.exists()) { path.mkdirs(); }  // 경로 존재여부 확인 - 경로 생성
			File file = new File(fileDir+"/"+searchArg1+"_"+searchArg2+".xml");
			bw =new PrintWriter(new FileWriter(file));
		}
		
		StringBuilder sb = new StringBuilder();
		String line;
		while ((line = rd.readLine()) != null) {
			bw.println(line);
			sb.append(line);
		}
		rd.close();
		bw.flush();
		bw.close();
		conn.disconnect();

		return sb;
	}

	public Map<String, Object> getMapByJson(StringBuilder sb) throws IOException {
		
		Map<String, Object> map = new HashMap<String, Object>();
		Gson gson = new Gson();
		map = gson.fromJson(sb.toString(), map.getClass());
		System.out.println(map);
//		System.out.println(gson.toJson(map));

		// 참고용
		Map<String, Object> map1 = (Map<String, Object>)map.get("response");
		System.out.println(map1);
		Map<String, Object> map2 = (Map<String, Object>)map1.get("body");
		System.out.println(map2);
		System.out.println(map2.get("items"));
		List<String> listItems = (List<String>)map2.get("items");
		System.out.println(listItems);
//		List<Map<String, Object>> listItems = (List<Map<String, Object>>)((Map<String, Object>)((Map<String, Object>)map.get("response")).get("body")).get("items");
//		System.out.println(listItems);
		ObjectMapper mapper = new ObjectMapper();
		for(String item : listItems) {
			System.out.println(item);
			//TODO

//			OpenApiVo vo = mapper.readValue(item, OpenApiVo.class);
		}

		return map;
	}

	public Map<String, Object> getMapByXml(StringBuilder xml) throws IOException {
		Map<String, Object> map = null;
//		XmlMapper xmlMapper = new XmlMapper();
//		xmlMapper.readValue(conn.getInputStream(), Map.class);
//TODO
		
		return map;
		
		
		
		
		// 방법 2 - a - conn --> InputStream --> Xml --> Document( HTMLXML) --> item 들 -->
		// node들을 하나씩 읽기
		// parseXML(conn.getInputStream())를 사용해 Document doc 생성
//		Document doc = parseXML(is);
//
//		// item 들을 NodeList nodelist 담기
//		NodeList nodelist = doc.getElementsByTagName("item");

		
		// 참고용
//		List<OpenApiVo> volist = null;
//		// item 데이터가 없다면 바로 null return;
//		if (nodelist.getLength() < 1) {
//			return volist;
//		}
//
//		// item 데이터가 있다면
//		volist = new ArrayList<OpenApiVo>();
//		
//		for (int i = 0; i < nodelist.getLength(); i++) {
//			OpenApiVo vo = new OpenApiVo();
//			Node item = nodelist.item(i);
//			Node n = item.getFirstChild();
//			while (n != null) {
//				String nodeName = n.getNodeName();
//				String nodeText = n.getTextContent();
//				System.out.println(nodeName + " : " + nodeText);
//				switch (nodeName) {
//				case "stationName":
//					vo.setStationName(nodeText);
//					break;
//				case "dataTime":
//					vo.setDataTime(nodeText);
//					break;
//				case "pm10Value":
//					vo.setPm10Value(nodeText);
//					break;
//				case "so2Value":
//					vo.setSo2Value(nodeText);
//					break;
//				case "so2Grade":
//					vo.setSo2Grade(nodeText);
//					break;
//				}
//				n = n.getNextSibling();
//			}
//			volist.add(vo);
//		}
//
//		return volist;
	}

	// xml to Java parse / Object
	private Document parseXML(InputStream stream) {
		DocumentBuilderFactory objDocumentBuilderFactory = DocumentBuilderFactory.newInstance();
		DocumentBuilder objDocumentBuilder = null;
		Document result = null;
		try {
			objDocumentBuilder = objDocumentBuilderFactory.newDocumentBuilder();
			result = objDocumentBuilder.parse(stream);
		} catch (ParserConfigurationException e) {
			e.printStackTrace();
		} catch (SAXException e) { // Simple API for XML
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}
		return result;
	}
}
