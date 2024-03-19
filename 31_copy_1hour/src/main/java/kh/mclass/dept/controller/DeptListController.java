package kh.mclass.dept.controller;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import kh.mclass.dept.model.service.DeptService;
import kh.mclass.dept.model.vo.Dept;

/**
 * Servlet implementation class DeptListController
 */
@WebServlet("/dept/list")
public class DeptListController extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String sessionScopeValue = (String)request.getSession().getAttribute("sessionScope");
		//request.getSession().removeAttribute("sessionScope");
		DeptService service = new DeptService();
		List<Dept> result = service.selectList();
		request.setAttribute("volist", result);
		request.getRequestDispatcher("/views/dept/list.jsp").forward(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
