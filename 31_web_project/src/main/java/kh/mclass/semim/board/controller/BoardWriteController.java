package kh.mclass.semim.board.controller;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import kh.mclass.semim.board.model.dto.BoardDto;
import kh.mclass.semim.board.model.dto.BoardInsertDto;
import kh.mclass.semim.board.model.dto.BoardListDto;
import kh.mclass.semim.board.model.service.BoardService;
import kh.mclass.semim.member.model.dto.MemberInfoDto;

/**
 * Servlet implementation class BoardListController
 */
@WebServlet("/board/write")
public class BoardWriteController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private BoardService service = new BoardService();
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public BoardWriteController() {
        super();
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		String prePage = (String)request.getSession().getAttribute("prePage");
		if(prePage!= null && prePage.equals("write")) {
			request.getSession().removeAttribute("prePage");
		}
		request.getRequestDispatcher("/WEB-INF/views/semi/board/write.jsp").forward(request, response);
	}
	
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		System.out.println("/board/write doPost()");
		String subject = req.getParameter("subject");
		String content = req.getParameter("content");
		MemberInfoDto memberInfoDto = (MemberInfoDto)req.getSession().getAttribute("sssLogin"); 
		System.out.println(subject);
		System.out.println(content);
//		BoardInsertDto dto = new BoardInsertDto(subject, content, memberInfoDto.getMemId());
		BoardInsertDto dto = new BoardInsertDto(subject, content, "kh1");  //TODO
		int result = service.insert(dto);
		resp.sendRedirect(req.getContextPath()+"/board/list");
	}
}
