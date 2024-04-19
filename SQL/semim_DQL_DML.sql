------------------------SEMIM BOARD DML -------------------------
--- & 대체입력창이 아니라 문자그대로 동작하도록 함.
set define off;

select * from MEMBER;
select * from BOARD;
select * from BOARD_REPLY;


desc member;
desc board_reply;
desc board;

select * from BOARD_REPLY order by board_id;

-- UI-009 게시글쓰기 첨부파일포함
INSERT ALL
INTO BOARD (BOARD_ID,SUBJECT,CONTENT,WRITE_TIME,LOG_IP,BOARD_WRITER,READ_COUNT)
				 VALUES (SEQ_BOARD_ID.nextval, 'SSS', 'CCC', default, NULL, 'kh1', default)
INTO BOARD_FILE (BOARD_ID, BOARD_FILE_ID, SAVED_FILE_PATH_NAME, ORIGINAL_FILENAME)
				 VALUES (SEQ_BOARD_ID.nextval, 1, 'a.jpg', 'ao.jpg')
INTO BOARD_FILE (BOARD_ID, BOARD_FILE_ID, SAVED_FILE_PATH_NAME, ORIGINAL_FILENAME)
				 VALUES (SEQ_BOARD_ID.nextval, 2, 'a2.jpg', 'ao.jpg')
SELECT * FROM DUAL
;
select * from board where board_id=202;
select * from board_reply where board_id=202;

select * from
(select * from board where board_id=202) t1
natural join (select * from board_reply where board_id=202) t2
;

select * from board natural join board_file ;


select * 
    from (select t1.*, rownum rn  
        from (SELECT BOARD_ID, SUBJECT,WRITE_TIME,BOARD_WRITER,READ_COUNT    FROM BOARD order by board_id desc) t1 )
where rn between 3 and 5;

select * from board order by board_id desc;
select * from board where board_id=202;

select * from board_reply order by board_reply_ref desc,  board_reply_step;
delete from board_reply where board_reply_id > 16;
commit;
exec PRO_BOARD_REPLY_INSERT('kh2', '댓글', 202, 0);
exec PRO_BOARD_REPLY_INSERT('kh2', 'ㄷㄷ', 202, 9);

select * from 
    (select * from board where board_id=202 ) t1
    join (select * from board_reply where board_id=202 order by board_reply_ref desc,  board_reply_step) t2
on t1.board_id = t2.board_id
;
select BOARD_REPLY_ID,  BOARD_REPLY_WRITER,BOARD_REPLY_CONTENT, 
				BOARD_REPLY_WRITE_TIME,	BOARD_REPLY_LEVEL,BOARD_REPLY_REF, BOARD_REPLY_STEP 
				from board_reply where board_id=202 order by board_reply_ref desc,  board_reply_step
;
select * from member;
--인덱스에서 누락된 IN 또는 OUT 매개변수:: 1
--  > ? 등 이상한 기호.

--create or replace NONEDITIONABLE PROCEDURE PRO_BOARD_REPLY_INSERT 
--(  P_WRITER_KEY     BOARD_REPLY.BOARD_REPLY_WRITER%TYPE
--  ,P_CONTENT_STR    BOARD_REPLY.BOARD_REPLY_CONTENT%TYPE
--  ,P_RE_BOARD_ID    BOARD_REPLY.BOARD_ID%TYPE
--  ,P_RE_BOARD_REPLY_ID  BOARD_REPLY.BOARD_REPLY_ID%TYPE)