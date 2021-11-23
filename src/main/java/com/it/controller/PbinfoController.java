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
import com.it.dao.PbinfoDAO;
import com.it.entity.Member;
import com.it.entity.Pbinfo;
import com.it.entity.Tzinfo;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.github.pagehelper.Page;
import com.github.pagehelper.PageHelper;
import org.springframework.web.bind.annotation.RequestParam;

import java.util.*;

@Controller
public class PbinfoController extends BaseController {
	@Resource
    PbinfoDAO pbinfoDAO;
	@Resource
    MemberDAO memberDAO;
	
	
	//屏蔽
	@RequestMapping("pbinfoAdd")
	public void pbinfoAdd(HttpServletRequest request,HttpServletResponse response){
		try {
			String memberid = request.getParameter("memberid");
			String pbmemberid = request.getParameter("pbmemberid");
			Pbinfo pbinfo = new Pbinfo();
			pbinfo.setMemberid(Integer.parseInt(memberid));
			pbinfo.setPbmemberid(Integer.parseInt(pbmemberid));
			pbinfoDAO.add(pbinfo);
			PrintWriter out = response.getWriter();
			out.print(0);
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	
	
	//取消屏蔽
	@RequestMapping("pbinfoDel")
	public void pbinfoDel(HttpServletRequest request,HttpServletResponse response){
		try {
			String memberid = request.getParameter("memberid");
			String pbmemberid = request.getParameter("pbmemberid");
			HashMap<String,String> map = new HashMap<String, String>();
			map.put("memberid", memberid);
			map.put("pbmemberid", pbmemberid);
			Pbinfo pbinfo = pbinfoDAO.selectOne(map).get(0);
			pbinfoDAO.delete(pbinfo);
			PrintWriter out = response.getWriter();
			out.print(0);
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	
	//我的屏蔽
	@RequestMapping("myPingbi")
	public String myPingbi(@RequestParam(defaultValue = "1", value = "pageNum") Integer pageNum, HttpServletRequest request) {
		Member member = (Member)request.getSession().getAttribute("member");
        HashMap map = new HashMap();
        map.put("memberid", member.getId());
        PageHelper.startPage(pageNum, 10);
		List<Pbinfo> list = pbinfoDAO.selectAll(map);
		for(Pbinfo pbinfo:list){
			Member pbmember = memberDAO.findById(pbinfo.getPbmemberid());
			pbinfo.setPbmember(pbmember);
		}
        PageInfo<Pbinfo> pageInfo = new PageInfo<Pbinfo>(list);
        request.setAttribute("pageInfo", pageInfo);
		return "mypb";
	}
	
	//取消屏蔽
	@RequestMapping("pingbiDel")
	public void pingbiDel(int id, HttpServletRequest request,HttpServletResponse response){
		try {
			pbinfoDAO.deletePingbi(id);
			PrintWriter out = response.getWriter();
			out.print(0);
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	

}
