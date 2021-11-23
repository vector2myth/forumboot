package com.it.entity;

import java.util.*;

public class Jbrecord {
	private int id;
	private int memberid;
	private int jbmemberid;
	private String note;
	private Member member;
	private Member jbmember;
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
	public int getJbmemberid() {
		return jbmemberid;
	}
	public void setJbmemberid(int jbmemberid) {
		this.jbmemberid = jbmemberid;
	}
	public String getNote() {
		return note;
	}
	public void setNote(String note) {
		this.note = note;
	}
	public Member getMember() {
		return member;
	}
	public void setMember(Member member) {
		this.member = member;
	}
	public Member getJbmember() {
		return jbmember;
	}
	public void setJbmember(Member jbmember) {
		this.jbmember = jbmember;
	}
	

	
}
