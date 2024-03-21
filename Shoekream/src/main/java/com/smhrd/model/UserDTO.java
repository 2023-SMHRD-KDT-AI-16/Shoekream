package com.smhrd.model;

import java.sql.Date;

public class UserDTO {


    // 회원 아이디 
    private String user_id;

    // 회원 비밀번호 
    private String user_pw;

    // 회원 이름 
    private String user_name;

    // 회원 전화번호 
    private String user_phone;

    // 회원 이메일 
    private String user_email;

    // 회원 닉네임 
    private String user_nick;

    // 회원 등급 
    private String user_rank;

    // 회원 소개 
    private String user_info;

    // 회원 프로필사진 
    private String user_profile_img;

    // 회원 가입일자 
    private Date joined_at;

    // 관리자 여부 
    private String admin_yn;

    public String getUserId() {
        return user_id;
    }

    public void setUserId(String userId) {
        this.user_id = user_id;
    }

    public String getUserPw() {
        return user_pw;
    }

    public void setUserPw(String userPw) {
        this.user_pw = user_pw;
    }

    public String getUserName() {
        return user_name;
    }

    public void setUserName(String userName) {
        this.user_name = user_name;
    }

    public String getUserPhone() {
        return user_phone;
    }

    public void setUserPhone(String userPhone) {
        this.user_phone = user_phone;
    }

    public String getUserEmail() {
        return user_email;
    }

    public void setUserEmail(String userEmail) {
        this.user_email = user_email;
    }

    public String getUserNick() {
        return user_nick;
    }

    public void setUserNick(String userNick) {
        this.user_nick = user_nick;
    }

    public String getUserRank() {
        return user_rank;
    }

    public void setUserRank(String userRank) {
        this.user_rank = user_rank;
    }

    public String getUserInfo() {
        return user_info;
    }

    public void setUserInfo(String userInfo) {
        this.user_info = user_info;
    }

    public String getUserProfileImg() {
        return user_profile_img;
    }

    public void setUserProfileImg(String userProfileImg) {
        this.user_profile_img = user_profile_img;
    }

    public Date getJoinedAt() {
        return joined_at;
    }

    public void setJoinedAt(Date joinedAt) {
        this.joined_at = joined_at;
    }

    public String getAdminYn() {
        return admin_yn;
    }

    public void setAdminYn(String adminYn) {
        this.admin_yn = admin_yn;
    }
    
    public UserDTO() {
    	
    }
	
    public UserDTO(String user_id,String user_pw) {
    	this.user_id= user_id;
    	this.user_pw = user_pw;
    }
	
}
