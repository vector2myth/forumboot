package com.it.controller;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.it.dao.*;
import com.it.entity.Hthf;
import com.it.entity.Member;
import com.it.util.Info;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import java.util.HashMap;
import java.util.List;

@Controller
public class HthfController extends BaseController {
	@Resource
    HthfDAO hthfDAO;
	@Resource
    MemberDAO memberDAO;

	//新增跟帖
    @ResponseBody
	@RequestMapping("hthfAdd")
	public HashMap<String,Object> hthfAdd(Hthf hthf, HttpServletRequest request) {
        HashMap<String,Object> res = new HashMap<String,Object>();
        Member  member = (Member)request.getSession().getAttribute("member");
        if(member!=null){
            hthf.setMemberid(String.valueOf(member.getId()));
            hthf.setSavetime(Info.getDateStr());
            hthfDAO.add(hthf);
            res.put("data", 200);
        }else{
            res.put("data", 400);
        }
        return res;
	}
	

	

}
