package kh.mclass.semim.member.model.service;

import static kh.mclass.jdbc.common.JdbcTemplate.*;
import java.sql.Connection;
import java.util.List;

import kh.mclass.semim.member.model.dao.MemberDao;
import kh.mclass.semim.member.model.dto.MemberDto;

public class MemberService {
	private MemberDao dao = new MemberDao(); 
	
	// select list - all
	public List<MemberDto> selectAllList() {
		List<MemberDto> result = null;
		Connection conn = getSemiConnection(true);
		result = dao.selectAllList(conn);
		close(conn);
		return result;
	}
	// select one
	public MemberDto selectOne(String memId) {
		MemberDto result = null;
		Connection conn = getSemiConnection(true);
		result = dao.selectOne(conn, memId);
		close(conn);
		return result;
	}
	// insert
	public int insert(MemberDto dto) {
		int result = 0;
		Connection conn = getSemiConnection(true);
		result = dao.insert(conn, dto);
		close(conn);
		return result;
	}
	// update
	public int update(MemberDto dto) {
		int result = 0;
		Connection conn = getSemiConnection(true);
		result = dao.update(conn, dto);
		close(conn);
		return result;
	}
	// delete
	public int delete(String memId) {
		int result = 0;
		Connection conn = null;
		result = dao.delete(conn, memId);
		close(conn);
		return result;
	}
}
