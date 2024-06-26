--DROP SEQUENCE "SEQ_BOARD_ID";
--CREATE SEQUENCE "SEQ_BOARD_ID";
--delete from board_reply;
--delete from board;
--delete from member;
--commit;

select * from member;
select * from board;
select * from BOARD_REPLY ORDER BY BOARD_REPLY_REF DESC, BOARD_REPLY_STEP ASC;

exec PRO_MEMBER_BOARD_INSERT('khm', '@kh.m.com', '제목',10);
--(  P_MEMBER_ID_KEY MEMBER.MEM_ID%type
--  ,P_MEMBER_EMAIL_DOMAIN MEMBER.MEM_EMAIL%type
--  ,P_SUBJECT_STR BOARD.SUBJECT%type
--  ,P_MAXCOUNT NUMBER )
exec PRO_BOARD_INSERT('khm1', '보드제목', 10);
--create or replace PROCEDURE "PRO_BOARD_INSERT" 
--(  P_WRITER_KEY BOARD.BOARD_WRITER%TYPE,
--P_SUBJECT_STR BOARD.SUBJECT%TYPE,
--P_MAXCOUNT NUMBER )
select * from BOARD_REPLY ORDER BY BOARD_REPLY_REF DESC, BOARD_REPLY_STEP ASC;
exec PRO_BOARD_REPLY_INSERT('khm1', '내용~', 1, 0);
exec PRO_BOARD_REPLY_INSERT('khm1', '내용~', 1, 1);
exec PRO_BOARD_REPLY_INSERT('khm1', '내용~', 1, 5);
exec PRO_BOARD_REPLY_INSERT('khm1', '내용~', 1, 8);
exec PRO_BOARD_REPLY_INSERT('khm1', '내용~', 1, 11);
exec PRO_BOARD_REPLY_INSERT('khm1', '내용~', 1, 7);
exec PRO_BOARD_REPLY_INSERT('khm1', '내용~', 1, 17);
--create or replace PROCEDURE "PRO_BOARD_REPLY_INSERT" 
--(  P_WRITER_KEY     BOARD_REPLY.BOARD_REPLY_WRITER%TYPE
--  ,P_CONTENT_STR    BOARD_REPLY.BOARD_REPLY_CONTENT%TYPE
--  ,P_RE_BOARD_ID    BOARD_REPLY.BOARD_ID%TYPE
--  ,P_RE_BOARD_REPLY_ID  BOARD_REPLY.BOARD_REPLY_ID%TYPE)
