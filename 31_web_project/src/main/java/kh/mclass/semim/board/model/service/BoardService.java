package kh.mclass.semim.board.model.service;


import static kh.mclass.jdbc.common.JdbcTemplate.*;
import java.sql.Connection;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import kh.mclass.semim.board.model.dao.BoardDao;
import kh.mclass.semim.board.model.dto.BoardDto;
import kh.mclass.semim.board.model.dto.BoardInsertDto;
import kh.mclass.semim.board.model.dto.BoardListDto;

public class BoardService {
	private BoardDao dao = new BoardDao(); 
	
	// select totalCount - conn을 재연결 하지 않도록 함.
//	public int selectTotalCount() {
//		int result = 0;
//		Connection conn = getSemiConnection(true);
//		result = dao.selectTotalCount(conn);
//		close(conn);
//		return result;
//	}
	
	
	// select list - all
	public Map<String, Object> selectPageList(int pageSize, int pageBlockSize, int currentPageNum) {
		Map<String, Object> result = null;
		
		Connection conn = getSemiConnection(true);
		System.out.println("currentPageNum: " +currentPageNum);
		int start = pageSize*(currentPageNum-1)+1;
		int end = pageSize*currentPageNum;
//		select t2.*
//		from (select t1.*, rownum rn from (SELECT BOARD_ID, SUBJECT,CONTENT,WRITE_TIME,LOG_IP,BOARD_WRITER,READ_COUNT    FROM BOARD order by board_id desc) t1 ) t2
//		--where rn between 한페이지당글수*(현재페이지-1)+1   and 한페이지당글수*(현재페이지)
//		;
		
//		--- 총글개수 103
//		select count(*) cnt from board;
		int totalCount = dao.selectTotalCount(conn);
		System.out.println("totalCount:"+totalCount);
//		-- 전체페이지수  = ceil(총글개수/한페이지당글수) = (총글개수%한페이지당글수== 0)?(총글개수/한페이지당글수):(총글개수/한페이지당글수+1) 
//		int totalPageCount = (int)Math.ceil(totalCount/(double)pageSize);
		int totalPageCount = (totalCount % pageSize == 0)? totalCount/pageSize :  totalCount/pageSize+1;
		
//		-- 시작페이지 startPageNum = (현재페이지%페이지수 == 0) ? ((현재페이지/페이지수)-1)*페이지수 + 1  :((현재페이지/페이지수))*페이지수 + 1
//		-- 끝페이지 endPageNum =  (endPageNum > 전체페이지수) ? 전체페이지수 : startPageNum+페이지수 - 1;
		int startPageNum = (currentPageNum%pageBlockSize == 0) ? ((currentPageNum/pageBlockSize)-1)*pageBlockSize + 1  :((currentPageNum/pageBlockSize))*pageBlockSize + 1;
		int endPageNum = (startPageNum+pageBlockSize > totalPageCount) ? totalPageCount : startPageNum+pageBlockSize-1;
				
		List<BoardListDto> dtolist = dao.selectPageList(conn, start, end);
		close(conn);
		
		result = new HashMap<String, Object>();
		result.put("dtolist", dtolist);
		result.put("totalPageCount", totalPageCount);
		result.put("startPageNum", startPageNum);
		result.put("endPageNum", endPageNum);
		result.put("currentPageNum", currentPageNum);
		System.out.println("selectPageList() : "+result);
		return result;
	}
	
	
	// select list - all
	public List<BoardListDto> selectAllList() {
		List<BoardListDto> result = null;
		Connection conn = getSemiConnection(true);
		result = dao.selectAllList(conn);
		close(conn);
		return result;
	}
	// select one
	public BoardDto selectOne(Integer boardId) {
		BoardDto result = null;
		Connection conn = getSemiConnection(true);
		result = dao.selectOne(conn, boardId);
		close(conn);
		return result;
	}
	// insert
	public int insert(BoardInsertDto dto) {
		int result = 0;
		Connection conn = getSemiConnection(true);
		int sequencNum = dao.getSequenceNum(conn);
		result = dao.insert(conn, dto, sequencNum);
		close(conn);
		return sequencNum;
	}
	// update
	public int update(BoardDto dto) {
		int result = 0;
		Connection conn = getSemiConnection(true);
		result = dao.update(conn, dto);
		close(conn);
		return result;
	}
	// delete
	public int delete(Integer boardId) {
		int result = 0;
		Connection conn = null;
		result = dao.delete(conn, boardId);
		close(conn);
		return result;
	}
}
