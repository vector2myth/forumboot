package com.it.entity;

import java.util.*;

public class Tzinfo {
	private int id;
	private String fid;
	private String sid;
	private String title;
	private String note;
	private int author;
	private String savetime;
	private int dznum;
	private int looknum;
	private String isjh;
	private String istop;
	private String canht;
	private String updatetime;
	private Bbstype stype;
	private String filename;
    private String isfb;

    public String getIsfb() {
        return isfb;
    }

    public void setIsfb(String isfb) {
        this.isfb = isfb;
    }

    private Bbstype ftype;
	private Member member;
	private List<Tzhtinfo> tophtlist;
	private List<Tzhtinfo> pthtlist;
	private List<Tzhtinfo> allhtlist;
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
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
	public int getLooknum() {
		return looknum;
	}
	public void setLooknum(int looknum) {
		this.looknum = looknum;
	}
	public String getIsjh() {
		return isjh;
	}
	public void setIsjh(String isjh) {
		this.isjh = isjh;
	}
	public String getIstop() {
		return istop;
	}
	public void setIstop(String istop) {
		this.istop = istop;
	}
	public String getCanht() {
		return canht;
	}
	public void setCanht(String canht) {
		this.canht = canht;
	}
	public String getUpdatetime() {
		return updatetime;
	}
	public void setUpdatetime(String updatetime) {
		this.updatetime = updatetime;
	}
	public Bbstype getStype() {
		return stype;
	}
	public void setStype(Bbstype stype) {
		this.stype = stype;
	}
	public String getFilename() {
		return filename;
	}
	public void setFilename(String filename) {
		this.filename = filename;
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
	public List<Tzhtinfo> getTophtlist() {
		return tophtlist;
	}
	public void setTophtlist(List<Tzhtinfo> tophtlist) {
		this.tophtlist = tophtlist;
	}
	public List<Tzhtinfo> getPthtlist() {
		return pthtlist;
	}
	public void setPthtlist(List<Tzhtinfo> pthtlist) {
		this.pthtlist = pthtlist;
	}
	public List<Tzhtinfo> getAllhtlist() {
		return allhtlist;
	}
	public void setAllhtlist(List<Tzhtinfo> allhtlist) {
		this.allhtlist = allhtlist;
	}

    public String getFid() {
        return fid;
    }

    public void setFid(String fid) {
        this.fid = fid;
    }

    public String getSid() {
        return sid;
    }

    public void setSid(String sid) {
        this.sid = sid;
    }
}
