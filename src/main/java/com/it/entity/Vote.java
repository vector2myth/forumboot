package com.it.entity;


public class Vote {

  private int id;
  private String memberid;
  private String tzid;

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getMemberid() {
    return memberid;
  }

  public void setMemberid(String memberid) {
    this.memberid = memberid;
  }


  public String getTzid() {
    return tzid;
  }

  public void setTzid(String tzid) {
    this.tzid = tzid;
  }

}
