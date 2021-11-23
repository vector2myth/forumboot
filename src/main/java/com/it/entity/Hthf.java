package com.it.entity;


public class Hthf {

  private int id;
  private String memberid;
  private int htid;
  private String content;
  private String savetime;


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

    public String getMemberid() {
    return memberid;
  }

  public void setMemberid(String memberid) {
    this.memberid = memberid;
  }


    public int getHtid() {
        return htid;
    }

    public void setHtid(int htid) {
        this.htid = htid;
    }

    public String getContent() {
    return content;
  }

  public void setContent(String content) {
    this.content = content;
  }


  public String getSavetime() {
    return savetime;
  }

  public void setSavetime(String savetime) {
    this.savetime = savetime;
  }

}
