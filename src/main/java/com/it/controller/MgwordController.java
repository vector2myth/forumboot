package com.it.controller;

import javax.annotation.Resource;


import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.*;

import com.github.pagehelper.PageInfo;
import com.it.dao.MgwordDAO;
import com.it.entity.Mgword;
import com.it.entity.News;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import com.github.pagehelper.Page;
import com.github.pagehelper.PageHelper;
import org.springframework.web.bind.annotation.RequestParam;

import java.util.*;

@Controller
public class MgwordController extends BaseController {
	@Resource
    MgwordDAO mgwordDAO;
	
	//后台敏感字符列表
	@RequestMapping("admin/mgwordList")
	public String newsList(@RequestParam(defaultValue = "1", value = "pageNum") Integer pageNum, HttpServletRequest request) {
        String key = request.getParameter("key");
        HashMap map = new HashMap();
        map.put("key", key);
        PageHelper.startPage(pageNum, 10);
		List<Mgword> list = mgwordDAO.selectAll(map);
        PageInfo<Mgword> pageInfo = new PageInfo<Mgword>(list);
        request.setAttribute("pageInfo", pageInfo);
        request.setAttribute("key", key);
		return "mgwordlist";
	}
	

	
	//添加敏感学符
	@RequestMapping("admin/mgwordAdd")
	public String mgwordAdd(Mgword mgword, HttpServletRequest request) {
		mgwordDAO.add(mgword);
		return "redirect:mgwordList";
	}
	
	//显示要修改的信息
	@RequestMapping("admin/mgwordShow")
	public String mgwordShow(int id, HttpServletRequest request) {
		Mgword mgword =mgwordDAO.findById(id);
		request.setAttribute("mgword", mgword);
		return "mgwordedit";
	}
	
	//修改敏感字符
	@RequestMapping("admin/mgwordEdit")
	public String mgwordShow(Mgword mgword, HttpServletRequest request) {
		mgwordDAO.update(mgword);
		request.setAttribute("mgword", mgword);
		return "redirect:mgwordList";
	}
	
	//删除敏感字符
	@RequestMapping("admin/mgwordDel")
	public String mgwordDel(int id, HttpServletRequest request) {
		mgwordDAO.delete(id);
		return "redirect:mgwordList";
	}
	
	

}
