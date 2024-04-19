package kh.mclass.semim.board.model.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.RowBounds;
import org.apache.ibatis.session.SqlSession;

import static kh.mclass.jdbc.common.JdbcTemplate.close;

import kh.mclass.semim.board.model.dto.BoardDto;
import kh.mclass.semim.board.model.dto.BoardInsertDto;
import kh.mclass.semim.board.model.dto.BoardListDto;
import kh.mclass.semim.board.model.dto.BoardReadDto;
import kh.mclass.semim.board.model.dto.BoardReplyListDto;
import kh.mclass.semim.board.model.dto.BoardReplyWriteDto;
import kh.mclass.semim.board.model.dto.FileReadDto;
import kh.mclass.semim.board.model.dto.FileWriteDto;

public class BoardDao {
	// select list - all
	public List<FileReadDto> selectFileList(SqlSession session, Integer boardId) {
		return session.selectList("boardMapper.selectFileList",boardId );
	}
	
	// select list - board reply : board_id
	public List<BoardReplyListDto> selectBoardReplyList(SqlSession session, Integer boardId) {
		return session.selectList("boardMapper.selectBoardReplyList", boardId);
	}
	
	// select total Count
	public Integer selectTotalCount(SqlSession session) {
		return session.selectOne("boardMapper.selectTotalCount");
	}
	
	public List<BoardListDto> selectPageListRowBounds(SqlSession session,int pageSize,  int currentPageNum) {
		int offset = (currentPageNum - 1) * pageSize;
		RowBounds rbounds = new RowBounds( offset , pageSize);
		return session.selectList("boardMapper.selectPageList", null, rbounds);
	}
	
	// select list - all
	public List<BoardListDto> selectPageList(SqlSession session, int start, int end) {
		Map<String, Integer> param = new HashMap<String, Integer>();
		param.put("startRownum", start);
		param.put("endRownum", end);
		return session.selectList("boardMapper.selectPageList", param);
	}
	
	// select list - all
	public List<BoardListDto> selectAllList(SqlSession session) {
		return session.selectList("boardMapper.selectAllList");
	}
	// select one
	public BoardReadDto selectOne(SqlSession session, Integer boardId) {
		return session.selectOne("boardMapper.selectOne", boardId);
	}
	
	// select 
	public Integer getSequenceNum(SqlSession session) {
		return session.selectOne("boardMapper.getSequenceNum");
	}
	
	// insert - Reply 댓글 대댓글
	public int insertRReply(SqlSession session, BoardReplyWriteDto dto) {
		return session.insert("boardMapper.insertRReply", dto);
	}
	
	// insert - Reply 댓글 원본글
	public int insertReply(SqlSession session, BoardReplyWriteDto dto) {
		return session.insert("boardMapper.insertReply", dto);
	}
	
	// insert
	public int insert(SqlSession session, BoardInsertDto dto) {
		return session.insert("boardMapper.insert", dto);
	}
	
	// update - reply Step
	public int updateReplyStep(SqlSession session, Integer boardReplyId) {
		return session.update("boardMapper.updateReplyStep", boardReplyId);
	}
	// update - readCount
	public int updateReadCount(SqlSession session, Integer boardId) {
		return session.update("boardMapper.updateReadCount", boardId);
	}
	// update
	public int update(SqlSession session, BoardDto dto) {
		int result = 0;
		//TODO
		return result;
	}
	// delete
	public int delete(SqlSession session, Integer boardId) {
		return session.delete("boardMapper.delete", boardId);
	}
	
}
