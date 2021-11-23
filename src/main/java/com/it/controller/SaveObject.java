package com.it.controller;

import com.it.dao.*;
import com.it.entity.*;
import com.it.util.Info;
import org.springframework.stereotype.Component;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import java.util.HashMap;
import java.util.List;

@Component
public class SaveObject {
    @Resource
    YqlinkDAO yqlinkDAO;
    @Resource
    BbstypeDAO bbstypeDAO;
    @Resource
    NewsDAO newsDAO;
    @Resource
    TzinfoDAO tzinfoDAO;
    @Resource
    BanzhuDAO banzhuDAO;
    @Resource
    MemberDAO memberDAO;
    @Resource
    TzhtinfoDAO tzhtinfoDAO;
    @Resource
    HthfDAO hthfDAO;
    @Resource
    LookrecordDAO lookrecordDAO;


    public void getYqlink(HttpServletRequest request){
        List<Yqlink> yqlist = yqlinkDAO.selectAll(null);
        request.setAttribute("yqlist",yqlist);
    }

    public void getCategory(HttpServletRequest request){
        HashMap ccc = new HashMap();
        HashMap ddd = new HashMap();
        ccc.put("fatherid","0");
        ddd.put("isfb","是");
        List<Bbstype> ctlist = bbstypeDAO.selectAll(ccc);
		for(Bbstype bbstype:ctlist){
		    ddd.put("fatherid",bbstype.getId());
			List<Bbstype> childlist = bbstypeDAO.selectAll(ddd);
			bbstype.setChildlist(childlist);
            ddd.put("fid",bbstype.getId());
            List<Tzinfo> ftypetzinfolist = tzinfoDAO.selectAll(ddd);
            bbstype.setFtypetzinfolist(ftypetzinfolist);

            //版主
            Banzhu banzhu;
            List<Banzhu> banzhulist = banzhuDAO.selectAll(ddd);
            if(banzhulist.size()!=0){
                banzhu = banzhulist.get(0);
                Member member = memberDAO.findById(Integer.parseInt(banzhu.getMemberid()));
                bbstype.setBanzhu(member);
            }

		}
        request.setAttribute("ctlist",ctlist);
    }

    public void getNews(HttpServletRequest request){
        List<News> newslist = newsDAO.selectAll(null);
        request.setAttribute("newslist",newslist);
    }

    //今日话题
    public void getNowTzinfo(HttpServletRequest request){
        HashMap zzz = new HashMap();
        HashMap jjj = new HashMap();
        zzz.put("savetime", Info.getDateStr().substring(0,10));
        zzz.put("isfb","是");
        List<Tzinfo> nowtzinfolist = tzinfoDAO.selectAll(zzz);
        for(Tzinfo tzinfo:nowtzinfolist){
            jjj.put("tzid",tzinfo.getId());
            List<Tzhtinfo> tzhtlist = tzhtinfoDAO.selectAll(jjj);
            for(Tzhtinfo tzhtinfo:tzhtlist){
                Member member = memberDAO.findById(tzhtinfo.getAuthor());
                tzhtinfo.setHtmember(member);
            }
            tzinfo.setTophtlist(tzhtlist);
        }
        request.setAttribute("nowtzinfolist",nowtzinfolist);
    }


    //回貼
    public void getTzinfoHt(HttpServletRequest request,String tzid){
        HashMap ccc = new HashMap();
        ccc.put("tzid",tzid);
        List<Tzhtinfo> tzhtlist = tzhtinfoDAO.selectAll(ccc);
        for(Tzhtinfo tzhtinfo:tzhtlist){
            Member member = memberDAO.findById(tzhtinfo.getAuthor());
            tzhtinfo.setHtmember(member);
            HashMap ddd = new HashMap();
            ddd.put("htid", tzhtinfo.getId());
            List<Hthf> hthflist = hthfDAO.selectAll(ddd);
            for(Hthf hthf:hthflist){
                Member eee = memberDAO.findById(Integer.parseInt(hthf.getMemberid()));
                hthf.setMember(eee);
            }
            tzhtinfo.setHthflist(hthflist);
        }
        request.setAttribute("tzhtlist",tzhtlist);
    }



    //周排行
    public void getlookweek(String fid,HttpServletRequest request){
        String weektime = Info.getDay(Info.getDateStr(), -7);
        HashMap map = new HashMap();
        map.put("weektime",weektime);
        map.put("nowtime",Info.getDateStr().substring(0, 10));
        map.put("monthtime","");
        map.put("fid",fid);
        List<Lookrecord> weeklist = lookrecordDAO.selectdistinct(map);
        for(Lookrecord lookrecord:weeklist){
            Tzinfo tzinfo = tzinfoDAO.findById(Integer.parseInt(lookrecord.getTzid()));
            lookrecord.setTzinfo(tzinfo);
        }
        request.setAttribute("weeklist", weeklist);

    }
    //月排行
    public void getlookmonth(String fid,HttpServletRequest request){
        String monthtime = Info.getDay(Info.getDateStr(), -30);
        HashMap map = new HashMap();
        map.put("weektime","");
        map.put("monthtime",monthtime);
        map.put("fid",fid);
        map.put("nowtime",Info.getDateStr().substring(0, 10));
        List<Lookrecord> monthlist = lookrecordDAO.selectdistinct(map);
        for(Lookrecord lookrecord:monthlist){
            Tzinfo tzinfo = tzinfoDAO.findById(Integer.parseInt(lookrecord.getTzid()));
            lookrecord.setTzinfo(tzinfo);
        }
        request.setAttribute("monthlist", monthlist);
    }


    //总排行
    public void getlookmax(String fid,HttpServletRequest request){
        HashMap map = new HashMap();
        map.put("ph","ph");
        map.put("fid",fid);
        List<Tzinfo> phlist = tzinfoDAO.selectAll(map);
        request.setAttribute("phlist", phlist);
    }


}
