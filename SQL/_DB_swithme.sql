-----------과목 시간 합계 리스트 --
SELECT RECORD_SUBJECT_ID
,(SELECT SUBJECT_NAME from SUBJECT where SUBJECT_ID=RECORD_SUBJECT_ID) AS SUBJECT_NAME
--, SUBSTR(NUMTODSINTERVAL( SUM( CAST(RECORD_END as DATE) - CAST(RECORD_START as DATE) ), 'day' ), 12, 8) as DIFFTIME
from RECORD
where RECORD_MEM_ID ='won' 
--    and to_char(RECORD_START, 'yyyymmdd') =  to_char(SYSDATE, 'yyyymmdd')
GROUP BY CUBE(RECORD_SUBJECT_ID)
;
SELECT SUBJECT_ID, SUBJECT_NAME 
    -- 여기 시간
from SUBJECT 
where MEM_ID ='won'
;
SELECT RECORD_SUBJECT_ID
, SUBSTR(NUMTODSINTERVAL( SUM( CAST(RECORD_END as DATE) - CAST(RECORD_START as DATE) ), 'day' ), 12, 8) as DIFFTIME
from RECORD
where RECORD_MEM_ID ='won' 
    and to_char(RECORD_START, 'yyyymmdd') =  to_char(SYSDATE, 'yyyymmdd')
GROUP BY CUBE(RECORD_SUBJECT_ID)
;

SELECT SUBJECT_ID, SUBJECT_NAME 
    -- 여기 시간
    , (
    SELECT SUBSTR(NUMTODSINTERVAL( SUM( CAST(RECORD_END as DATE) - CAST(RECORD_START as DATE) ), 'day' ), 12, 8) 
    from RECORD
    where RECORD_MEM_ID = 'won'
        and to_char(RECORD_START, 'yyyymmdd') =  to_char(SYSDATE, 'yyyymmdd')
        and SUBJECT_ID = RECORD_SUBJECT_ID
    ) DIFFTIME
from SUBJECT 
where MEM_ID ='won'
union
SELECT null, null
    -- 여기 시간
    , SUBSTR(NUMTODSINTERVAL( SUM( CAST(RECORD_END as DATE) - CAST(RECORD_START as DATE) ), 'day' ), 12, 8)  as DIFFTIME
from RECORD 
where RECORD_MEM_ID = 'won'
        and to_char(RECORD_START, 'yyyymmdd') =  to_char(SYSDATE, 'yyyymmdd')
;

select SUBJECT_ID, SUBJECT_NAME ,DIFFTIME  
from 
(
SELECT SUBJECT_ID, SUBJECT_NAME 
from SUBJECT 
where MEM_ID ='won'
) t1 
full join 
(
SELECT RECORD_SUBJECT_ID, SUBSTR(NUMTODSINTERVAL( SUM( CAST(RECORD_END as DATE) - CAST(RECORD_START as DATE) ), 'day' ), 12, 8) as DIFFTIME
from RECORD 
where RECORD_MEM_ID = 'won'
        and to_char(RECORD_START, 'yyyymmdd') =  to_char(SYSDATE, 'yyyymmdd')
group by cube(RECORD_SUBJECT_ID)
) t2
on (SUBJECT_ID = RECORD_SUBJECT_ID)
;



SELECT T2.*  FROM   
(SELECT T1.*, ROWNUM RN FROM    
(SELECT BOARD_ID, TITLE, to_char(WRITE_TIME, 'yyyy-mm-dd hh:mi') 
WRITE_TIME, BOARD_WRITER, READ_COUNT FROM BOARD ORDER BY BOARD_ID DESC)    T1 ) T2  
WHERE RN BETWEEN ?   AND ?
;

SELECT
		ROUND(SUM(TO_NUMBER(TO_CHAR(RECORD_END, 'HH24MISS'))
		-
		TO_NUMBER(TO_CHAR(RECORD_START, 'HH24MISS'))) / 100) AS "SUM_MIN",
		RECORD_MEM_ID AS "MEM_ID"
		FROM
		RECORD
		WHERE RECORD_START >= ( SYSDATE - 7	) AND
		RECORD_MEM_ID IN (SELECT
		SGROUP_MEM_ID FROM SGROUP_MEMBER WHERE
		SGROUP_ID = 53)
		GROUP BY RECORD_MEM_ID
        ;

desc record;
desc sgroup;
select * from record;
select * from sgroup;
select * from sgroup_member;




















