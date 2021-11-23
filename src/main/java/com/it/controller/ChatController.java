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
public class ChatController extends BaseController {
	@Resource
    ChatDAO chatDAO;
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
    SaveObject saveObject;
	
	//前台意见和建议
	@RequestMapping("chatList")
	public String chatList(@RequestParam(defaultValue = "1", value = "pageNum") Integer pageNum, HttpServletRequest request){
        saveObject.getYqlink(request);
        saveObject.getNews(request);
        saveObject.getNews(request);
        saveObject.getNowTzinfo(request);
		//List<Tzinfo> nowtzinfolist = tzinfoDAO.selectNowtzinfo(Info.getDateStr().substring(0,10));
		//List<News> newslist = newsDAO.selectAll();

        HashMap map = new HashMap();
        PageHelper.startPage(pageNum, 10);
		List<Chat> list = chatDAO.selectAll(null);
		for(Chat chat:list){
			Member member = memberDAO.findById(chat.getMemberid());
			chat.setMember(member);
		}
        PageInfo<Chat> pageInfo = new PageInfo<Chat>(list);
        request.setAttribute("pageInfo", pageInfo);
		return "yjjy";
	}
	
	//后台意见和建议
	@RequestMapping("admin/msgList")
	public String msgList(@RequestParam(defaultValue = "1", value = "pageNum") Integer pageNum,HttpServletRequest request){
	    String key = request.getParameter("key");
        HashMap map = new HashMap();
        map.put("key",key);
        PageHelper.startPage(pageNum, 10);
		List<Chat> list = chatDAO.selectAll(map);
		for(Chat chat:list){
			Member member = memberDAO.findById(chat.getMemberid());
			chat.setMember(member);
		}
        PageInfo<Chat> pageInfo = new PageInfo<Chat>(list);
        request.setAttribute("pageInfo", pageInfo);
        request.setAttribute("key", key);
		return "msglist";
	}


	//意见和建议添加
	@RequestMapping("chatAdd")
	public void chatAdd(Chat chat, HttpServletRequest request,HttpServletResponse response) {
		try {
			chat.setSavetime(Info.getDateStr());
			chat.setHfmsg("");
			chatDAO.add(chat);
			PrintWriter out = response.getWriter();
			out.print(0);
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
	}
	
	//管理员回复意见和建议
	@RequestMapping("admin/chatEdit")
	public String chatAdd(Chat chat, HttpServletRequest request) {
			chatDAO.update(chat);
		return "redirect:msgList";
		
	}
	
	
	//删除 
	@RequestMapping("admin/chatDel")
	public String chatDel(int id, HttpServletRequest request) {
			chatDAO.delete(id);
		return "redirect:msgList";
		
	}
	
	
	

}
