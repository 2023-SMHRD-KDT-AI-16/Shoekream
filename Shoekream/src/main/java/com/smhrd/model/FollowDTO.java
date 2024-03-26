package com.smhrd.model;

import java.sql.Date;

public class FollowDTO {

	 // 팔로우 식별자 
    private Double follow_idx;

    // 팔로워 
    private String follower;

    // 팔로위 
    private String followee;

    // 팔로잉 날짜 
    private Date followed_at;

	public Double getFollow_idx() {
		return follow_idx;
	}

	public void setFollow_idx(Double follow_idx) {
		this.follow_idx = follow_idx;
	}

	public String getFollower() {
		return follower;
	}

	public void setFollower(String follower) {
		this.follower = follower;
	}

	public String getFollowee() {
		return followee;
	}

	public void setFollowee(String followee) {
		this.followee = followee;
	}

	public Date getFollowed_at() {
		return followed_at;
	}

	public void setFollowed_at(Date followed_at) {
		this.followed_at = followed_at;
	}

	public FollowDTO() {
	
	}
    
	
}
