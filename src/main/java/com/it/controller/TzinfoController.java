package com.it.controller;

import javax.annotation.Resource;


import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.*;

import com.github.pagehelper.PageInfo;
import com.it.dao.*;
import com.it.entity.*;
import com.it.util.Info;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import com.github.pagehelper.Page;
import com.github.pagehelper.PageHelper;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.util.*;

@Controller
public class TzinfoController extends BaseController {
	@Resource
    TzinfoDAO tzinfoDAO;
	@Resource
    BbstypeDAO bbstypeDAO;
	@Resource
    MemberDAO memberDAO;
	@Resource
    NewsDAO newsDAO;
	@Resource
	YqlinkDAO yqlinkDAO;
	@Resource
    PbinfoDAO pbinfoDAO;
	@Resource
	TzhtinfoDAO tzhtinfoDAO;
	@Resource
	BanzhuDAO banzhuDAO;
	@Resource
	FavDAO favDAO;
    @Resource
    SaveObject saveObject;
    @Resource
    LookrecordDAO lookrecordDAO;


	
	//后台版块列表
	@RequestMapping("admin/tzinfoList")
	public String tzinfoList(@RequestParam(defaultValue = "1", value = "pageNum") Integer pageNum, HttpServletRequest request) {
		saveObject.getCategory(request);
        String key = request.getParameter("key");
        String fid = request.getParameter("fid");
        String sid = request.getParameter("sid");
        HashMap map = new HashMap();
        map.put("key", key);
        map.put("fid", fid);
        map.put("sid", sid);
        PageHelper.startPage(pageNum, 10);
		List<Tzinfo> list = tzinfoDAO.selectAll(map);
		for(Tzinfo tzinfo:list){
			Bbstype ftype = bbstypeDAO.findById(Integer.parseInt(tzinfo.getFid()));
			Bbstype stype = bbstypeDAO.findById(Integer.parseInt(tzinfo.getSid()));
			tzinfo.setStype(stype);
			tzinfo.setFtype(ftype);
			//查看回贴数
           saveObject.getTzinfoHt(request,String.valueOf(tzinfo.getId()));
		}
        PageInfo<Tzinfo> pageInfo = new PageInfo<Tzinfo>(list);
        request.setAttribute("pageInfo", pageInfo);
        request.setAttribute("key", key);
        request.setAttribute("fid", fid);
        request.setAttribute("sid", sid);

        if(fid!=null && !fid.equals("") ){
            HashMap fff= new HashMap();
            fff.put("fatherid",fid);
            List<Bbstype> childlist = bbstypeDAO.selectAll(fff);
            request.setAttribute("childlist",childlist);
        }
		return "tzlist";
	}

	//查找发贴人到贴子添加页面
	@RequestMapping("tzShowmember")
	public String tzShowmember(HttpServletRequest request) {
		Member m = (Member)request.getSession().getAttribute("member");
		if(m!=null){
		Member member = memberDAO.findById(m.getId());
		saveObject.getCategory(request);
		request.setAttribute("member", member);
		return "tzadd";
		}else{
		return "login";
		}
	}
	
	//发贴
	@RequestMapping("tzinfoAdd")
	public String tzinfoAdd(Tzinfo tzinfo,HttpServletRequest request) {
        Bbstype stype = bbstypeDAO.findById(Integer.parseInt(tzinfo.getSid()));
		tzinfo.setSavetime(Info.getDateStr());
		tzinfo.setLooknum(0);
		tzinfo.setDznum(0);
		tzinfo.setFid(stype.getFatherid());
		tzinfo.setUpdatetime("");
		tzinfo.setIstop("no");
		tzinfo.setIsjh("no");
		tzinfoDAO.add(tzinfo);
		return "redirect:memberCenter";
	}
	
	
	//贴子详情
	@RequestMapping("tzDetail")
	public String tzDetail(int id, HttpServletRequest request) {
        saveObject.getYqlink(request);
        saveObject.getCategory(request);
        saveObject.getNews(request);
        saveObject.getNowTzinfo(request);
        saveObject.getTzinfoHt(request,String.valueOf(id));


        Tzinfo tzinfo = tzinfoDAO.findById(id);
        //浏览次数
        tzinfo.setLooknum(tzinfo.getLooknum()+1);
        tzinfoDAO.update(tzinfo);
        Lookrecord lookrecord = new Lookrecord();
        lookrecord.setSavetime(Info.getDateStr().substring(0,10 ));
        lookrecord.setFid(tzinfo.getFid());
        lookrecord.setTzid(String.valueOf(id));
        lookrecordDAO.add(lookrecord);



		Member mmm = (Member)request.getSession().getAttribute("member");
		Member member = memberDAO.findById(tzinfo.getAuthor());
		tzinfo.setMember(member);
		request.setAttribute("tzinfo", tzinfo);


		//收藏
		if(mmm!=null){
		HashMap map = new HashMap();
		map.put("tzid", id);
		map.put("memberid", mmm.getId());
		List<Fav> fvlist = favDAO.selectAll(map);
		request.setAttribute("fvlist", fvlist);
		}
		//查看是否是版主
		String isbz = "";
		if(mmm!=null){
		HashMap map = new HashMap();
		map.put("memberid",String.valueOf(mmm.getId()));
        map.put("fid",tzinfo.getFid());
		List<Banzhu> banzhulist = banzhuDAO.selectAll(map);
		if(banzhulist.size()!=0){
			isbz="isbz";
		}
		}
		request.setAttribute("isbz", isbz);


		//浏览历史

		return "tzdetail";
	}
	
