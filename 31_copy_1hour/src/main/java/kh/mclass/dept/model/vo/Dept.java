package kh.mclass.dept.model.vo;

public class Dept {
//	SQL> desc dept;
//	 이름                                      널?      유형
//	 ----------------------------------------- -------- ----------------------------
//	 DEPTNO                                    NOT NULL NUMBER(2)
//	 DNAME                                              VARCHAR2(14)
//	 LOC                                                VARCHAR2(13)
	
	private int deptno;
	private String dname;
	private String loc;
	public Dept() {
		super();
	}
	public Dept(int deptno, String dname, String loc) {
		super();
		this.deptno = deptno;
		this.dname = dname;
		this.loc = loc;
	}
	@Override
	public String toString() {
		return "Dept [deptno=" + deptno + ", dname=" + dname + ", loc=" + loc + "]";
	}
	public int getDeptno() {
		return deptno;
	}
	public void setDeptno(int deptno) {
		this.deptno = deptno;
	}
	public String getDname() {
		return dname;
	}
	public void setDname(String dname) {
		this.dname = dname;
	}
	public String getLoc() {
		return loc;
	}
	public void setLoc(String loc) {
		this.loc = loc;
	}
	
}
