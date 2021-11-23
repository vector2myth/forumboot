package com.it.entity;

import java.util.*;

public class Sxinfo {
	private int id;
	private int memberid;
	private int sxmemberid;
	private String note;
	private String hfnote;
	private String savetime;
	private Member sxmember;
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
	public int getSxmemberid() {
		return sxmemberid;
	}
	public void setSxmemberid(int sxmemberid) {
		this.sxmemberid = sxmemberid;
	}
	public String getNote() {
		return note;
	}
	public void setNote(String note) {
		this.note = note;
	}
	public String getHfnote() {
		return hfnote;
	}
	public void setHfnote(String hfnote) {
		this.hfnote = hfnote;
	}
	public String getSavetime() {
		return savetime;
	}
	public void setSavetime(String savetime) {
		this.savetime = savetime;
	}
	public Member getSxmember() {
		return sxmember;
	}
	public void setSxmember(Member sxmember) {
		this.sxmember = sxmember;
	}
	public Member getMember() {
		return member;
	}
	public void setMember(Member member) {
		this.member = member;
	}

	
}
