package kh.mclass.dept.model.service;

import static kh.mclass.jdbc.JdbcTemplate.*;

import java.sql.Connection;
import java.util.List;

import kh.mclass.dept.model.dao.DeptDao;
import kh.mclass.dept.model.vo.Dept;

public class DeptService {
	private DeptDao dao = new DeptDao();
	public List<Dept> selectList(){
		List<Dept> result = null;
		Connection conn = getConnection();
		result = dao.selectList(conn);
		close(conn);
		return result;
	}
	public Dept selectOne(int deptno){
		Dept result = null;
		Connection conn = getConnection();
		result = dao.selectOne(conn, deptno);
		close(conn);
		return result;
	}
	public int insert(Dept vo){
		int result = -1;
		Connection conn = getConnection();
		result = dao.insert(conn, vo);
		close(conn);
		return result;
	}
	public int delete(int deptno){
		int result = -1;
		Connection conn = getConnection();
		result = dao.delete(conn, deptno);
		close(conn);
		return result;
	}
	public int update(Dept vo){
		int result = -1;
		Connection conn = getConnection();
		result = dao.update(conn, vo);
		close(conn);
		return result;
	}
}
