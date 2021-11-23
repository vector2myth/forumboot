package com.it.entity;

import java.util.*;

public class Fans {
	private int id;
	private int memberid;
	private int gzmemberid;
	private Member gzmember;

    private Member member;

    public Member getMember() {
        return member;
    }

    public void setMember(Member member) {
        this.member = member;
    }

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
	public int getGzmemberid() {
		return gzmemberid;
	}
	public void setGzmemberid(int gzmemberid) {
		this.gzmemberid = gzmemberid;
	}
	public Member getGzmember() {
		return gzmember;
	}
	public void setGzmember(Member gzmember) {
		this.gzmember = gzmember;
	}

	
}
