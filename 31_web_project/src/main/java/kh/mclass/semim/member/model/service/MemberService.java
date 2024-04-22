package kh.mclass.semim.member.model.service;

import static kh.mclass.jdbc.common.MybatisTemplate.*;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileReader;
import java.io.IOException;
import java.util.List;
import java.util.Properties;

import org.apache.ibatis.session.SqlSession;

import kh.mclass.semim.member.model.dao.MemberDao;
import kh.mclass.semim.member.model.dto.MemberDto;
import kh.mclass.semim.member.model.dto.MemberInfoDto;
import kh.mclass.semim.member.model.dto.MemberLoginDto;

public class MemberService {
	private MemberDao dao = new MemberDao(); 
	
	// select Login get Info
	public MemberInfoDto loginGetInfo(MemberLoginDto dto) {
		MemberInfoDto result = null;
		SqlSession session = getSqlSession();
		result = dao.loginGetInfo(session, dto);
		session.close();
		return result;
	}
	// select Login
	public int login(MemberLoginDto dto) {
		// TODO Test
		Properties prop1 =  new Properties();
		Properties prop2 =  new Properties();
		Properties prop3 =  new Properties();
		try {
			prop1.load(new BufferedReader(new FileReader("/db.properties")));
			prop2.load(new BufferedReader(new FileReader("/WEB-INF/classes/db.properties")));
			prop2.load(new BufferedReader(new FileReader("/WEB-INF/classes/db.properties")));
			
		} catch (FileNotFoundException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		} finally {
			prop1.clear();
			prop2.clear();
			prop3.clear();
		}
		
		
		int result = 0;
		SqlSession session = getSqlSession();
		result = dao.login(session, dto);
		session.close();
		return result;
	}
	
	// select checkId
	public int selectCheckId(String memId) {
		int result = 0;
		SqlSession session = getSqlSession();
		result = dao.selectCheckId(session, memId);
		session.close();
		return result;
	}
	
	// select list - all
	public List<MemberDto> selectAllList() {
		List<MemberDto> result = null;
		SqlSession session = getSqlSession();
		result = dao.selectAllList(session);
		session.close();
		return result;
	}
	// select one
	public MemberDto selectOne(String memId) {
		MemberDto result = null;
		SqlSession session = getSqlSession();
		result = dao.selectOne(session, memId);
		session.close();
		return result;
	}
	// insert
	public int insert(MemberDto dto) {
		int result = 0;
		SqlSession session = getSqlSession();
		result = dao.insert(session, dto);
		session.close();
		return result;
	}
	// update
	public int update(MemberDto dto) {
		int result = 0;
		SqlSession session = getSqlSession();
		result = dao.update(session, dto);
		session.close();
		return result;
	}
	// delete
	public int delete(String memId) {
		int result = 0;
		SqlSession session = getSqlSession();
		result = dao.delete(session, memId);
		session.close();
		return result;
	}
}
