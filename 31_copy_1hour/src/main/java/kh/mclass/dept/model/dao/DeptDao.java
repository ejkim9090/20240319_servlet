package kh.mclass.dept.model.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import kh.mclass.dept.model.vo.Dept;
import static kh.mclass.jdbc.JdbcTemplate.close;

public class DeptDao {
	public List<Dept> selectList(Connection conn){
		List<Dept> result = null;
		String sql = "select * from dept";
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			result = new ArrayList<Dept>();
			while(rs.next()) {
				Dept vo = new Dept();
				vo.setDeptno(rs.getInt("Deptno"));
				vo.setDname(rs.getString("dname"));
				vo.setLoc(rs.getString("loc"));
				result.add(vo);
			}
		}catch (Exception e) {
			e.printStackTrace();
		}finally {
			close(rs);
			close(pstmt);
		}
		return result;
	}
	public Dept selectOne(Connection conn, int deptno){
		Dept result = null;
		String sql = "select * from dept where deptno=?";
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, deptno);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				result = new Dept();
				result.setDeptno(rs.getInt("Deptno"));
				result.setDname(rs.getString("dname"));
				result.setLoc(rs.getString("loc"));
			}
		}catch (Exception e) {
			e.printStackTrace();
		}finally {
			close(rs);
			close(pstmt);
		}
		return result;
	}
	public int insert(Connection conn, Dept vo){
		int result = -1;
		String sql = "insert into dept values(?,?,?)";
		PreparedStatement pstmt = null;
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, vo.getDeptno());
			pstmt.setString(2, vo.getDname());
			pstmt.setString(3, vo.getLoc());
			result = pstmt.executeUpdate();
		}catch (Exception e) {
			e.printStackTrace();
		}finally {
			close(pstmt);
		}
		return result;
	}
	public int delete(Connection conn, int deptno){
		int result = -1;
		String sql = "delete from dept where deptno=?";
		PreparedStatement pstmt = null;
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, deptno);
			result = pstmt.executeUpdate();
		}catch (Exception e) {
			e.printStackTrace();
		}finally {
			close(pstmt);
		}
		return result;
	}
	public int update(Connection conn, Dept vo){
		int result = -1;
		String sql = "TODO";// TODO
		PreparedStatement pstmt = null;
		try {
			pstmt = conn.prepareStatement(sql);
			//TODO
			result = pstmt.executeUpdate();
		}catch (Exception e) {
			e.printStackTrace();
		}finally {
			close(pstmt);
		}
		return result;
	}
}
