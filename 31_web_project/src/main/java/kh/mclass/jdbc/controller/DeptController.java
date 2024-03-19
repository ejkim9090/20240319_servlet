package kh.mclass.jdbc.controller;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import kh.mclass.jdbc.model.service.DeptService;
import kh.mclass.jdbc.model.vo.Dept;

/**
 * Servlet implementation class DeptController
 */
@WebServlet("/deptlist")
public class DeptController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public DeptController() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		// Controller 역할
		//2. Service - Dao 호출
		DeptService service  = new DeptService();
		List<Dept> result = service.selectList();
		System.out.println("===나오나....===");
		System.out.println(result);
		if(result == null) {
			//4. url 페이지 이동 또는 
			
			//3. view 에 데이터 전달
			req.setAttribute("msg", "부서조회를 할 수 없습니다. 잠시 후 시스템 확인 후 다시 시도해 주세요.");
			//1. view 선택 
			req.getRequestDispatcher("/views/errorPage.jsp").forward(req, res);	
		} else {
			//3. view 에 데이터 전달
			req.setAttribute("volist", result);
			req.setAttribute("deptList", result);
			req.setAttribute("salgradList", result);
			req.setAttribute("data2", "컨트롤러에서 jsp-view로 값 전달.. ");
			req.setAttribute("data3", 2005);
			//1. view 선택 
			//request.getRequestDispatcher("/a.jsp").forward(request, response);
//			req.getRequestDispatcher("/views/deptlist.jsp").forward(req, res);
			req.getRequestDispatcher("/views/cwsong_comment.jsp").forward(req, res);
		}
		
		// view 역할을 JSP 파일에서 함.
//		response.getWriter().append("Served at: hello Servlet~!~~~").append(request.getContextPath());
//		response.getWriter().append("Hello Web Project!")
//		.append("<br>")
//		.append("		<h1>제목1</h1>")
//		.append("<table>");
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
