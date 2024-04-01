select count(*) from USER_INFO;

select * from comment_info where post_idxf=26 ORDER BY CREATED_AT DESC;

select count(*) from post_like_info where post_idx=26.0;

delete from post_like_info where post_idx=26 and user_id='user';

insert into post_like_info (post_idx,user_id,liked_at) values(26,'user',sysdate);

COMMIT;
