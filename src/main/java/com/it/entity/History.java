package com.it.entity;


public class History {

    private int id;
    private String memberid;
    private String tzid;
    private String savetime;

    private Tzinfo tzinfo;

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

    public String getSavetime() {
        return savetime;
    }

    public void setSavetime(String savetime) {
        this.savetime = savetime;
    }

    public Tzinfo getTzinfo() {
        return tzinfo;
    }

    public void setTzinfo(Tzinfo tzinfo) {
        this.tzinfo = tzinfo;
    }
}
