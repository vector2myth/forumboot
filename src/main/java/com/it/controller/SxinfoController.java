package com.it.controller;

import javax.annotation.Resource;


import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.*;

import com.github.pagehelper.PageInfo;
import com.it.dao.MemberDAO;
import com.it.dao.SxinfoDAO;
import com.it.entity.Jbrecord;
import com.it.entity.Member;
import com.it.entity.Sxinfo;
import com.it.util.Info;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import com.github.pagehelper.Page;
import com.github.pagehelper.PageHelper;
import org.springframework.web.bind.annotation.RequestParam;

import java.util.*;

@Controller
public class SxinfoController extends BaseController {
	@Resource
    SxinfoDAO sxinfoDAO;
	@Resource
    MemberDAO memberDAO;
	
	
	//查找私信人到私信添加页面
	@RequestMapping("sxShow")
	public String sxShow(int memberid,int sxmemberid, HttpServletRequest request) {
		Member member = memberDAO.findById(sxmemberid);
		request.setAttribute("sxmember", member);
		request.setAttribute("memberid", memberid);
		return "sxadd";
	}
	
	//添加私信
	@RequestMapping("sxAdd")
	public void jinyanJc(Sxinfo sxinfo, HttpServletRequest request, HttpServletResponse response) {
		try {
			sxinfo.setHfnote("");
			sxinfo.setSavetime(Info.getDateStr());
			sxinfoDAO.add(sxinfo);
			PrintWriter out = response.getWriter();
			out.print(sxinfo.getSxmemberid());
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
	}
	
	//前台页面查询私信
	@RequestMapping("mysendSx")
	public String newsList(@RequestParam(defaultValue = "1", value = "pageNum") Integer pageNum, HttpServletRequest request) {
		Member member = (Member)request.getSession().getAttribute("member");
        HashMap map = new HashMap();
        map.put("memberid", member.getId());
        PageHelper.startPage(pageNum, 10);
		List<Sxinfo> list = sxinfoDAO.selectAll(map);
		for(Sxinfo sxinfo:list){
			Member sxmember = memberDAO.findById(sxinfo.getSxmemberid());
			sxinfo.setSxmember(sxmember);
		}
        PageInfo<Sxinfo> pageInfo = new PageInfo<Sxinfo>(list);
        request.setAttribute("pageInfo", pageInfo);
		return "mysendsx";
	}
	
	//我接收到的私信
	@RequestMapping("myrecSx")
	public String myrecSx(@RequestParam(defaultValue = "1", value = "pageNum") Integer pageNum,HttpServletRequest request) {
		Member mmm = (Member)request.getSession().getAttribute("member");
        HashMap map = new HashMap();
        map.put("sxmemberid", mmm.getId());
        PageHelper.startPage(pageNum, 10);
        List<Sxinfo> list = sxinfoDAO.selectAll(map);
		for(Sxinfo sxinfo:list){
			Member member = memberDAO.findById(sxinfo.getMemberid());
			Member sxmember = memberDAO.findById(sxinfo.getSxmemberid());
			sxinfo.setMember(member);
			sxinfo.setSxmember(sxmember);
		}
        PageInfo<Sxinfo> pageInfo = new PageInfo<Sxinfo>(list);
        request.setAttribute("pageInfo", pageInfo);
		return "myrecsx";
	}
	
	//回复私信
	@RequestMapping("sxHf")
	public void sxHf(HttpServletRequest request,HttpServletResponse response) {
		try {
			String id = request.getParameter("id");
			String hfnote = request.getParameter("hfnote");
			HashMap<String, String> map = new HashMap<String, String>();
			map.put("id", id);
			map.put("hfnote", hfnote);
			sxinfoDAO.updateSxHf(map);
			PrintWriter out = response.getWriter();
			out.print(0);
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
	}
	
	//删除私信
	@RequestMapping("sxDel")
	public String sxDel(int id, HttpServletRequest request) {
		String type = request.getParameter("type");
		if(type.equals("send")){
		sxinfoDAO.delete(id);
		return "redirect:mysendSx";
		}else{
			sxinfoDAO.delete(id);
			return "redirect:myrecSx";
		}
	}
	

}
