package com.it.controller;

import javax.annotation.Resource;


import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.*;

import com.it.dao.MemberDAO;
import com.it.dao.SigninDAO;
import com.it.entity.Signin;
import com.it.util.Info;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import com.github.pagehelper.Page;
import com.github.pagehelper.PageHelper;

import java.util.*;

@Controller
public class SigninController extends BaseController {
	@Resource
    MemberDAO memberDAO;
	@Resource
    SigninDAO signinDAO;
	
	@RequestMapping("signinAdd")
	public void signinAdd(HttpServletRequest request, HttpServletResponse response){
		try {
			String memberid = request.getParameter("memberid");
			PrintWriter out = response.getWriter();
			HashMap map = new HashMap();
			map.put("memberid", memberid);
			map.put("savetime", Info.getDateStr().substring(0,10));
			List<Signin> list = signinDAO.isSignin(map);
			if(list.size()==0){
				Signin sg = new Signin();
				sg.setMemberid(Integer.parseInt(memberid));
				sg.setSavetime(Info.getDateStr().substring(0,10));
				signinDAO.add(sg);
				out.print(0);
			}else{
				out.print(1);
			}
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	
	

}
