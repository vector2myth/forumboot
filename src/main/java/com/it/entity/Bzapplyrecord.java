package com.it.entity;

import java.util.*;

public class Bzapplyrecord {
	private int id;
	private int fid;
	private String note;
	private int memberid;
	private String shstatus;
	private String savetime;
	private Bbstype ftype;
	private Member member;
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public int getFid() {
		return fid;
	}
	public void setFid(int fid) {
		this.fid = fid;
	}
	public String getNote() {
		return note;
	}
	public void setNote(String note) {
		this.note = note;
	}
	public int getMemberid() {
		return memberid;
	}
	public void setMemberid(int memberid) {
		this.memberid = memberid;
	}
	public String getShstatus() {
		return shstatus;
	}
	public void setShstatus(String shstatus) {
		this.shstatus = shstatus;
	}
	public String getSavetime() {
		return savetime;
	}
	public void setSavetime(String savetime) {
		this.savetime = savetime;
	}
	public Bbstype getFtype() {
		return ftype;
	}
	public void setFtype(Bbstype ftype) {
		this.ftype = ftype;
	}
	public Member getMember() {
		return member;
	}
	public void setMember(Member member) {
		this.member = member;
	}

	
}
