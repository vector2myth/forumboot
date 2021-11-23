package com.it.entity;

import java.util.*;

public class Fav {
	private int id;
	private int memberid;
	private int tzid;
	
	private Tzinfo tzinfo;
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
	public int getTzid() {
		return tzid;
	}
	public void setTzid(int tzid) {
		this.tzid = tzid;
	}
	public Tzinfo getTzinfo() {
		return tzinfo;
	}
	public void setTzinfo(Tzinfo tzinfo) {
		this.tzinfo = tzinfo;
	}
	public Member getMember() {
		return member;
	}
	public void setMember(Member member) {
		this.member = member;
	}

	
	
}
