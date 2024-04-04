package kh.mclass.semim.member.model.dto;

public class MemberUpdateDto {
//	MEMBER
//	MEM_ID    NOT NULL VARCHAR2(20)  
//	MEM_PWD   NOT NULL VARCHAR2(20)  
//	MEM_EMAIL NOT NULL VARCHAR2(100) 
	private String memId;
	private String memPwd;
	private String memPwdNew;
	private String memEmail;
	@Override
	public String toString() {
		return "MemberUpdateDto [memId=" + memId + ", memPwd=" + memPwd + ", memPwdNew=" + memPwdNew + ", memEmail="
				+ memEmail + "]";
	}
	public MemberUpdateDto(String memId, String memPwd, String memPwdNew, String memEmail) {
		super();
		this.memId = memId;
		this.memPwd = memPwd;
		this.memPwdNew = memPwdNew;
		this.memEmail = memEmail;
	}
	public String getMemId() {
		return memId;
	}
	public String getMemPwd() {
		return memPwd;
	}
	public String getMemPwdNew() {
		return memPwdNew;
	}
	public String getMemEmail() {
		return memEmail;
	}
	
	
}
