package com.it.controller;

import javax.annotation.Resource;


import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.*;

import com.github.pagehelper.PageInfo;
import com.it.dao.BbstypeDAO;
import com.it.dao.MgwordDAO;
import com.it.dao.TzhtinfoDAO;
import com.it.dao.TzinfoDAO;
import com.it.entity.*;
import com.it.util.Info;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import com.github.pagehelper.Page;
import com.github.pagehelper.PageHelper;
import org.springframework.web.bind.annotation.RequestParam;

import java.util.*;

@Controller
public class TzhtinfoController extends BaseController {
    @Resource
    TzhtinfoDAO tzhtinfoDAO;
    @Resource
    TzinfoDAO tzinfoDAO;
    @Resource
    BbstypeDAO bbstypeDAO;
    @Resource
    MgwordDAO mgwordDAO;


    //前台帖子回贴信息
    @RequestMapping("tzhtinfoAdd")
    public String tzhtinfoAdd(Tzhtinfo tzhtinfo, HttpServletRequest request) {
        Member member = (Member) request.getSession().getAttribute("member");
        List<Mgword> mgwordlist = mgwordDAO.selectAll(null);
        if (member != null) {
            for (Mgword mgword : mgwordlist) {
                int strsize = mgword.getWordnote().length();
                String xinstr = "";
                for (int i = 0; i < strsize; i++) {
                    xinstr += "*";
                }
                //tzhtinfo.getNote().indexOf(mgword.getWordnote())
                if (tzhtinfo.getNote().indexOf(mgword.getWordnote()) != -1) {
                    String c = tzhtinfo.getNote().replace(mgword.getWordnote(), xinstr);
                    tzhtinfo.setNote(c);
                }
            }
            tzhtinfo.setAuthor(member.getId());
            tzhtinfo.setSavetime(Info.getDateStr());
            tzhtinfo.setDznum(0);
            tzhtinfo.setCanht("");
            tzhtinfoDAO.add(tzhtinfo);
            return "redirect:tzDetail?id=" + tzhtinfo.getTzid();
        } else {
            return "login";
        }
    }

    //回贴点赞
    @RequestMapping("tzhtDz")
    public void tzhtDz(int id, HttpServletRequest request, HttpServletResponse response) {

        try {
            Tzhtinfo tzhtinfo = tzhtinfoDAO.findById(id);
            int cz = tzhtinfo.getDznum() + 1;
            tzhtinfo.setDznum(cz);
            tzhtinfo.setId(id);
            tzhtinfoDAO.updateDz(tzhtinfo);
            PrintWriter out = response.getWriter();
            out.print(cz);
        } catch (IOException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }

    }

    //删除回贴
    @RequestMapping("delHt")
    public void delHt(int id, HttpServletRequest request, HttpServletResponse response) {

        try {
            tzhtinfoDAO.delete(id);
            PrintWriter out = response.getWriter();
            out.print(id);
        } catch (IOException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }

    }

    //我回复的贴子
    @RequestMapping("myHf")
    public String myHf(@RequestParam(defaultValue = "1", value = "pageNum") Integer pageNum, HttpServletRequest request) {
        Member m = (Member) request.getSession().getAttribute("member");
        if (m != null) {
            HashMap map = new HashMap();
            map.put("author", m.getId());
            List<Tzinfo> publishlist = tzinfoDAO.selectAll(map);
            request.setAttribute("publishlist",publishlist);

            List<Tzhtinfo> nlist = tzhtinfoDAO.selectMyHf(map);
            PageHelper.startPage(pageNum, 10);
            List<Tzhtinfo> list = tzhtinfoDAO.selectMyHf(map);
            for (Tzhtinfo tzhtinfo : list) {
                Tzinfo tzinfo = tzinfoDAO.findById(tzhtinfo.getTzid());
                tzhtinfo.setTzinfo(tzinfo);
                Bbstype ftype = bbstypeDAO.findById(Integer.parseInt(tzinfo.getFid()));
                Bbstype stype = bbstypeDAO.findById(Integer.parseInt(tzinfo.getSid()));
                tzhtinfo.setFtype(ftype);
            }
            PageInfo<Tzhtinfo> pageInfo = new PageInfo<Tzhtinfo>(list);
            request.setAttribute("pageInfo", pageInfo);
            request.setAttribute("nlist", nlist);
            return "myhf";
        } else {
            return "login";
        }
    }


}
