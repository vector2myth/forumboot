package com.it.controller;

import javax.annotation.Resource;


import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.*;

import com.github.pagehelper.PageInfo;
import com.it.dao.YqlinkDAO;
import com.it.entity.Yqlink;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import com.github.pagehelper.Page;
import com.github.pagehelper.PageHelper;
import org.springframework.web.bind.annotation.RequestParam;

import java.util.*;

@Controller
public class YqlinkController extends BaseController {
	@Resource
    YqlinkDAO yqlinkDAO;
	
	//后台版块列表
	@RequestMapping("admin/yqlinkList")
	public String yqlinkList(@RequestParam(defaultValue = "1", value = "pageNum") Integer pageNum, HttpServletRequest request) {
        String key = request.getParameter("key");
        HashMap map = new HashMap();
        map.put("key", key);
        PageHelper.startPage(pageNum, 10);
		List<Yqlink> list = yqlinkDAO.selectAll(map);
        PageInfo<Yqlink> pageInfo = new PageInfo<Yqlink>(list);
        request.setAttribute("pageInfo", pageInfo);
        request.setAttribute("key", key);
		return "yqlinklist";
	}
	
	//添加友情链接
	@RequestMapping("admin/yqlinkAdd")
	public String yqlinkAdd(Yqlink yqlink, HttpServletRequest request) {
		yqlinkDAO.add(yqlink);	
		return "redirect:yqlinkList";
	}
	
	//显示友情链接信息
	@RequestMapping("admin/yqlinkShow")
	public String yqlinkShow(int id, HttpServletRequest request) {
		Yqlink yqlink = yqlinkDAO.findById(id);
		request.setAttribute("yqlink", yqlink);
		return "yqlinkedit";
	}
	
	//编辑友情链接
	@RequestMapping("admin/yqlinkEdit")
	public String yqlinkEdit(Yqlink yqlink, HttpServletRequest request) {
		yqlinkDAO.update(yqlink);
		return "redirect:yqlinkList";
	}
	
	//删除类别
	@RequestMapping("admin/yqlinkDel")
	public String yqlinkDel(int id, HttpServletRequest request) {
		yqlinkDAO.delete(id);
		return "redirect:yqlinkList";
	}
	

	

}
