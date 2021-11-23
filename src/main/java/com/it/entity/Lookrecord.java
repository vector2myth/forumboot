package com.it.entity;


public class Lookrecord {

    private int id;
    private String tzid;
    private String savetime;
    private String fid;
    private Tzinfo tzinfo;

    public String getFid() {
        return fid;
    }

    public void setFid(String fid) {
        this.fid = fid;
    }

    public Tzinfo getTzinfo() {
        return tzinfo;
    }

    public void setTzinfo(Tzinfo tzinfo) {
        this.tzinfo = tzinfo;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
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

}
