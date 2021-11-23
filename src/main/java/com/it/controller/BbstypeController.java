package com.it.controller;

import javax.annotation.Resource;


import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.*;

import com.github.pagehelper.PageInfo;
import com.it.dao.BanzhuDAO;
import com.it.dao.BbstypeDAO;
import com.it.dao.MemberDAO;
import com.it.entity.Banzhu;
import com.it.entity.Bbstype;
import com.it.entity.Member;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import com.github.pagehelper.Page;
import com.github.pagehelper.PageHelper;
import org.springframework.web.bind.annotation.RequestParam;

import java.util.*;

@Controller
public class BbstypeController extends BaseController {
	@Resource
    BbstypeDAO bbstypeDAO;
	@Resource
    BanzhuDAO banzhuDAO;
	@Resource
    MemberDAO memberDAO;
	
	
	
	//后台版块列表
	@RequestMapping("admin/bbstypeList")
	public String bbstypeList(@RequestParam(defaultValue = "1", value = "pageNum") Integer pageNum, HttpServletRequest request) {
        String key = request.getParameter("key");
        HashMap map = new HashMap();
        map.put("key", key);
        map.put("fatherid", "0");
        HashMap mmm = new HashMap();
        PageHelper.startPage(pageNum, 10);
		List<Bbstype> list = bbstypeDAO.selectAll(map);
		for(Bbstype bbstype:list){
            mmm.put("fatherid",bbstype.getId());
			List<Bbstype> childlist  = bbstypeDAO.selectAll(mmm);
            bbstype.setChildlist(childlist);

			List<Banzhu> banzhulist = banzhuDAO.selectOne(bbstype.getId());
			if(banzhulist.size()!=0){
				Member banzhu = memberDAO.findById(Integer.parseInt(banzhulist.get(0).getMemberid()));
                bbstype.setBanzhu(banzhu);
			}
		}
        PageInfo<Bbstype> pageInfo = new PageInfo<Bbstype>(list);
        request.setAttribute("pageInfo", pageInfo);
        request.setAttribute("key", key);
		return "bbstypelist";
	}
	
	//添加大类
	@RequestMapping("admin/bbstypeAdd")
	public String bbstypeAdd(Bbstype bbstype, HttpServletRequest request) {
		String type = request.getParameter("type");
		if(type!=null&&type.equals("child")){
			Bbstype  bt = new Bbstype();
		}else{
		bbstypeDAO.add(bbstype);	
		}
		return "redirect:bbstypeList";
	}
	
	//显示版块信息
	@RequestMapping("admin/bbstypeShow")
	public String bbstypeShow(int id, HttpServletRequest request) {
		Bbstype bbstype = bbstypeDAO.findById(id);
		request.setAttribute("bbstype", bbstype);
		return "bbstypeedit";
	}
	
	//编辑大类
	@RequestMapping("admin/bbstypeEdit")
	public String bbstypeEdit(Bbstype bbstype, HttpServletRequest request) {
		bbstypeDAO.update(bbstype);
		return "redirect:bbstypeList";
	}
	
	//删除类别
	@RequestMapping("admin/bbstypeDel")
	public String bbstypeDel(int id, HttpServletRequest request) {
	    Bbstype bbstype = bbstypeDAO.findById(id);
        bbstype.setDelstatus("1");
		bbstypeDAO.update(bbstype);
		return "redirect:bbstypeList";
	}
	

	
	//ajax查找子类
	@RequestMapping("admin/searchBbstype")
	public void searchBbstype(HttpServletRequest request,HttpServletResponse response) {
		try {
			response.setContentType("text/html;charset=utf-8");
			PrintWriter out = response.getWriter();
			String fid = request.getParameter("fid");
			HashMap map = new HashMap();
			map.put("fatherid",fid);
			List<Bbstype> stypelist = bbstypeDAO.selectAll(map);
			String optionstr = "";
			for(Bbstype bbstype:stypelist){
				optionstr +="<option value="+bbstype.getId()+">"+bbstype.getTypename()+"</option>";
			}
			//System.out.println("optionstr==="+optionstr);
			out.print(optionstr);
			out.close();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	
	
	//撤消版主
	@RequestMapping("admin/bzDel")
	public void bzDel(Banzhu banzhu, HttpServletRequest request,HttpServletResponse response) {
		try {
			banzhuDAO.delete(banzhu);
			PrintWriter out = response.getWriter();
			out.print(0);
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
	}

}
