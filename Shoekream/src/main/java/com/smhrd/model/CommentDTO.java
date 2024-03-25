package com.smhrd.model;

import java.sql.Date;

public class CommentDTO {
	 // 댓글 식별자 
    private Double cmt_idx;

    // 원글 식별자 
    private Double post_idxf;

    // 댓글 내용 
    private String cmt_content;

    // 댓글 작성일자 
    private Date created_at;

    // 댓글 작성자 
    private String user_id;

	public Double getCmt_idx() {
		return cmt_idx;
	}

	public void setCmt_idx(Double cmt_idx) {
		this.cmt_idx = cmt_idx;
	}

	public Double getPost_idxf() {
		return post_idxf;
	}

	public void setPost_idxf(Double post_idxf) {
		this.post_idxf = post_idxf;
	}

	public String getCmt_content() {
		return cmt_content;
	}

	public void setCmt_content(String cmt_content) {
		this.cmt_content = cmt_content;
	}

	public Date getCreated_at() {
		return created_at;
	}

	public void setCreated_at(Date created_at) {
		this.created_at = created_at;
	}

	public String getUser_id() {
		return user_id;
	}

	public void setUser_id(String user_id) {
		this.user_id = user_id;
	}

	public CommentDTO() {
		
	}



	
	
}