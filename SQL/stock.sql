CREATE TABLE stock_vi(
stk_id NUMBER(10,0), --번호
stk_cd varchar2(50), --종목코드 
stk_nm varchar2(50),  --종목명
stk_pri varchar2(50), --가격
stk_inc varchar2(50), --상승률
stk_act varchar2(50), --발동시각 
stk_rel varchar2(50), -- 해제시각
stk_daye Date default sysdate -- 데이터등록시간
-- CONSTRAINT pk_stkid PRIMARY KEY(stk_id)
);
--alter table stock_vi add stk_daye Date default sysdate

--alter table stock_vi drop primary key
--drop table stock_news
--commit;
--ALTER TABLE stock_vi MODIFY stk_rel VARCHAR2(50);
--ALTER TABLE stock_vi MODIFY stk_act VARCHAR2(50);
--ALTER TABLE stock_vi DROP CONSTRAINT pk_stkid;
--alter table stock_vi add primary key(stk_cd);


    -- if 0 이라면 등록  1이라면(데이터 있음) 다시 비교 ,
   select count(*) from stock_vi where stk_id = '5' and to_date(stk_daye,'YY/MM/DD') =(SELECT TO_CHAR(SYSDATE, 'YYYY/MM/DD') FROM DUAL)
   
    --  시간까지 비교해서 1이라면(데이터있고 rel :00임) return / 0이라면 업데이트 
   select count(*) from stock_vi where stk_id = '5' and stk_rel='00:00:00' and to_date(stk_daye,'YY/MM/DD') =(SELECT TO_CHAR(SYSDATE, 'YYYY/MM/DD') FROM DUAL)
   
    
    select count(*) from stock_vi where stk_id = '153' 
    
    select * from stock_vi WHERE (CASE WHEN stk_rel = '00:00:00' THEN stk_rel = '11' else stk_rel='22' end)
    
    select * (case when stk_rel = '00:00:00' then stk_rel = '11' else stk_rel='22' end) from stock_vi
    
rollback

update stock_vi set stk_rel = '12:12:12' where stk_id = '155'

commit;

create SEQUENCE seq_stock

select * from stock_vi
   
       INSERT INTO stock_vi (stk_id)
        VALUES (#{stk_id})
    
INSERT INTO stock_vi (stk_id, stk_cd, stk_nm, stk_pri, stk_inc)
VALUES (SEQ_STOCK.nextval,1111,'종목명',8000,100);

COMMIT


------- VI list 작업 -----
--select * from stock_vi order by TO_NUMBER(stk_id)

select * from stock_vi order by stk_id

SELECT SYSDATE FROM DUAL;

select * from stock_vi where to_date(stk_daye,'YY/MM/DD') ='21/03/04' 

select * from stock_vi where to_date(stk_daye,'YY/MM/DD') =(SELECT TO_CHAR(SYSDATE, 'YYYY/MM/DD') FROM DUAL) order by stk_id desc

select count(*) from stock_vi where stk_id = #{stk_id}

    update stock_vi set stk_rel = '24:24:24' where stk_id = 5 and stk_nm = '서울식품2'

------vi news-------------    
CREATE TABLE stock_news(
--news_bno NUMBER(10,0),
news_company varchar2(100),
news_title varchar2(300),
news_time varchar2(100),
news_href varchar2(300)
)

drop table stock_news 

create sequence seq_news increment by 1 start with 1

insert into stock_news (news_bno, news_company, news_title, news_time, news_href)
values (seq_news.nextval,'테스트회사','제목', '7일전','www.naver.com')

-- 띄어쓰기 구분없이 검색하기
select * from stock_news where replace(news_company,' ','') LIKE '%THESAMSUNG%'

commit;

select count(*) from stock_news where news_bno = 

select count(*) from stock_news where news_company ='THE MIDONG' and news_href = 'http://www.edaily.co.kr/news/newspath.asp?newsid=04145926628979384' 

select vsize('가나다') as byteSize from dual

commit;

----- 공지사항 ----
create table notices(
bno number(10) not null,
title varchar2(500),
content varchar2(500),
writer varchar2(100),
regTime date default TO_DATE(sysdate,'YYYY/MM/DD HH24:MI:SS'),
updateTime date,
viewsCount number(10) default 0,
replyCount number(10) default 0,
likeCount number(10) default 0,
fileName varchar2(100)
)

alter table notices add CONSTRAINT pk_notices  PRIMARY KEY(bno) -- notices_bno 기본키 생성
CREATE SEQUENCE seq_notices INCREMENT BY 1 START WITH 1 -- 시퀀스 생성
alter sequence seq_notices nocache -- 시퀀스 cache옵션 사용x
ALTER SESSION SET NLS_DATE_FORMAT='YYYY/MM/DD HH24:MI:SS';   -- sqlplus date 세팅

SELECT TO_CHAR(SYSDATE, 'RRRR-MM-DD HH24:MI:SS') AS "현재시간"  FROM DUAL;

insert into notices(bno, title, content,writer)
values (seq_notices.nextval,'테스트','테스트','테스트')


	    SELECT * FROM 
		 (
		 SELECT /*+INDEX_DESC(NOTICES PK_NOTICES)*/ ROWNUM RN, BNO, TITLE, CONTENT, WRITER, REGTIME, VIEWSCOUNT,(SELECT COUNT(*) FROM NOTICES) as a
		 FROM NOTICES NOTICES
		 WHERE BNO > 0 AND ROWNUM > 0 AND ROWNUM <= 1 * 10
		 )
		WHERE RN > (1 - 1) * 10


	 	SELECT COUNT(*) FROM NOTICES WHERE title LIKE '제목'
        
