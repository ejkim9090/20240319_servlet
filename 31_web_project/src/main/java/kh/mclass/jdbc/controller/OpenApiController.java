package kh.mclass.jdbc.controller;

import java.io.FileReader;
import java.io.IOException;
import java.util.List;
import java.util.Map;
import java.util.Properties;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import kh.mclass.jdbc.common.JdbcTemplate;
import kh.mclass.jdbc.model.vo.OpenApiVo;
import kh.mclass.model.service.OpenApiService;

/**
 * Servlet implementation class OpenApiController
 */
@WebServlet("/openapi")
public class OpenApiController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private OpenApiService service = new OpenApiService();
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public OpenApiController() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		Properties prop = new Properties();
		prop.load(new FileReader(JdbcTemplate.class.getResource("./").getPath() + "driver.properties"));
		System.out.println(prop.getProperty("openapi.serviceKey.common"));
		request.setAttribute("serviceKey", prop.getProperty("openapi.serviceKey.common"));
		request.getRequestDispatcher("/WEB-INF/views/semi/openapi.jsp").forward(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String lawdCd = request.getParameter("lawdCd");
		String dealYMD = request.getParameter("dealYMD");
//		String fileDir = request.getSession().getServletContext().getRealPath("files");
		String fileDir = "c:/workspace/files";
		service.getCommonOpenApi(lawdCd, dealYMD, fileDir);
		response.sendRedirect(request.getContextPath()+"/openapi");
	}

}
