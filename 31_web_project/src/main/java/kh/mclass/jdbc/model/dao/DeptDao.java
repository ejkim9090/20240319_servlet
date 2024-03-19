package kh.mclass.jdbc.model.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import kh.mclass.jdbc.model.vo.Dept;

//import kh.mclass.jdbc.common.JdbcTemplate;
//import static kh.mclass.jdbc.common.JdbcTemplate.close;
import static kh.mclass.jdbc.common.JdbcTemplate.*;

public class DeptDao {
	
	public List<Dept> selectList(Connection conn) {
		String sql = "select * from dept order by deptno desc";
		PreparedStatement pstmt =  null;
		ResultSet rs =  null;
		List<Dept> result = null;
		try {
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			result = new ArrayList<Dept>();
			while(rs.next()) {
				Dept vo = new Dept();
				vo.setDeptno(rs.getInt("deptno"));
				vo.setDname(rs.getString("dname"));
				vo.setLoc(rs.getString("loc"));
				result.add(vo);				
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			close(rs);
			close(pstmt);
		}
		return result;
	}
	
	public int insert(Connection conn, Dept vo) {
		int result = -1;
		String sql = "insert into dept values (?, ?, ?)";
		PreparedStatement pstmt =  null;
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, vo.getDeptno());
			pstmt.setString(2, vo.getDname());
			pstmt.setString(3, vo.getLoc());
			result = pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			close(pstmt);
		}
		System.out.println("dept insert result :" + result);
		return result;
	}
	
	public int delete(Connection conn, int deptno) {
		int result = -1;
		String sql = "delete from dept where deptno = ?";
		PreparedStatement pstmt =  null;
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, deptno);
			result = pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			close(pstmt);
		}
		System.out.println("dept delete result :" + result);
		return result;
	}
	public int deleteByLoc(Connection conn, String loc) {
		int result = -1;
		String sql = "delete from dept where loc = ?";
		PreparedStatement pstmt =  null;
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, loc);
			result = pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			close(pstmt);
		}
		System.out.println("dept delete result :" + result);
		return result;
	}
	
	public int update(Connection conn, Dept vo) {
		int result = 0;
		String sql = "TODO";  // TODO
		PreparedStatement pstmt =  null;
		try {
			pstmt = conn.prepareStatement(sql);
			// TODO
			result = pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			close(pstmt);
		}
		System.out.println("dept result :" + result);
		return result;
	}
	
	
	
	
	
	

}
