package kh.mclass.jdbc.controller;

import java.io.IOException;
import java.util.Arrays;
import java.util.Enumeration;
import java.util.List;
import java.util.Map;
import java.util.Set;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import kh.mclass.jdbc.model.service.DeptService;
import kh.mclass.jdbc.model.vo.Dept;

/**
 * Servlet implementation class DeptInsertController
 */
@WebServlet("/dept/insert")
public class DeptInsertController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
//		
//		response.getWriter().write("<html>");
//		
		
		//request Method 들 확인
		System.out.println("====request.getParameterNames()+switch - 예) 카테로그별 검색 잡코리아 경력/지역/연봉/알바.... ===");
		Enumeration<String> enumNames = request.getParameterNames();
		System.out.println(enumNames);
		while(enumNames.hasMoreElements()) {
			String name = enumNames.nextElement();
//			switch(name) {
//			}
			System.out.println(request.getParameter(name));
		}
		System.out.println("====request.getParameterValues()+Arrays.asList()함께 - 레시피 재료들... 선호장르선택 ===");
		// ?... &genre=a1&genre=b1&genre=c1
		String[] genreArr = request.getParameterValues("genre");
		List<String> genreList = Arrays.asList(genreArr);
		System.out.println(genreList);
		System.out.println("===============");
		System.out.println("====request.getParameterMap() ===");
		// ?... &genre=a1&genre=b1&genre=c1
		Map<String, String[]> paramMap = request.getParameterMap();
		Set<String> keyset = paramMap.keySet();
		for(String key : keyset) {
			String[] valueArr = paramMap.get(key);
			List<String> valueList = Arrays.asList(valueArr);
			System.out.println(key + ":" + valueList);
		}
		System.out.println("===============");
		// ?no=61&dname=a&loc=seoul
		//5. 데이터 수신
		String noStr = request.getParameter("no");
		String dname = request.getParameter("dname");
		String loc = request.getParameter("loc");
		
		int deptno = Integer.parseInt(noStr);
		
		DeptService service = new DeptService();

		Dept vo = new Dept(deptno, dname, loc);
		//2. Service - Dao 호출
		int result = service.insert(vo);
		
		if(result > 0 ) {
			//4. url (타프로젝트, naver.com... ) 페이지 이동 request.getContextPath() 와 함께 /deptlist 이동. 즉 DeptController - doGet() 호출됨.
			// response 해버리므로 request.setAttribute("msg", "ㅋㅋㅋㅋ"); 은 전혀 전달되지 못함.
			request.getSession().setAttribute("sessionScope", "session scope는 브라우저닫힐때까지 or removeAttr");
			response.sendRedirect(request.getContextPath()+"/deptlist?n1=v1");
			
//			List<Dept> volist = service.selectList();
			//3. view 에 데이터 전달
//			request.setAttribute("volist", volist);
			//1. view 선택 
//			request.getRequestDispatcher("/views/deptlist.jsp").forward(request, response);
		}else {
			// TODO HTML 학습 후 추가 이동방법
			request.setAttribute("msg", "부서를 추가하지 못했습니다. 행정팀에 문의해주세요.");
			request.getRequestDispatcher("/views/errorPage.jsp").forward(request, response);
		}
	
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
