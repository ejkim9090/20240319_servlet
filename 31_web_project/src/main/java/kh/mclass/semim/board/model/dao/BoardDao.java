package kh.mclass.semim.board.model.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import static kh.mclass.jdbc.common.JdbcTemplate.close;

import kh.mclass.semim.board.model.dto.BoardDto;
import kh.mclass.semim.board.model.dto.BoardInsertDto;
import kh.mclass.semim.board.model.dto.BoardListDto;

public class BoardDao {
	
	// select total Count
	public int selectTotalCount(Connection conn) {
		int result = 0;
		String sql = "select count(*) cnt from board";
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			pstmt = conn.prepareStatement(sql);
			// ? 처리
			rs = pstmt.executeQuery();
			// ResetSet처리
			if(rs.next()) {
				result = rs.getInt("cnt");
			}	
		} catch (SQLException e) {
			e.printStackTrace();
		}
		close(rs);
		close(pstmt);
		return result;
	}
	// select list - all
	public List<BoardListDto> selectPageList(Connection conn, int start, int end) {
		List<BoardListDto> result = null;
		String sql = "select t2.*"
				+"   from (select t1.*, rownum rn" 
			    +"       from (SELECT BOARD_ID, SUBJECT,CONTENT,WRITE_TIME,LOG_IP,BOARD_WRITER,READ_COUNT    FROM BOARD order by board_id desc) t1 ) t2"
			    +"   where rn between ?   and ?"
			    ;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			pstmt = conn.prepareStatement(sql);
			// ? 처리
			pstmt.setInt(1, start);//한페이지당글수*(현재페이지-1)+1
			pstmt.setInt(2, end);//한페이지당글수*(현재페이지)
			rs = pstmt.executeQuery();
			// ResetSet처리
			if(rs.next()) {
				result = new ArrayList<BoardListDto>();
				do {
					BoardListDto dto = new BoardListDto(	
							rs.getInt("BOARD_ID"),rs.getString("SUBJECT"),
							rs.getString("WRITE_TIME"),rs.getString("BOARD_WRITER"),
							rs.getInt("READ_COUNT")
							);
					result.add(dto);
				}while (rs.next());
			}	
		} catch (SQLException e) {
			e.printStackTrace();
		}
		close(rs);
		close(pstmt);
		return result;
	}
	
	
	
	// select list - all
	public List<BoardListDto> selectAllList(Connection conn) {
		List<BoardListDto> result = null;
		String sql = "SELECT BOARD_ID, SUBJECT,CONTENT,WRITE_TIME,LOG_IP,BOARD_WRITER,READ_COUNT    FROM BOARD";
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			pstmt = conn.prepareStatement(sql);
			// ? 처리
			rs = pstmt.executeQuery();
			// ResetSet처리
			if(rs.next()) {
				result = new ArrayList<BoardListDto>();
				do {
					BoardListDto dto = new BoardListDto(	
							rs.getInt("BOARD_ID"),rs.getString("SUBJECT"),
							rs.getString("WRITE_TIME"),rs.getString("BOARD_WRITER"),
							rs.getInt("READ_COUNT")
							);
					result.add(dto);
				}while (rs.next());
			}	
		} catch (SQLException e) {
			e.printStackTrace();
		}
		close(rs);
		close(pstmt);
		return result;
	}
	// select one
	public BoardDto selectOne(Connection conn, Integer boardId) {
		BoardDto result = null;
		String sql = "SELECT BOARD_ID,SUBJECT,CONTENT,WRITE_TIME,LOG_IP,BOARD_WRITER,READ_COUNT    FROM BOARD WHERE BOARD_ID=?";
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			pstmt = conn.prepareStatement(sql);
			// ? 처리
			pstmt.setInt(1, boardId);
			rs = pstmt.executeQuery();
			// ResetSet처리
			if(rs.next()) {
				result = new BoardDto(	
						rs.getInt("BOARD_ID"),rs.getString("SUBJECT"),rs.getString("CONTENT"),
						rs.getString("WRITE_TIME"),rs.getString("LOG_IP"),rs.getString("BOARD_WRITER"),
						rs.getInt("READ_COUNT")
						);
			}			
		} catch (SQLException e) {
			e.printStackTrace();
		}
		close(rs);
		close(pstmt);
		return result;
	}
	
	// select 
	public int getSequenceNum(Connection conn) {
		int result = 0;
		String sql = "SELECT SEQ_BOARD_ID.nextval FROM DUAL";
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			pstmt = conn.prepareStatement(sql);
			// ? 처리
			rs = pstmt.executeQuery();
			// ResetSet처리
			if(rs.next()) {
				result = rs.getInt(1);
			}			
		} catch (SQLException e) {
			e.printStackTrace();
		}
		close(rs);
		close(pstmt);
		return result;
	}
	
	// insert
	public int insert(Connection conn, BoardInsertDto dto, int sequencNum) {
		int result = 0;
//		INSERT INTO BOARD VALUES (SEQ_BOARD_ID.nextval, '제목1', '내용1', default, '127.0.0.1', 'kh1', default);
		String sql = "INSERT INTO BOARD (BOARD_ID,SUBJECT,CONTENT,WRITE_TIME,LOG_IP,BOARD_WRITER,READ_COUNT)"
				+ " VALUES (?, ?, ?, default, ?, ?, default)";
		PreparedStatement pstmt = null;
		try {
			pstmt = conn.prepareStatement(sql);
			// ? 처리
			pstmt.setInt(1, sequencNum);
			pstmt.setString(2, dto.getSubject());
			pstmt.setString(3, dto.getContent());
//			pstmt.setString(4, dto.getLogIp());
			pstmt.setString(4, null);
			pstmt.setString(5, dto.getBoardWriter());
			result = pstmt.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		close(pstmt);
		return result;
	}
	// update
	public int update(Connection conn, BoardDto dto) {
		int result = 0;
		String sql = "";  //TODO
		PreparedStatement pstmt = null;
		try {
			pstmt = conn.prepareStatement(sql);
			// ? 처리
			result = pstmt.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		close(pstmt);
		return result;
	}
	// delete
	public int delete(Connection conn, Integer boardId) {
		int result = 0;
		String sql = "DELETE FROM BOARD WHERE BOARD_ID=?";
		PreparedStatement pstmt = null;
		try {
			pstmt = conn.prepareStatement(sql);
			// ? 처리
			pstmt.setInt(1, boardId);
			result = pstmt.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		close(pstmt);
		return result;
	}
	
}
