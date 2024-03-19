package kh.mclass.jdbc.model.dao;
// Data Access Object

import java.sql.Connection;
import java.sql.Date;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import kh.mclass.jdbc.model.vo.Emp;

public class EmpDao {
	public List<Emp> selectListStatement() {
		Connection conn = null;
		Statement stmt = null;
		ResultSet rset = null;
		List<Emp> empList = null;
		int searchDeptno = 20;
		String sql = "select * from emp where empno  "+ searchDeptno;
		try {
			Class.forName("oracle.jdbc.driver.OracleDriver");
			conn = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:XE", "scott", "TIGER");
			if(conn != null) System.out.println("연결성공"); else System.out.println("연결실패!!!!!!!!!");
			stmt = conn.createStatement();
			rset = stmt.executeQuery(sql);
			////// List 생성
			empList = new ArrayList<Emp>();   // size : 0
			while(rset.next()) {
				////// Emp 생성
				Emp emp = new Emp();
				////// Emp 객체 값채우기
				emp.setEmpno(rset.getInt("eMpNo"));
				emp.setComm(rset.getDouble("Comm"));
				emp.setDeptno(rset.getInt("Deptno"));
				emp.setEname(rset.getString("ename"));
				emp.setHiredate(rset.getDate("Hiredate"));
				emp.setJob(rset.getString("Job"));
				emp.setMgr(rset.getInt("Mgr"));
				emp.setSal(rset.getDouble("Sal"));
				/////// List 객체 값채우기
				empList.add(emp);
				/////////////// 
			}
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			try {
				if(rset!=null)rset.close();
				if(stmt!=null)stmt.close();
				if(conn!=null)conn.close();
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		return empList;
	}
	
	
	public List<Emp> selectList() {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		List<Emp> empList = null;
		int searchDeptno = 10;
		String sql = "select * from emp where deptno = "+searchDeptno;
//		String sql = "select * from emp where deptno = ?";
		try {
			Class.forName("oracle.jdbc.driver.OracleDriver");
			conn = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:XE", "scott", "TIGER");
			if(conn != null) System.out.println("연결성공"); else System.out.println("연결실패!!!!!!!!!");
			pstmt = conn.prepareStatement(sql);
			//pstmt 생성 후 ?위치홀더 에 값 채우기
//			pstmt.setInt(1, searchDeptno);
			//executeXxxx() 전에 ?위치홀더 에 값 채우기
			rset = pstmt.executeQuery();
			////// List 생성
			empList = new ArrayList<Emp>();   // size : 0
			while(rset.next()) {
				////// Emp 생성
				Emp emp = new Emp();
				////// Emp 객체 값채우기
				emp.setEmpno(rset.getInt("eMpNo"));
				emp.setComm(rset.getDouble("Comm"));
				emp.setDeptno(rset.getInt("Deptno"));
				emp.setEname(rset.getString("ename"));
				emp.setHiredate(rset.getDate("Hiredate"));
				emp.setJob(rset.getString("Job"));
				emp.setMgr(rset.getInt("Mgr"));
				emp.setSal(rset.getDouble("Sal"));
				/////// List 객체 값채우기
				empList.add(emp);
				/////////////// 
			}
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			try {
				if(rset!=null)rset.close();
				if(pstmt!=null)pstmt.close();
				if(conn!=null)conn.close();
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		return empList;
	}
	public void insertEmpStatement(Emp emp) {
		Connection conn = null;
		Statement stmt = null;
		String sql = "insert into emp "
				+ "(EMPNO,	ENAME, JOB, MGR, "
				+ "  HIREDATE, SAL, COMM, DEPTNO ) "
				+ " values "
				+ "("+emp.getEmpno()+", '"+emp.getEname()+"', '"+emp.getJob()+"' , "+emp.getMgr()+","
						+ " SYSDATE, "+emp.getSal()+", "+emp.getComm()+", "+emp.getDeptno()+" )";
		try {
			Class.forName("oracle.jdbc.driver.OracleDriver");
			conn = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:XE", "scott", "TIGER");
			if(conn != null) System.out.println("연결성공"); else System.out.println("연결실패!!!!!!!!!");
			stmt = conn.createStatement();
			System.out.println(emp);
			int result = stmt.executeUpdate(sql);
			System.out.println("결과 확인"+ result);
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			try {
				if(stmt!= null) stmt.close(); 
				if(conn!= null) conn.close(); 
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
	}
	public int insert(Emp emp) {
		Connection conn = null;
		PreparedStatement pstmt = null;//?위치홀더 사용가능 
		int result = -1;  // 오류 
		String sql = "insert into emp (EMPNO,ENAME, JOB, MGR,HIREDATE, SAL, COMM, DEPTNO) "
				+ " 			values (?,?,?,?,SYSDATE,?,?,?)";  
//		String sql = "insert into emp "
//				+ "(EMPNO,	ENAME, JOB, MGR, "
//				+ "  HIREDATE, SAL, COMM, DEPTNO ) "
//				+ " values "
//				+ "("+emp.getEmpno()+", '  " + emp.getEname() + "', '"+emp.getJob()+"' , "+emp.getMgr()+","
//						+ " SYSDATE, "+emp.getSal()+", "+emp.getComm()+", "+emp.getDeptno()+" )";
		try {
			Class.forName("oracle.jdbc.driver.OracleDriver");
			conn = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:XE", "scott", "TIGER");
			if(conn != null) System.out.println("연결성공"); else System.out.println("연결실패!!!!!!!!!");
			//conn.setAutoCommit(false);
			pstmt = conn.prepareStatement(sql);
			//pstmt 생성 후 ?위치홀더 에 값 채우기
			pstmt.setInt(1, emp.getEmpno());
			pstmt.setString(2, emp.getEname());
			pstmt.setString(3, emp.getJob());
			pstmt.setInt(4, emp.getMgr());
			pstmt.setDouble(5, emp.getSal());
			pstmt.setDouble(6, emp.getComm());
			pstmt.setInt(7, emp.getDeptno());
			//executeXxxx() 전에 ?위치홀더 에 값 채우기
			result = pstmt.executeUpdate();
//			System.out.println("결과 확인"+ result);
//			if(result > 0) {
//				conn.commit();
//			} else {
//				conn.rollback();
//			}
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			try {
				if(pstmt!= null) pstmt.close(); 
				if(conn!= null) conn.close(); 
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		return result;
	}
	public void deleteEmp() {
		
	}
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
}
