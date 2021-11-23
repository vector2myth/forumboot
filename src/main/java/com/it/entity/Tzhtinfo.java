package com.it.entity;

import java.util.*;

public class Tzhtinfo {
	private int id;
	private int tzid;
	private String note;
	private int author;
	private String savetime;
	private int dznum;
	private String canht;
	private Member htmember;
	private Bbstype ftype;
	private Tzinfo tzinfo;

    private List<Hthf> hthflist;

    public List<Hthf> getHthflist() {
        return hthflist;
    }

    public void setHthflist(List<Hthf> hthflist) {
        this.hthflist = hthflist;
    }

    public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public int getTzid() {
		return tzid;
	}
	public void setTzid(int tzid) {
		this.tzid = tzid;
	}
	public String getNote() {
		return note;
	}
	public void setNote(String note) {
		this.note = note;
	}
	public int getAuthor() {
		return author;
	}
	public void setAuthor(int author) {
		this.author = author;
	}
	public String getSavetime() {
		return savetime;
	}
	public void setSavetime(String savetime) {
		this.savetime = savetime;
	}
	public int getDznum() {
		return dznum;
	}
	public void setDznum(int dznum) {
		this.dznum = dznum;
	}
	public String getCanht() {
		return canht;
	}
	public void setCanht(String canht) {
		this.canht = canht;
	}
	public Member getHtmember() {
		return htmember;
	}
	public void setHtmember(Member htmember) {
		this.htmember = htmember;
	}
	public Bbstype getFtype() {
		return ftype;
	}
	public void setFtype(Bbstype ftype) {
		this.ftype = ftype;
	}
	public Tzinfo getTzinfo() {
		return tzinfo;
	}
	public void setTzinfo(Tzinfo tzinfo) {
		this.tzinfo = tzinfo;
	}
	
	

	
}
