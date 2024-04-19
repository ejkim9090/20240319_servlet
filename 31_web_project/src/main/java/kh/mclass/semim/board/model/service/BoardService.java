package kh.mclass.semim.board.model.service;


import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;

import static kh.mclass.jdbc.common.MybatisTemplate.*;
import kh.mclass.semim.board.model.dao.BoardDao;
import kh.mclass.semim.board.model.dto.BoardDto;
import kh.mclass.semim.board.model.dto.BoardInsertDto;
import kh.mclass.semim.board.model.dto.BoardListDto;
import kh.mclass.semim.board.model.dto.BoardReadDto;
import kh.mclass.semim.board.model.dto.BoardReplyListDto;
import kh.mclass.semim.board.model.dto.BoardReplyWriteDto;
import kh.mclass.semim.board.model.dto.FileReadDto;

public class BoardService {
	private BoardDao dao = new BoardDao(); 
	
	public Map<String, Object> selectPageListMybatis(int pageSize, int pageBlockSize, int currentPageNum) {
		Map<String, Object> result = null;
		SqlSession session = getSqlSession();
		List<BoardListDto> boardList = dao.selectPageListRowBounds(session, pageSize, currentPageNum);
		session.close();
		return result;
	}
	// select list - all
	public Map<String, Object> selectPageList(int pageSize, int pageBlockSize, int currentPageNum) {
		Map<String, Object> result = null;
		
		SqlSession session = getSqlSession();
		
		System.out.println("currentPageNum: " +currentPageNum);
		int start = pageSize*(currentPageNum-1)+1;
		int end = pageSize*currentPageNum;
		
//		--- 총글개수 103
//		select count(*) cnt from board;
		int totalCount = dao.selectTotalCount(session);
		System.out.println("totalCount:"+totalCount);
//		-- 전체페이지수  = ceil(총글개수/한페이지당글수) = (총글개수%한페이지당글수== 0)?(총글개수/한페이지당글수):(총글개수/한페이지당글수+1) 
//		int totalPageCount = (int)Math.ceil(totalCount/(double)pageSize);
		int totalPageCount = (totalCount % pageSize == 0)? totalCount/pageSize :  totalCount/pageSize+1;
		
//		-- 시작페이지 startPageNum = (현재페이지%페이지수 == 0) ? ((현재페이지/페이지수)-1)*페이지수 + 1  :((현재페이지/페이지수))*페이지수 + 1
//		-- 끝페이지 endPageNum =  (endPageNum > 전체페이지수) ? 전체페이지수 : startPageNum+페이지수 - 1;
		int startPageNum = (currentPageNum%pageBlockSize == 0) ? ((currentPageNum/pageBlockSize)-1)*pageBlockSize + 1  :((currentPageNum/pageBlockSize))*pageBlockSize + 1;
		int endPageNum = (startPageNum+pageBlockSize > totalPageCount) ? totalPageCount : startPageNum+pageBlockSize-1;
		
		List<BoardListDto> dtolist = dao.selectPageList(session, start, end);
		session.close();
		
		result = new HashMap<String, Object>();
		result.put("dtolist", dtolist);
		result.put("totalPageCount", totalPageCount);
		result.put("startPageNum", startPageNum);
		result.put("endPageNum", endPageNum);
		result.put("currentPageNum", currentPageNum);
		System.out.println("selectPageList() : "+result);
		return result;
	}
	
	
	// select list - board reply
	public List<BoardReplyListDto> selectBoardReplyList(Integer boardId) {
		List<BoardReplyListDto> result = null;
		SqlSession session = getSqlSession(true);
		result = dao.selectBoardReplyList(session, boardId);
//		session.commit();
//		session.rollback();
		session.close();
		return result;
	}
	
	// select list - all
	public List<BoardListDto> selectAllList() {
		List<BoardListDto> result = null;
		SqlSession session = getSqlSession();
		result = dao.selectAllList(session);
		session.close();
		return result;
	}
	// select one
	public BoardReadDto selectOne(Integer boardId) {
		BoardReadDto result = null;
		SqlSession session = getSqlSession();
		result = dao.selectOne(session, boardId);
		if(result != null) {
			dao.updateReadCount(session, boardId);
		}
		List<FileReadDto> filelist = dao.selectFileList(session, boardId);	
		result.setFiledtolist(filelist);
		
		// ajax 대체
//		List<BoardReplyListDto> replylist = dao.selectBoardReplyList(session, boardId);	
//		result.setReplydtolist(replylist);
		session.close();
		return result;
	}
	
	
	
	// insert - boardreply
	public int insertReply(BoardReplyWriteDto dto) {
		int result = 0;
		int resultupdate = 0;
		SqlSession session = getSqlSession(false);
		if(dto.getBoardReplyId() != 0) {
			resultupdate = dao.updateReplyStep(session, dto.getBoardReplyId());
			if(resultupdate > -1) {
				result = dao.insertRReply(session, dto);
			}
		} else {
			result = dao.insertReply(session, dto);
		}
		if(resultupdate > -1 && result > 0) {
			session.commit();
		}else {
			session.rollback();
		}
		session.close();
		return result;
	}
	// insert
	public int insert(BoardInsertDto dto) {
		int result = 0;
		SqlSession session = getSqlSession();
		result = dao.insert(session, dto);
		session.close();
		return result;
	}
	// update
	public int update(BoardDto dto) {
		int result = 0;
		SqlSession session = getSqlSession();
		result = dao.update(session, dto);
		session.close();
		return result;
	}
	// delete
	public int delete(Integer boardId) {
		int result = 0;
		SqlSession session = getSqlSession();
		result = dao.delete(session, boardId);
		session.close();
		return result;
	}
}
