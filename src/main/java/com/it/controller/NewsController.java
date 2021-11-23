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
public class NewsController extends BaseController {
	@Resource
    NewsDAO newsDAO;
	@Resource
    MemberDAO memberDAO;
	@Resource
    BbstypeDAO bbstypeDAO;
	@Resource
    YqlinkDAO yqlinkDAO;
	@Resource
    TzinfoDAO tzinfoDAO;
    @Resource
    SaveObject saveObject;
	//后台新闻列表
	@RequestMapping("admin/newsList")
	public String newsList(@RequestParam(defaultValue = "1", value = "pageNum") Integer pageNum, HttpServletRequest request) {
        String key = request.getParameter("key");
        HashMap map = new HashMap();
        map.put("key", key);
        PageHelper.startPage(pageNum, 10);
		List<News> list = newsDAO.selectAll(map);
        PageInfo<News> pageInfo = new PageInfo<News>(list);
        request.setAttribute("pageInfo", pageInfo);
        request.setAttribute("key", key);
		return "newslist";
	}

	//新增新闻
	@RequestMapping("admin/newsAdd")
	public String newsAdd(News news, HttpServletRequest request) {
		news.setSavetime(Info.getDateStr());
		newsDAO.add(news);
		return "redirect:newsList";
	}
	
    //删除新闻
	@RequestMapping("admin/newsDel")
	public String newsDel(int id, HttpServletRequest request) {
		newsDAO.delete(id);
		return "redirect:newsList";
	}
	
	//ID查找新闻
	@RequestMapping("admin/newsShow")
	public String newsShow(int id, HttpServletRequest request) {
		News news = newsDAO.findById(id);
		request.setAttribute("news", news);
		return "newsedit";
	}
	
	//更新新闻
	@RequestMapping("admin/newsEdit")
	public String newsDel(News news, HttpServletRequest request) {
		newsDAO.update(news);
		return "redirect:newsList";
	}
	
	//前台新闻详情
	@RequestMapping("newsDetail")
	public String newsDetail(int id, HttpServletRequest request) {
        saveObject.getYqlink(request);
        saveObject.getNews(request);
        saveObject.getNowTzinfo(request);
		News news = newsDAO.findById(id);
		request.setAttribute("news", news);
		return "newsdetail";
	}
	

}
