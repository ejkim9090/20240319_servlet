package kh.mclass.semim.member.model.dao;

import java.util.ArrayList;
import java.util.List;

import org.apache.ibatis.session.SqlSession;

import kh.mclass.semim.member.model.dto.MemberDto;
import kh.mclass.semim.member.model.dto.MemberInfoDto;
import kh.mclass.semim.member.model.dto.MemberLoginDto;

public class MemberDao {

	// select one login
	public MemberInfoDto loginGetInfo(SqlSession session, MemberLoginDto dto) {
		return session.selectOne("memberMapper.loginGetInfo", dto);
	}
	// select one login
	public int login(SqlSession session, MemberLoginDto dto) {
		return session.selectOne("memberMapper.login", dto);
	}
	// select one check id
	public int selectCheckId(SqlSession session, String memId) {
		return session.selectOne("memberMapper.selectCheckId", memId);
	}
	
	// select list - all
	public List<MemberDto> selectAllList(SqlSession session) {
		return session.selectList("memberMapper.selectAllList");
	}
	
	// select one
	public MemberDto selectOne(SqlSession session, String memId) {
		return session.selectOne("memberMapper.selectOne", memId);
	}
	// insert
	public int insert(SqlSession session, MemberDto dto) {
		return session.insert("memberMapper.insert", dto);
	}
	// update
	public int update(SqlSession session, MemberDto dto) {
		int result = 0;
		//TODO
		return result;
	}
	// delete
	public int delete(SqlSession session, String memId) {
		return session.delete("memberMapper.delete", memId);
	}
	
}
