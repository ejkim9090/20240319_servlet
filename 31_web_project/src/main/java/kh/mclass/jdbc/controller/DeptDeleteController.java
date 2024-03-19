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
 * Servlet implementation class DeptDeleteController
 */
@WebServlet("/dept/delete")
public class DeptDeleteController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		DeptService service =new DeptService();

		// ?no=52&a=10&b=안녕하세요~ hi! everyone.&loc=seoul
		// ?no=&a=10&b=안녕하세요~ hi! everyone.&loc=seoul
		// ?no&a=10&b=안녕하세요~ hi! everyone.&loc=seoul
		// ?a=10&b=안녕하세요~ hi! everyone.&loc=seoul
		//5. 데이터 수신
		String noStr = request.getParameter("no");
		String a = request.getParameter("a");
		String b = request.getParameter("b");
		String loc = request.getParameter("loc");
		int result = -1;
		if(noStr != null && !noStr.equals("")) {
			int deptno = Integer.parseInt(noStr);
			result = service.delete(deptno);
		} else if(loc != null && !loc.equals("")) {
			result = service.deleteByLoc(loc);
		}
		
		if(result > 0 ) {
			// url /deptlist 이동. 즉 DeptController - doGet() 호출됨.
			response.sendRedirect(request.getContextPath()+"/deptlist");
			
//			List<Dept> volist = service.selectList();
//			request.setAttribute("volist", volist);
//			request.getRequestDispatcher("/views/deptlist.jsp").forward(request, response);
		}else {
			// TODO HTML 학습 후 추가 이동방법
			request.setAttribute("msg", "해당하는 dept 부서가 없어 삭제하지 못했습니다.");
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
