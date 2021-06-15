kimCREATE TABLE stock_vi(
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
        
        select count(*) from tbl_reply reply where reply.bno = board.bno as replyCount
        update notices set viewsCount = viewsCount + 1 where bno = 292
	
    SELECT (SELECT COUNT(*) FROM NOTICESREPLY REPLY WHERE reply.297 = notices.297) as replyCount FROM NOTICES WHERE BNO =297
        
        
        SELECT COUNT(*) FROM NOTICESREPLY REPLY WHERE noticesreply.bno = notices.bno
      
      select max(likecount) from notices where bno =335
      
        update notices set
        likeCount =  (select max(likecount)+1 from notices where bno =335)
        where bno = 335
----공지사항 댓글----
create table noticesreply(
rno number(10) not null,
bno number(10) not null,
reply varchar2(500),
replyer varchar2(500),
regTime date default sysdate,
updateTime date
)

CREATE SEQUENCE seq_noticesReply INCREMENT BY 1 START WITH 1 -- 시퀀스 생성
ALTER TABLE noticesreply ADD CONSTRAINT pk_noticesReply PRIMARY KEY (rno)
ALTER TABLE noticesreply ADD CONSTRAINT fk_noticesReply FOREIGN KEY (bno) REFERENCES notices(bno) ON DELETE CASCADE --부모키삭제시 자손도 같이삭제


insert into noticesreply(rno, bno, reply, replyer)
values (1,194,'댓글내용','댓글작성자')
        
SELECT seq_noticesReply.NEXTVAL as rno FROM DUAL;
SELECT LAST_INSERT_ID()

select /*+ index(noticesreply pk_noticesReply) */ * from noticesreply where bno =294      --댓글목록

update noticesreply set
reply = '변경' where rno = 2343

-----파일업로드-----
create table noticesFile(
file_bno number(10),                        --파일번호
file_notices_bno number(10),                --게시글번호
file_original_nm varchar2(100),             --파일오리지널이름
file_UUID_nm varchar2(100),                 --파일UUID이름
file_Path varchar2(100),                  --파일경로
file_upload_reg date default sysdate,       --파일등록시간
file_change_reg date,                       --파일변경시간
file_size number(10),                         --파일사이즈
file_kind varchar2(100),                       --파일종류
CONSTRAINT pk_filebno PRIMARY KEY(file_bno),    --PK번호
CONSTRAINT fk_filebno FOREIGN KEY(file_notices_bno) REFERENCES notices(bno) --FK 외래키(외래키에 bno값이 안들어가있어 제약조건 위배 일단 주석)
)
create sequence seq_file INCREMENT BY 1 START WITH 1; --시퀀스 생성


update noticesFile set 
file_notices_bno = 278 where file_bno = 134

delete from noticesFile where file_bno = 151



select * from noticesFile where file_notices_bno is null


----로그인----
create table notices_user(
user_id varchar2(30),
user_pw varchar2(150),
user_name varchar2(20),
user_phone varchar2(20),
user_reg date default sysdate,
user_address_zip_code number(10),
user_address_road_name varchar2(100),
user_address_detailed varchar2(100),
user_email varchar2(100),
user_ip varchar2(100)
)
ALTER TABLE notices_user ADD CONSTRAINT pk_userid PRIMARY KEY (user_id)   -- PK를 생성한다.
Alter table notices_user add provider varchar2(10) default 'local'         --가입경로
alter table notices_user add(user_nick varchar2(50))                        --닉네임컬럼추가
alter table notices_user modify(user_id varchar2(50))                          

		SELECT COUNT(*) FROM NOTICES_USER WHERE USER_ID = 'abc'
        
    select count(*) from notices_user where user_id='test1234' and user_pw= '$2a$10$hOg3EOuvOh3Uq1q7k/POOuQYKHgV7u75urB0Qh3iUcRCYzijREgXC'
    
    		select user_id,user_name,user_phone,user_address_zip_code,user_address_road_name,user_address_detailed,user_email from notices_user where user_id= 'test1234'
            update notices_user set user_name ='123' ,user_phone ='123' ,user_address_zip_code= , user_address_road_name = ,user_address_detailed = ,user_email =  where user_id = 
----회원탈퇴 테이블----
create table notcies_user_withdrawl(
user_id varchar2(30),
user_reg_withdrawal date default to_char(sysdate,'YYYYMMDD'),
CONSTRAINT withdrawl_pk_userid PRIMARY KEY(user_id),
CONSTRAINT fk_userid FOREIGN KEY(user_id) REFERENCES notices_user(user_id) on delete cascade
)

select user_id as userId ,user_reg_withdrawal as userRegWithdrawal from notcies_user_withdrawl where user_id='test1234'

insert into notcies_user_withdrawl(user_id)
values('test1234')

delete from notcies_user_withdrawl where user_id = 'test1234'

select sysdate from dual;
select to_char(sysdate +7,'YYYYMMDD') FROM DUAL

select user_reg_withdrawal from notcies_user_withdrawl
where user_reg_withdrawal between to_char(sysdate-1,'YYYYMMDD') and to_char(sysdate+7,'YYYYMMDD')

select user_id as userID from notcies_user_withdrawl
where user_reg_withdrawal <= to_char(sysdate-7,'YYYYMMDD')


---좋아요 싫어요-----
create table noticeslike(
noticesBno number(10),
userId varchar2(50),
--noticesLikeCount number(10),
LikeReg Date default sysdate,
CONSTRAINT fk_userid_like FOREIGN KEY(userId) REFERENCES notices_user(user_id) on delete cascade,
CONSTRAINT fk_like_bno FOREIGN KEY(noticesBno) REFERENCES notices(bno) ON DELETE CASCADE
)

select * from noticeslike where noticesBno = 123 and userID ='test1234'

update notices set likeCount = (select nvl(max(likecount),0)+1 from notices),
where bno = 335

insert into noticeslike(noticesbno, userid)
values (335, 'test1234')

	SELECT * FROM NOTICES
	WHERE BNO =335
    
    	update notices set
	likeCount =  (select max(likecount)-1 from notices where bno = 332)
	where bno =332
    
    delete from noticeslike 
    where noticesBno =332 and userid = 'test1111'
    
    		SELECT USER_ID,USER_NAME,USER_PHONE,USER_ADDRESS_ZIP_CODE,USER_ADDRESS_ROAD_NAME,USER_ADDRESS_DETAILED,USER_EMAIL 
		FROM NOTICES_USER WHERE USER_ID = 'test1234' or user_nick = '(naver)포포015'