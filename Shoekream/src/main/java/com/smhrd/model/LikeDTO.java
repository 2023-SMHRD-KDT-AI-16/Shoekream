package com.smhrd.model;

public class LikeDTO {
	 // 좋아요 식별자 
    private Integer like_idx;

    // 글 식별자 
    private Double post_idx;

    // 회원 아이디 
    private String user_id;

    // 좋아요 날짜 
    private String liked_at;

	public Integer getLike_idx() {
		return like_idx;
	}

	public void setLike_idx(Integer like_idx) {
		this.like_idx = like_idx;
	}

	public Double getPost_idx() {
		return post_idx;
	}

	public void setPost_idx(Double post_idx) {
		this.post_idx = post_idx;
	}

	public String getUser_id() {
		return user_id;
	}

	public void setUser_id(String user_id) {
		this.user_id = user_id;
	}

	public String getLiked_at() {
		return liked_at;
	}

	public void setLiked_at(String liked_at) {
		this.liked_at = liked_at;
	}

	public LikeDTO() {
	}

	
}
