
SELECT 
    numtodsinterval( sum( cast(record_end as date) - cast(record_start as date) ), 'day' ) as a
--    , to_char(numtodsinterval( sum( cast(record_end as date) - cast(record_start as date) ), 'day' ), 'hh24:mm:dd') as d
    , substr(numtodsinterval( sum( cast(record_end as date) - cast(record_start as date) ), 'day' ), 12, 8) as e
    -- 오류 timestamp-timestamp--- sum(timestamp-timestamp),numtodsinterval( sum( record_end - record_start  ), 'day' ) as b
    , sum( cast(record_end as date) - cast(record_start as date) ) as c
  FROM record
  group by record_subject_id
  ;
  
  SELECT RECORD_SUBJECT_ID
, (SELECT SUBJECT_NAME from SUBJECT where SUBJECT_ID=RECORD_SUBJECT_ID) AS SUBJECT_NAME
, SUBSTR(NUMTODSINTERVAL( SUM( CAST(record_end as DATE) - CAST(record_start as DATE) ), 'day' ), 12, 8) as diffTime
from record
where record_mem_id ='won' and to_char(record_start, 'yyyymmdd') =  to_char(sysdate, 'yyyymmdd')
group by cube(record_subject_id)
;
  
  with x as (
  select '01:23:45' val from dual union all
  select '02:15:30' from dual
) 
select numtodsinterval( sum( to_date( val, 'hh24:mi:ss' ) - trunc( sysdate, 'MM' ) ), 'day' ) as a
  from x;
  
  
  with x as ( select TO_CHAR(to_timestamp(regexp_replace(ru.duration,'(*[[:punct:]])',''),'HH:MI:SS'),'HH:MI:SS') as val 
  FROM RESOURCE_UTILIZATION RU  
  WHERE RU.RESOURCE_NAME='AKSHAY ANPAT' 
    and ru.current_date_time between to_date('01/03/2016','DD/MM/YYYY') 
    AND to_date('04/03/2016','DD/MM/YYYY') ) 
  select numtodsinterval( sum( to_date( val, 'hh24:mi:ss' ) - trunc( sysdate, 'MM' ) ), 'day' ) from x
;