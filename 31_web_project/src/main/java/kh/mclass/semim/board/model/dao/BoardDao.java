package kh.mclass.semim.board.model.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import javax.websocket.Session;

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
	public List<FileReadDto> selectFileList(Connection conn, Integer boardId) {
		List<FileReadDto> result = null;
//		(BOARD_ID, BOARD_FILE_ID, SAVED_FILE_PATH_NAME, ORIGINAL_FILENAME)
		String sql = "SELECT BOARD_ID, BOARD_FILE_ID, SAVED_FILE_PATH_NAME, ORIGINAL_FILENAME   FROM BOARD_FILE WHERE BOARD_ID=?";
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			pstmt = conn.prepareStatement(sql);
			// ? 처리
			pstmt.setInt(1, boardId);
			rs = pstmt.executeQuery();
			// ResetSet처리
			if(rs.next()) {
				result = new ArrayList<FileReadDto>();
				do {
					FileReadDto dto = new FileReadDto(	
							rs.getInt("BOARD_ID"),rs.getInt("BOARD_FILE_ID"),
							rs.getString("SAVED_FILE_PATH_NAME"),rs.getString("ORIGINAL_FILENAME")
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
	
	// select list - board reply : board_id
	public List<BoardReplyListDto> selectBoardReplyList(SqlSession session, Integer boardId) {
		return session.selectList("boardns.selectBoardReplyList", boardId);
	}
	
	
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
	public BoardReadDto selectOne(Connection conn, Integer boardId) {
		BoardReadDto result = null;
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
				result = new BoardReadDto(	
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
	
	// insert - Reply 댓글 대댓글
	public int insertRReply(Connection conn, BoardReplyWriteDto dto) {
		int result = 0;  // 1 정상, 0비정상
		String sql = " INSERT INTO BOARD_REPLY VALUES ( (SELECT NVL(MAX(BOARD_REPLY_ID),0)+1 FROM BOARD_REPLY), ?,"
				+ "            ?, ? , default , null, "
				+ "            (SELECT BOARD_REPLY_LEVEL+1 FROM BOARD_REPLY WHERE BOARD_REPLY_ID = ? )  , "
				+ "            (SELECT BOARD_REPLY_REF     FROM BOARD_REPLY WHERE BOARD_REPLY_ID = ? )  , "
				+ "            (SELECT BOARD_REPLY_STEP+1  FROM BOARD_REPLY WHERE BOARD_REPLY_ID = ? )  )";
		PreparedStatement pstmt = null;
		try {
			pstmt = conn.prepareStatement(sql);
			// ? 처리
			pstmt.setInt(1, dto.getBoardId());
			pstmt.setString(2, dto.getBoardReplyWriter());
			pstmt.setString(3, dto.getBoardReplyContent());
			pstmt.setInt(4, dto.getBoardReplyId());
			pstmt.setInt(5, dto.getBoardReplyId());
			pstmt.setInt(6, dto.getBoardReplyId());
			result = pstmt.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		close(pstmt);
		return result;
	}
	
	// insert - Reply 댓글 원본글
	public int insertReply(Connection conn, BoardReplyWriteDto dto) {
		int result = 0;
		String sql = " INSERT INTO BOARD_REPLY VALUES"
				+ "        ( (SELECT NVL(MAX(BOARD_REPLY_ID),0)+1 FROM BOARD_REPLY) , ?, "
				+ "            ?, ? , default , null, "
				+ "            DEFAULT , (SELECT NVL(MAX(BOARD_REPLY_ID),0)+1 FROM BOARD_REPLY), DEFAULT )";
		PreparedStatement pstmt = null;
		try {
			pstmt = conn.prepareStatement(sql);
			// ? 처리
			pstmt.setInt(1, dto.getBoardId());
			pstmt.setString(2, dto.getBoardReplyWriter());
			pstmt.setString(3, dto.getBoardReplyContent());
			result = pstmt.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		close(pstmt);
		return result;
	}
	
	
	// insert
	public int insert(Connection conn, BoardInsertDto dto) {
		System.out.println("boardDao insert() param : "+dto);
		int result = 0;
//		INSERT INTO BOARD VALUES (SEQ_BOARD_ID.nextval, '제목1', '내용1', default, '127.0.0.1', 'kh1', default);
//		String sql = "INSERT INTO BOARD (BOARD_ID,SUBJECT,CONTENT,WRITE_TIME,LOG_IP,BOARD_WRITER,READ_COUNT)"
//				+ " VALUES (SEQ_BOARD_ID.nextval, ?, ?, default, ?, ?, default)";
		String sql = "INSERT ALL ";
		sql+="	INTO BOARD (BOARD_ID,SUBJECT,CONTENT,WRITE_TIME,LOG_IP,BOARD_WRITER,READ_COUNT) ";
		sql+="		VALUES (SEQ_BOARD_ID.nextval, ?, ?, default, ?, ?, default) ";
		if(dto.getFileList()!= null && dto.getFileList().size()>0) {
			for(FileWriteDto filedto :dto.getFileList()) {
		sql+="	INTO BOARD_FILE (BOARD_ID, BOARD_FILE_ID, SAVED_FILE_PATH_NAME, ORIGINAL_FILENAME) ";
		sql+="		VALUES (SEQ_BOARD_ID.nextval, ?, ?, ?) ";
			}
		}
		sql+="	SELECT * FROM DUAL ";
		System.out.println("sql: "+ sql);
		PreparedStatement pstmt = null;
		try {
			pstmt = conn.prepareStatement(sql);
			// ? 처리
			int i = 1;
			pstmt.setString(i++, dto.getSubject());
			pstmt.setString(i++, dto.getContent());
			pstmt.setString(i++, null); //TODO	pstmt.setString(3, dto.getLogIp());
			pstmt.setString(i++, dto.getBoardWriter());
			if(dto.getFileList()!= null && dto.getFileList().size()>0) {
				int fileId = 1;
				for(FileWriteDto filedto :dto.getFileList()) {
					pstmt.setInt(i++, fileId++);
					pstmt.setString(i++, filedto.getFilePath());
					pstmt.setString(i++, filedto.getOrginalFileName());
				}
			}
			result = pstmt.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		close(pstmt);
		System.out.println("boardDao insert() return : "+result);
		return result;
	}
	
	// update - reply Step
	public int updateReplyStep(Connection conn, Integer boardReplyId) {
		System.out.println("boardDao updateReplyStep() param : "+boardReplyId);
		int result = -1;  // 0~n 정상이므로 비정상인경우-1
		String sql = "UPDATE BOARD_REPLY SET BOARD_REPLY_STEP = BOARD_REPLY_STEP+1  WHERE "
				+ "            BOARD_REPLY_REF = ( SELECT BOARD_REPLY_REF FROM BOARD_REPLY WHERE BOARD_REPLY_ID = ?)"
				+ "            AND "
				+ "            BOARD_REPLY_STEP > ( SELECT BOARD_REPLY_STEP FROM BOARD_REPLY WHERE BOARD_REPLY_ID = ? )";
		PreparedStatement pstmt = null;
		try {
			pstmt = conn.prepareStatement(sql);
			// ? 처리
			pstmt.setInt(1, boardReplyId);
			pstmt.setInt(2, boardReplyId);
			result = pstmt.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		close(pstmt);
		System.out.println("boardDao updateReplyStep() return : "+result);
		return result;
	}
	// update - readCount
	public int updateReadCount(Connection conn, Integer boardId) {
		int result = 0;
		String sql = "update board set read_count=read_count+1 where board_id=?";  //TODO
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
