package com.smhrd.model;

import java.sql.Date;

public class BoardDTO {


	    // 글 식별자 
	    private Double post_idx;

	    // 글 내용 
	    private String post_content;

	    // 글 첨부파일 
	    private String post_img;

	    // 글 작성일자 
	    private Date posted_at;

	    // 글 작성자 
	    private String user_id;

	    // 신발 태그1 
	    private String shoe_tag1;

	    // 신발 태그2 
	    private String shoe_tag2;

	    // 신발 태그3 
	    private String shoe_tag3;

	    // 신발 태그4 
	    private String shoe_tag4;

	    // 신발 태그5 
	    private String shoe_tag5;

	    public Double getPostIdx() {
	        return post_idx;
	    }

	    public void setPostIdx(Double postIdx) {
	        this.post_idx = postIdx;
	    }

	    public String getPostContent() {
	        return post_content;
	    }

	    public void setPostContent(String post_Content) {
	        this.post_content = post_Content;
	    }

	    public String getPostImg() {
	        return post_img;
	    }

	    public void setPostImg(String post_Img) {
	        this.post_img = post_Img;
	    }

	    public Date getPostedAt() {
	        return posted_at;
	    }

	    public void setPostedAt(Date posted_At) {
	        this.posted_at = posted_At;
	    }

	    public String getUserId() {
	        return user_id;
	    }

	    public void setUserId(String user_Id) {
	        this.user_id = user_Id;
	    }

	    public String getShoeTag1() {
	        return shoe_tag1;
	    }

	    public void setShoeTag1(String shoe_Tag1) {
	        this.shoe_tag1 = shoe_Tag1;
	    }

	    public String getShoeTag2() {
	        return shoe_tag2;
	    }

	    public void setShoeTag2(String shoe_Tag2) {
	        this.shoe_tag2 = shoe_Tag2;
	    }

	    public String getShoeTag3() {
	        return shoe_tag3;
	    }

	    public void setShoeTag3(String shoe_Tag3) {
	        this.shoe_tag3 = shoe_Tag3;
	    }

	    public String getShoeTag4() {
	        return shoe_tag4;
	    }

	    public void setShoeTag4(String shoe_Tag4) {
	        this.shoe_tag4 = shoe_Tag4;
	    }

	    public String getShoeTag5() {
	        return shoe_tag5;
	    }

	    public void setShoeTag5(String shoe_Tag5) {
	        this.shoe_tag5 = shoe_Tag5;
	    }

	    public BoardDTO() {
	    	
	    }
	    
	 
	}
