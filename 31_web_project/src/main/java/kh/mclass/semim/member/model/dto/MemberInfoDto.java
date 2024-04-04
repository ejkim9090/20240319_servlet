package kh.mclass.semim.member.model.dto;

public class MemberInfoDto {
//	MEMBER
//	MEM_ID    NOT NULL VARCHAR2(20)  
//	MEM_PWD   NOT NULL VARCHAR2(20)  
//	MEM_EMAIL NOT NULL VARCHAR2(100) 
	private String memId;
	private String memEmail;
	@Override
	public String toString() {
		return "MemberDto [memId=" + memId + ", memEmail=" + memEmail + "]";
	}
	public MemberInfoDto(String memId, String memEmail) {
		super();
		this.memId = memId;
		this.memEmail = memEmail;
	}

	public String getMemId() {
		return memId;
	}
	public String getMemEmail() {
		return memEmail;
	}
}
