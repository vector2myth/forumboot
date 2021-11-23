package com.it.entity;

import java.util.*;

public class Chat {
	private int id;
	private int memberid;
	private String hfmsg;
	private String savetime;
	private String msg;
	private Member member;
	
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public int getMemberid() {
		return memberid;
	}
	public void setMemberid(int memberid) {
		this.memberid = memberid;
	}
	public String getHfmsg() {
		return hfmsg;
	}
	public void setHfmsg(String hfmsg) {
		this.hfmsg = hfmsg;
	}
	public String getSavetime() {
		return savetime;
	}
	public void setSavetime(String savetime) {
		this.savetime = savetime;
	}
	public String getMsg() {
		return msg;
	}
	public void setMsg(String msg) {
		this.msg = msg;
	}
	public Member getMember() {
		return member;
	}
	public void setMember(Member member) {
		this.member = member;
	}

	
}
