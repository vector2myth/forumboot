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

import java.util.*;

@Controller
public class IndexController extends BaseController {
	@Resource
    MemberDAO memberDAO;
	@Resource
    BbstypeDAO bbstypeDAO;
	@Resource
    NewsDAO newsDAO;
	@Resource
    YqlinkDAO yqlinkDAO;
	@Resource
    TzinfoDAO tzinfoDAO;
	@Resource
	BanzhuDAO banzhuDAO;
	@Resource
	TzhtinfoDAO tzhtinfoDAO;
    @Resource
    SaveObject saveObject;
	
	//首页
	@RequestMapping("index")
	public String index(HttpServletRequest request){
        saveObject.getYqlink(request);
        saveObject.getCategory(request);
        saveObject.getNowTzinfo(request);
        saveObject.getNews(request);
		return "index";
	}
	
	//搜索
	@RequestMapping("search")
	public String search(@RequestParam(defaultValue = "1", value = "pageNum") Integer pageNum, HttpServletRequest request){
		String key = request.getParameter("q");
        saveObject.getYqlink(request);
		saveObject.getCategory(request);
        saveObject.getNowTzinfo(request);
        saveObject.getNews(request);

        HashMap map = new HashMap();
        map.put("key", key);
        PageHelper.startPage(pageNum, 10);
		List<Tzinfo> list = tzinfoDAO.selectAll(map);
		for(Tzinfo tzinfo:list){
			Member author = memberDAO.findById(tzinfo.getAuthor());
			Bbstype ftype = bbstypeDAO.findById(Integer.parseInt(tzinfo.getFid()));
			Bbstype stype = bbstypeDAO.findById(Integer.parseInt(tzinfo.getSid()));
			saveObject.getTzinfoHt(request,String.valueOf(tzinfo.getId()));

			tzinfo.setStype(stype);
			tzinfo.setFtype(ftype);
			tzinfo.setMember(author);
		}
        PageInfo<Tzinfo> pageInfo = new PageInfo<Tzinfo>(list);
        request.setAttribute("pageInfo", pageInfo);
		request.setAttribute("key", key);
		return "search";
	}

}
