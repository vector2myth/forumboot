package com.it.controller;

import javax.annotation.Resource;


import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.*;

import com.it.dao.UserDAO;
import com.it.entity.User;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import com.github.pagehelper.Page;
import com.github.pagehelper.PageHelper;

import java.util.*;

@Controller
public class UserController extends BaseController {
	@Resource
    UserDAO userDao;
	
	@RequestMapping("admin/login")
	public String login(User user , HttpServletRequest request, HttpServletResponse response) {
			user.setUserpassword(user.getUserpassword());
		    List<User> list = userDao.selectOne(user);
		    if(list.size()==0){
		    	request.setAttribute("suc", "用户名或密码错误");
		    	return "login";
		    }else{
		    	request.getSession().setAttribute("admin", list.get(0));
		    	return "index";
		    }

	}
	
	//退出
	@RequestMapping("admin/adminExit")
	public String adminExit(HttpServletRequest request) {
		request.getSession().removeAttribute("admin");
		return "login";
	}


	@RequestMapping("admin/update")
	public String update(User user, HttpServletRequest request) {
		userDao.update(user);
		return "redirect:show?msg=msg";
	}
	
	
	@RequestMapping("admin/adminPwdEdit")
	public String updatepwd(int id,String oldpwd, HttpServletRequest request) {
		String newpwd = request.getParameter("newpwd");
		User user = userDao.findById(id);
		if(oldpwd.equals(user.getUserpassword())){
			userDao.updatepwd(id,newpwd);
			request.setAttribute("suc", "操作成功");
		}else{
			request.setAttribute("suc", "原密码错误");
		}
		return "myaccount";
	}

	
	@RequestMapping("admin/adminShow")
	public String showid(HttpServletRequest request) {
		User u = (User)request.getSession().getAttribute("admin");
		User user = userDao.findById(u.getId());
		request.setAttribute("user", user);
		return "useredit";
	}
	
	@RequestMapping("admin/userEdit")
	public String userEdit(User user, HttpServletRequest request) {
		userDao.update(user);
		return "useredit";
	}
	
	
	
	//检查用户名的唯一性
	@RequestMapping("admin/checkUsername")
	public void checkUsername(String username, HttpServletRequest request, HttpServletResponse response){
		try {
			PrintWriter out = response.getWriter();
			List<User> list = userDao.checkUsername(username);
			if(list.size()==0){
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
