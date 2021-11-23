package com.it.entity;

import java.util.*;

public class Bbstype {
	private int id;
	private String typename;
	private String fatherid;
	private String delstatus;
	private List<Bbstype> childlist;
	private List<Tzinfo> ftypetzinfolist;
	private Member banzhu;
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public String getTypename() {
		return typename;
	}
	public void setTypename(String typename) {
		this.typename = typename;
	}
	public String getFatherid() {
		return fatherid;
	}
	public void setFatherid(String fatherid) {
		this.fatherid = fatherid;
	}
	public String getDelstatus() {
		return delstatus;
	}
	public void setDelstatus(String delstatus) {
		this.delstatus = delstatus;
	}
	public List<Bbstype> getChildlist() {
		return childlist;
	}
	public void setChildlist(List<Bbstype> childlist) {
		this.childlist = childlist;
	}
	public List<Tzinfo> getFtypetzinfolist() {
		return ftypetzinfolist;
	}
	public void setFtypetzinfolist(List<Tzinfo> ftypetzinfolist) {
		this.ftypetzinfolist = ftypetzinfolist;
	}
	public Member getBanzhu() {
		return banzhu;
	}
	public void setBanzhu(Member banzhu) {
		this.banzhu = banzhu;
	}
	@Override
	public String toString() {
		return "Bbstype [banzhu=" + banzhu + ", childlist=" + childlist
				+ ", delstatus=" + delstatus + ", fatherid=" + fatherid
				+ ", ftypetzinfolist=" + ftypetzinfolist + ", id=" + id
				+ ", typename=" + typename + "]";
	}
	

	
}