	//前台贴子列表页
	@RequestMapping("tzList")
	public String tzList(@RequestParam(defaultValue = "1", value = "pageNum") Integer pageNum,HttpServletRequest request) {
        saveObject.getYqlink(request);
        saveObject.getNowTzinfo(request);
        saveObject.getNews(request);
        saveObject.getCategory(request);
		Member mmm = (Member)request.getSession().getAttribute("member");

		//精华或置顶
        String fid = request.getParameter("fid");
        String sid = request.getParameter("sid");

        saveObject.getlookweek(fid,request);
        saveObject.getlookmonth(fid,request);
        saveObject.getlookmax(fid,request);


        HashMap map = new HashMap();
        map.put("istop","yes");
        map.put("fid",fid);
        map.put("sid",sid);
        map.put("isfb","是");
		List<Tzinfo> toplist = tzinfoDAO.selectAll(map);
		for(Tzinfo toptzinfo:toplist){
			Bbstype stype = bbstypeDAO.findById(Integer.parseInt(toptzinfo.getSid()));
			Member member = memberDAO.findById(toptzinfo.getAuthor());
			toptzinfo.setStype(stype);
			toptzinfo.setMember(member);

            //普通回帖
            HashMap ppp = new HashMap();
            ppp.put("tzid",toptzinfo.getId());
            List<Tzhtinfo> pthtlist = tzhtinfoDAO.selectAll(ppp);
            toptzinfo.setTophtlist(pthtlist);
		}
		HashMap map1 = new HashMap();
        map1.put("fatherid",fid);
		List<Bbstype> childlist = bbstypeDAO.selectAll(map1);
		request.setAttribute("childlist",childlist);


   	    //过滤屏蔽的帖子
   	    List parlist = new ArrayList<String>();
   	    if(mmm!=null){
   	    List<Pbinfo> pbinfolist = pbinfoDAO.selectPbmember(mmm.getId());
   	    for(Pbinfo pbinfo:pbinfolist){
   	    	parlist.add(pbinfo.getPbmemberid()+",");
   	    }
   	    }
   	    map.put("parlist", parlist);

   	    map.put("istop","no");
        PageHelper.startPage(pageNum, 10);
		List<Tzinfo> ptlist = tzinfoDAO.selectAll(map);
		for(Tzinfo tzinfo:ptlist){
			Bbstype stype = bbstypeDAO.findById(Integer.parseInt(tzinfo.getSid()));
			Member member = memberDAO.findById(tzinfo.getAuthor());
			tzinfo.setStype(stype);
			tzinfo.setMember(member);
			//普通回帖
            HashMap ppp = new HashMap();
            ppp.put("tzid",tzinfo.getId());
			List<Tzhtinfo> pthtlist = tzhtinfoDAO.selectAll(ppp);
			tzinfo.setPthtlist(pthtlist);
		}
        PageInfo<Tzinfo> pageInfo = new PageInfo<Tzinfo>(ptlist);
        request.setAttribute("pageInfo", pageInfo);
		request.setAttribute("fid", fid);
		request.setAttribute("toplist", toplist);
		return "tzlist";
	}
	
