package com.it.controller;

import javax.annotation.Resource;


import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.*;

import com.github.pagehelper.PageInfo;
import com.it.dao.JbrecordDAO;
import com.it.dao.MemberDAO;
import com.it.entity.Jbrecord;
import com.it.entity.Member;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import com.github.pagehelper.Page;
import com.github.pagehelper.PageHelper;
import org.springframework.web.bind.annotation.RequestParam;

import java.util.*;

@Controller
public class JbrecordController extends BaseController {
	@Resource
    JbrecordDAO jbrecordDAO;
	@Resource
    MemberDAO memberDAO;
	
	//关注
	@RequestMapping("jbShow")
	public String jbShow( int jbmemberid,HttpServletRequest request){
		Member member = memberDAO.findById(jbmemberid);
		request.setAttribute("jbmember", member);
		return "jbadd";
	}
	
	//举报添加
	@RequestMapping("jbAdd")
	public void jbAdd(HttpServletRequest request,HttpServletResponse response) {
		try {
			String memberid = request.getParameter("memberid");
			String jbmemberid = request.getParameter("jbmemberid");
			String note = request.getParameter("note");
			PrintWriter out = response.getWriter();
			HashMap map = new HashMap();
			map.put("memberid", memberid);
			map.put("jbmemberid", jbmemberid);
			List<Jbrecord> list = jbrecordDAO.selectAll(map);
			if(list.size()==0){
				Jbrecord jbrecord  = new Jbrecord();
				jbrecord.setMemberid(Integer.parseInt(memberid));
				jbrecord.setNote(note);
				jbrecord.setJbmemberid(Integer.parseInt(jbmemberid));
				jbrecordDAO.add(jbrecord);
				out.print(0);
			}else{
				out.print(1);
			}
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
	}
	
	//后台举报列表
	@RequestMapping("admin/jbList")
	public String jbList(@RequestParam(defaultValue = "1", value = "pageNum") Integer pageNum, HttpServletRequest request) {
	    String key = request.getParameter("key");
        HashMap map = new HashMap();
        map.put("key", key);
        PageHelper.startPage(pageNum, 10);
		List<Jbrecord> list = jbrecordDAO.selectAll(map);
		for(Jbrecord jbrecord:list){
			Member member = memberDAO.findById(jbrecord.getMemberid());
			Member jbmember = memberDAO.findById(jbrecord.getJbmemberid());
			jbrecord.setMember(member);
			jbrecord.setJbmember(jbmember);
		}
        PageInfo<Jbrecord> pageInfo = new PageInfo<Jbrecord>(list);
        request.setAttribute("pageInfo", pageInfo);
		return "jblist";
	}
	
	//删除举报信息
	@RequestMapping("admin/jbDel")
	public String jbDel(int id,HttpServletRequest request) {
		jbrecordDAO.delete(id);
		return "redirect:jbList";
	}
	

}
