package kh.mclass.semim.board.controller;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;

import kh.mclass.semim.board.model.dto.BoardReplyListDto;
import kh.mclass.semim.board.model.dto.BoardReplyWriteDto;
import kh.mclass.semim.board.model.service.BoardService;

/**
 * Servlet implementation class BoardReplyWriteController
 */
@WebServlet("/board/reply/write.ajax")
public class BoardReplyWriteController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private BoardService service = new BoardService(); 
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public BoardReplyWriteController() {
        super();
        // TODO Auto-generated constructor stub
    }


	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		System.out.println("/board/reply/write.ajax doPost()");
		String boardReplyIdStr = request.getParameter("boardReplyId");
		int boardReplyId = 0;
		String boardIdStr = request.getParameter("boardId");
		int boardId = 0;
		String boardReplyContent = request.getParameter("boardReplyContent");
		// TODO LOGIN
		String boardReplyWriter = "kh3";  //TODO
		String boardReplyLogIp = null;  // TODO
		
		Gson gson = new Gson();
		
		if(boardIdStr == null || boardIdStr.equals("")) {
			response.getWriter().append("-1");
			return;
		}
		if(boardIdStr != null && !boardIdStr.equals("")) {
			try {
				boardId = Integer.parseInt(boardIdStr);
			}catch (NumberFormatException e) {
				response.getWriter().append("-1");
				return;
			}
		}
		if(boardReplyIdStr != null && !boardReplyIdStr.equals("")) {
			try {
				boardReplyId = Integer.parseInt(boardReplyIdStr);
			}catch (NumberFormatException e) {
				response.getWriter().append("-1");
				return;
			}
		}
		if(boardReplyIdStr == null || boardReplyIdStr.equals("")) {
			// 댓글 원본으로 간주함.
			boardReplyId = 0;
		}
		BoardReplyWriteDto dto = new BoardReplyWriteDto(boardReplyId, boardId, boardReplyWriter, boardReplyContent, boardReplyLogIp);
		System.out.println(dto);
		int result = service.insertReply(dto);
//		response.getWriter().append(String.valueOf(result));
		if(result > 0) {
			List<BoardReplyListDto> replydtolist = service.selectBoardReplyList(boardId);
			response.getWriter().append(gson.toJson(replydtolist));
		}
	}

}