	//帖子置顶
	@RequestMapping("tzzd")
	public void tzzd(int id, HttpServletRequest request,HttpServletResponse response) {
		
		try {
		    Tzinfo tzinfo = tzinfoDAO.findById(id);
		    if(tzinfo.getIstop().equals("no")){
                tzinfo.setIstop("yes");
            }else{
                tzinfo.setIstop("no");
            }
            tzinfoDAO.update(tzinfo);
			PrintWriter out = response.getWriter();
			out.print(id);
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
	}
	
	//后台帖子置顶
	@RequestMapping("admin/tzzdAdmin")
	public String topTzinfo(int id, HttpServletRequest request,HttpServletResponse response) {
            Tzinfo tzinfo = tzinfoDAO.findById(id);
            if(tzinfo.getIstop().equals("no")){
                tzinfo.setIstop("yes");
            }else{
                tzinfo.setIstop("no");
            }
            tzinfoDAO.update(tzinfo);
            return "redirect:tzinfoList";
		
	}
	

	
	//帖子加精
	@RequestMapping("tzjj")
	public void tzjj(int id, HttpServletRequest request,HttpServletResponse response) {
		try {
            Tzinfo tzinfo = tzinfoDAO.findById(id);
            if(tzinfo.getIsjh().equals("no")){
                tzinfo.setIsjh("yes");
            }else{
                tzinfo.setIsjh("no");
            }
            tzinfoDAO.update(tzinfo);
			PrintWriter out = response.getWriter();
			out.print(id);
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
	}

    //帖子加精
    @RequestMapping("admin/tzjjAdmin")
    public String tzjjAdmin(int id, HttpServletRequest request,HttpServletResponse response) {
            Tzinfo tzinfo = tzinfoDAO.findById(id);
            if(tzinfo.getIsjh().equals("no")){
                tzinfo.setIsjh("yes");
            }else{
                tzinfo.setIsjh("no");
            }
            tzinfoDAO.update(tzinfo);
        return "redirect:tzinfoList";
    }
	

	
	//查找帖子到编辑帖子页面
	@RequestMapping("tzinfoShow")
	public String tzinfoShow(int id,HttpServletRequest request) {
	    saveObject.getCategory(request);
		Member m = (Member)request.getSession().getAttribute("member");
		Member member = memberDAO.findById(m.getId());
		Tzinfo tzinfo = tzinfoDAO.findById(id);
		request.setAttribute("member", member);
		request.setAttribute("tzinfo", tzinfo);
		return "tzedit";
	}
	
	//编辑帖子
	@RequestMapping("tzinfoEdit")
	public String tzinfoEdit(Tzinfo tzinfo, HttpServletRequest request, RedirectAttributes redirectAttributes) {
        Bbstype bbstype = bbstypeDAO.findById(Integer.parseInt(tzinfo.getSid()));
        tzinfo.setFid(bbstype.getFatherid());
		tzinfoDAO.update(tzinfo);
        redirectAttributes.addFlashAttribute("message","编辑成功");
		return "redirect:tzinfoShow?id="+tzinfo.getId();
	}
	
	
	//删除贴子和回贴
	@RequestMapping("admin/tzinfoDel")
	public String tzinfoDel(int id,HttpServletRequest request,HttpServletResponse response) {
	        HashMap map = new HashMap();
	        map.put("tzid",id);
			List<Tzhtinfo> htlist = tzhtinfoDAO.selectAll(map);
			for(Tzhtinfo tzhtinfo:htlist){
				tzhtinfoDAO.delete(tzhtinfo.getId());
			}
			tzinfoDAO.delete(id);
        return "redirect:tzinfoList";
	}

    //删除贴子和回贴
    @RequestMapping("tzinfoSc")
    public String tzinfoSc(int id,HttpServletRequest request,HttpServletResponse response) {
        HashMap map = new HashMap();
        map.put("tzid",id);
        List<Tzhtinfo> htlist = tzhtinfoDAO.selectAll(map);
        for(Tzhtinfo tzhtinfo:htlist){
            tzhtinfoDAO.delete(tzhtinfo.getId());
        }
        tzinfoDAO.delete(id);
        return "redirect:memberCenter";
    }


	//迁移贴子
	@RequestMapping("admin/findBbstype")
	public String findBbstype(HttpServletRequest request) {
	    saveObject.getCategory(request);
		String id = request.getParameter("id");
		//request.setAttribute("flist", flist);
		request.setAttribute("id", id);
		return "tzmove";
	}
	
	//迁移贴子
	@RequestMapping("admin/tzMove")
	public String tzMove(HttpServletRequest request) {
		String id = request.getParameter("id");
		String sid = request.getParameter("sid");
		Bbstype bbstype = bbstypeDAO.findById(Integer.parseInt(sid));
		Tzinfo tzinfo = tzinfoDAO.findById(Integer.parseInt(id));
		tzinfo.setSid(sid);
		tzinfo.setFid(bbstype.getFatherid());
		tzinfoDAO.update(tzinfo);
		return "redirect:tzinfoList";
	}
	
	//设置帖子能否回贴
	@RequestMapping("admin/isCanht")
	public String isCanht(HttpServletRequest request) {
		String id = request.getParameter("id");
		Tzinfo tzinfo  = (Tzinfo)tzinfoDAO.findById(Integer.parseInt(id));
		if(tzinfo.getCanht().equals("yes")){
			tzinfo.setCanht("no");
		}else{
			tzinfo.setCanht("yes");
		}
		tzinfo.setId(Integer.parseInt(id));
		//tzinfoDAO.updateCanht(tzinfo);
		return "redirect:tzinfoList";
	}


	//发布帖子
    @RequestMapping("updateIsfb")
    public String updateIsfb( int id,HttpServletRequest request) {
        Tzinfo tzinfo = tzinfoDAO.findById(id);
        tzinfo.setIsfb("是");
        tzinfoDAO.update(tzinfo);
        return "redirect:memberCenter";
    }
	

}
