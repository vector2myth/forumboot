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
import com.it.entity.Bbstype;
import com.it.entity.Fav;
import com.it.entity.Member;
import com.it.entity.Tzinfo;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import com.github.pagehelper.Page;
import com.github.pagehelper.PageHelper;
import org.springframework.web.bind.annotation.RequestParam;

import java.util.*;

@Controller
public class FavController extends BaseController {
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
    FavDAO favDAO;


    //后台新闻列表
    @RequestMapping("favMsg")
    public String favMsg(@RequestParam(defaultValue = "1", value = "pageNum") Integer pageNum, HttpServletRequest request) {
        Member member = (Member) request.getSession().getAttribute("member");
        if (member != null) {
            HashMap map = new HashMap();
            map.put("memberid", member.getId());
            PageHelper.startPage(pageNum, 10);
            List<Fav> list = favDAO.selectAll(map);
            for (Fav fav : list) {
                Member mmm = memberDAO.findById(fav.getMemberid());
                Tzinfo tzinfo = tzinfoDAO.findById(fav.getTzid());
                Bbstype bbstype = bbstypeDAO.findById(Integer.parseInt(tzinfo.getSid()));
                tzinfo.setStype(bbstype);
                fav.setMember(member);
                fav.setTzinfo(tzinfo);
            }
            PageInfo<Fav> pageInfo = new PageInfo<Fav>(list);
            request.setAttribute("pageInfo", pageInfo);
            return "myfav";
        } else {
            return "login";
        }
    }

    //新增新闻
    @RequestMapping("favAdd")
    public void favAdd(Fav fav, HttpServletRequest request, HttpServletResponse response) {
        try {
            PrintWriter out = response.getWriter();
            HashMap map = new HashMap();
            map.put("memberid", fav.getMemberid());
            map.put("tzid", fav.getTzid());
            List<Fav> list = favDAO.selectAll(map);
            if (list.size() == 0) {
                favDAO.add(fav);
                out.print("1");
            } else {
                out.print("0");
            }
        } catch (IOException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }
    }


    @RequestMapping("favSc")
    public void favSc(Fav fav, HttpServletRequest request, HttpServletResponse response) {
        try {
            PrintWriter out = response.getWriter();
            HashMap map = new HashMap();
            map.put("memberid", fav.getMemberid());
            map.put("tzid", fav.getTzid());
            List<Fav> list = favDAO.selectAll(map);
            if (list.size() > 0) {
                favDAO.delete(list.get(0).getId());
                out.print("1");
            }
        } catch (IOException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }
    }

    @RequestMapping("favDel")
    public String favDel(int id, HttpServletRequest request) {
        favDAO.delete(id);
        return "redirect:favMsg";
    }


}
