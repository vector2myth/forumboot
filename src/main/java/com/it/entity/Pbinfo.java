package com.it.entity;

import java.util.*;

public class Pbinfo {
	private int id;
	private int memberid;
	private int pbmemberid;
	private Member pbmember;
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
	public int getPbmemberid() {
		return pbmemberid;
	}
	public void setPbmemberid(int pbmemberid) {
		this.pbmemberid = pbmemberid;
	}
	public Member getPbmember() {
		return pbmember;
	}
	public void setPbmember(Member pbmember) {
		this.pbmember = pbmember;
	}

	
}
