package kh.mclass.dept.controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import kh.mclass.dept.model.service.DeptService;
import kh.mclass.dept.model.vo.Dept;

/**
 * Servlet implementation class DeptInsertController
 */
@WebServlet("/dept/insert")
public class DeptInsertController extends HttpServlet {
	private static final long serialVersionUID = 1L;

//	protected void doGet(HttpServletRequest request, HttpServletResponse response)
//			throws ServletException, IOException {
//// 텅
//	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// ?deptno=71&dname=aaa&loc=seoul
		String deptnoStr = request.getParameter("deptno");
		String dname = request.getParameter("dname");
		String loc = request.getParameter("loc");
		int deptno = 0;
		try {
			deptno = Integer.parseInt(deptnoStr);
		} catch (NumberFormatException e) {
			e.printStackTrace();
		}
		if (deptno != 0) {
			Dept vo = new Dept(deptno, dname, loc);
			int result = new DeptService().insert(vo);
			if (result > 0) {
				response.sendRedirect(request.getContextPath() + "/dept/list");
			} else {
				request.setAttribute("msg", "DEPT에 추가하지 못했습니다.");
				request.getRequestDispatcher("/views/error/errorPage.jsp").forward(request, response);
			}
		} else {
			request.setAttribute("msg", "DEPT에 추가하지 못했습니다.");
			request.getRequestDispatcher("/views/error/errorPage.jsp").forward(request, response);
		} 
	}

}
