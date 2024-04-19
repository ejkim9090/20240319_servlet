package temp;


import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import org.apache.ibatis.session.SqlSession;

import static kh.mclass.jdbc.common.JdbcTemplate.close;
import kh.mclass.semim.member.model.dto.MemberDto;

public class TempDao {

	// select list - all
	public List<MemberDto> selectAllList(SqlSession session) {
		System.out.println("TempDao selectAllList() p: " + "");
		return session.selectList("memberMapper.selectAllList");
	}
	
	// select one
	public MemberDto selectOne(SqlSession session, String memId) {
		System.out.println("TempDao selectOne() p: " + memId);
		return session.selectOne("memberMapper.selectOne", memId);
	}
	// insert
	public int insert(SqlSession session, MemberDto dto) {
		System.out.println("TempDao insert() p: " + dto);
		return session.insert("memberMapper.insert", dto);
	}
	// update
	public int update(SqlSession session, MemberDto dto) {
		System.out.println("TempDao update() p: " + dto);
		int result = 0;
		//TODO
		return result;
	}
	// delete
	public int delete(SqlSession session, String memId) {
		System.out.println("TempDao update() p: " + memId);
		return session.delete("memberMapper.delete", memId);
	}
	
}
