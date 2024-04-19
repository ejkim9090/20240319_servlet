package temp;

import static kh.mclass.jdbc.common.MybatisTemplate.*;
import java.util.List;

import org.apache.ibatis.session.SqlSession;

import kh.mclass.semim.member.model.dao.MemberDao;
import kh.mclass.semim.member.model.dto.MemberDto;

public class TempService {
	private MemberDao dao = new MemberDao(); 
	
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
