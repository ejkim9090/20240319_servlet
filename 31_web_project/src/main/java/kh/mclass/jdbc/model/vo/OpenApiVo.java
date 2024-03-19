package kh.mclass.jdbc.model.vo;

public class OpenApiVo {
//	결과코드	resultCode	2	필수	00	결과코드
//	결과메시지	resultMsg	50	필수	NORMAL SERVICE	결과메시지
//	한 페이지 결과 수	numOfRows	4	필수	100	한 페이지 결과 수
//	페이지 번호	pageNo	4	필수	1	페이지번호
//	전체 결과 수	totalCount	4	필수	40	전체 결과 수
//	목록	items	0	옵션	-	목록
//	측정소명	stationName	30	필수	중구	측정소명
//	측정망 정보	mangName	10	필수	도시대기	측정망 정보(도시대기, 도로변대기, 국가배경농도, 교외대기, 항만)
//	측정일시	dataTime	20	필수	2020-11-25 11:00	오염도 측정 연-월-일 시간:분
//	아황산가스 농도	so2Value	10	필수	0.007	아황산가스 농도(단위: ppm)
//	일산화탄소 농도	coValue	10	필수	0.7	일산화탄소 농도(단위: ppm)
//	오존 농도	o3Value	10	필수	0.043	오존 농도(단위: ppm)
//	이산화질소 농도	no2Value	10	필수	0.043	이산화질소 농도(단위: ppm)
//	미세먼지(PM10) 농도	pm10Value	10	필수	68	미세먼지(PM10) 농도(단위: ug/m3)
//	미세먼지(PM10) 24시간 예측이동농도	pm10Value24	10	필수	56	미세먼지(PM10) 24시간 예측이동농도(단위: ug/m3)
//	초미세먼지(PM2.5) 농도	pm25Value	10	필수	39	초미세먼지(PM2.5) 농도(단위: ug/m3)
//	초미세먼지(PM2.5) 농도24시간 예측이동농도	pm25Value24	10	필수	26	초미세먼지(PM2.5) 농도24시간 예측이동농도(단위: ug/m3)
//	통합대기환경수치	khaiValue	10	필수	76	통합대기환경수치
//	통합대기환경지수	khaiGrade	10	필수	2	통합대기환경지수
//	아황산가스 지수	so2Grade	10	필수	1	아황산가스 지수
//	일산화탄소 지수	coGrade	10	필수	1	일산화탄소 지수
//	오존 지수	o3Grade	10	필수	2	오존 지수
//	이산화질소 지수	no2Grade	10	필수	2	이산화질소 지수
//	미세먼지(PM10) 24시간 등급자료	pm10Grade	10	필수	2	미세먼지(PM10) 24시간 등급자료
//	초미세먼지(PM2.5) 24시간 등급자료	pm25Grade	10	필수	2	초미세먼지(PM2.5) 24시간 등급자료
//	미세먼지(PM10) 1시간 등급자료	pm10Grade1h	10	필수	2	미세먼지(PM10) 1시간 등급자료
//	초미세먼지(PM2.5) 1시간 등급자료	pm25Grade1h	10	필수	2	초미세먼지(PM2.5) 1시간 등급자료
//	아상산가스 플래그	so2Flag	10	필수	장비점검	측정자료 상태정보(점검및교정, 장비점검, 자료이상, 통신장애)
//	일산화탄소 플래그	coFlag	10	필수	장비점검	측정자료 상태정보(점검및교정, 장비점검, 자료이상, 통신장애)
//	오존 플래그	o3Flag	10	필수	자료이상	측정자료 상태정보(점검및교정, 장비점검, 자료이상, 통신장애)
//	이산화질소 플래그	no2Flag	10	필수	통신장애	측정자료 상태정보(점검및교정, 장비점검, 자료이상, 통신장애)
//	미세먼지(PM10) 플래그	pm10Flag	10	필수	점검및교정	측정자료 상태정보(점검및교정, 장비점검, 자료이상, 통신장애)
//	초미세먼지(PM2.5) 플래그	pm25Flag	10	필수	점검및교정	측정자료 상태정보(점검및교정, 장비점검, 자료이상, 통신장애)

		private String stationName;
	private String dataTime;
	private String pm10Value;
	private String so2Value;
	private String so2Grade;
	public OpenApiVo() {
		super();
	}

	public OpenApiVo(String stationName, String dataTime, String pm10Value, String so2Value, String so2Grade) {
		super();
		this.stationName = stationName;
		this.dataTime = dataTime;
		this.pm10Value = pm10Value;
		this.so2Value = so2Value;
		this.so2Grade = so2Grade;
	}

	@Override
	public String toString() {
		return "OpenApiVo [stationName=" + stationName + ", dataTime=" + dataTime + ", pm10Value=" + pm10Value
				+ ", so2Value=" + so2Value + ", so2Grade=" + so2Grade + "]";
	}

	public String getStationName() {
		return stationName;
	}

	public void setStationName(String stationName) {
		this.stationName = stationName;
	}

	public String getDataTime() {
		return dataTime;
	}

	public void setDataTime(String dataTime) {
		this.dataTime = dataTime;
	}

	public String getPm10Value() {
		return pm10Value;
	}

	public void setPm10Value(String pm10Value) {
		this.pm10Value = pm10Value;
	}

	public String getSo2Value() {
		return so2Value;
	}

	public void setSo2Value(String so2Value) {
		this.so2Value = so2Value;
	}

	public String getSo2Grade() {
		return so2Grade;
	}

	public void setSo2Grade(String so2Grade) {
		this.so2Grade = so2Grade;
	}
	
	
	
}
