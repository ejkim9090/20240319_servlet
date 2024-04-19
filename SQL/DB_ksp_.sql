BEGIN
    FOR I IN 1..5 LOOP
        INSERT INTO EDU_LIST VALUES(
                    (SELECT (NVL(MAX(EDU_ID), 0) + 1) FROM EDU_LIST)
                    , '교육'||I
                    , '강원도'||I||'시'
                    , '초등'||I||'학년'
                    , '매일'
                    , '2024-0'||(I+1)
                    , '2024-0'||I||'-01 ~ 2024-0'||I||'-28'
                    , '2024-0'||(I+1)||'-01 ~ 2024-0'||(I+1)||'-30'
                    , DEFAULT
        );
    END LOOP;
    COMMIT;
END;
/
BEGIN
INSERT INTO EDU_LIST VALUES(
            (SELECT (NVL(MAX(EDU_ID), 0) + 1) FROM EDU_LIST)
            , '교육'
            , '강원도'||'시'
            , '초등'||'학년'
            , '매일'
            , '2024-0'
            , '2024-0'||'-01 ~ 2024-0'||'-28'
            , '2024-0'||'-01 ~ 2024-0'||'-30'
            , DEFAULT
);
END;
/
delete from EDU_LIST;
commit;

