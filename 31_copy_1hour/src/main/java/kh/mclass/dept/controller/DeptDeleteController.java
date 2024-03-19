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
 * Servlet implementation class DeptDeleteController
 */
@WebServlet("/dept/delete")
public class DeptDeleteController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// ?deptno=71
		String deptnoStr = request.getParameter("deptno");
		request.getParameterValues("n5");
		int deptno = 0;
		try {
			deptno = Integer.parseInt(deptnoStr);
		} catch (NumberFormatException e) {
			e.printStackTrace();
		}
		if(deptno != 0) {
			int result = new DeptService().delete(deptno);
			if(result > 0) {
				response.sendRedirect(request.getContextPath()+"/dept/list");
			} else {
				request.setAttribute("msg", "DEPT에 없는 항목으로 삭제하지 못했습니다.");
				request.getRequestDispatcher("/views/error/errorPage.jsp").forward(request, response);
			}
		} else {
			request.setAttribute("msg", "DEPT에서 삭제하지 못했습니다.");
			request.getRequestDispatcher("/views/error/errorPage.jsp").forward(request, response);
		}
	}

}
