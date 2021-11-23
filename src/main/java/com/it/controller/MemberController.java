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
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.util.*;

@Controller
public class MemberController extends BaseController {
    @Resource
    MemberDAO memberDAO;
    @Resource
    TzinfoDAO tzinfoDAO;
    @Resource
    BbstypeDAO bbstypeDAO;
    @Resource
    FansDAO fansDAO;
    @Resource
    PbinfoDAO pbinfoDAO;
    @Resource
    TzhtinfoDAO tzhtinfoDAO;
    @Resource
    SigninDAO signinDAO;


    //检查用户名的唯一性
    @RequestMapping("checkUname")
    public void checkUname(String uname, HttpServletRequest request, HttpServletResponse response) {
        try {
            PrintWriter out = response.getWriter();
            HashMap map = new HashMap();
            map.put("uname", uname);
            List<Member> list = memberDAO.selectAll(map);
            if (list.size() == 0) {
                out.print(0);
            } else {
                out.print(1);
            }
        } catch (IOException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }
    }

    //注册
    @RequestMapping("memberReg")
    public String memberReg(Member member, HttpServletRequest request) {
        member.setDelstatus("0");
        member.setIsjy("no");
        member.setShstatus("待审核");
        member.setSavetime(Info.getDateStr());
        member.setIsfh("no");
        memberDAO.add(member);
        return "login";
    }

    //登录
    @RequestMapping("memberLogin")
    public void memberLogin(Member member, HttpServletRequest request, HttpServletResponse response) {

        try {
            PrintWriter out = response.getWriter();
            HashMap map = new HashMap();
            map.put("uname", member.getUname());
            map.put("upass", member.getUpass());
            map.put("shstatus", "通过审核");
            List<Member> list = memberDAO.selectAll(map);
            if (list.size() == 0) {
                out.print(0);
            } else if (list.size() == 1) {
                Member mmm = list.get(0);
                if (mmm.getIsfh().equals("no")) {
                    request.getSession().setAttribute("member", list.get(0));
                    out.print(1);
                } else {
                    out.print(2);
                }
            }
        } catch (IOException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }

    }

    //退出
    @RequestMapping("memberExit")
    public void memberExit(HttpServletRequest request, HttpServletResponse response) {
        try {
            PrintWriter out = response.getWriter();
            request.getSession().removeAttribute("member");
            out.print(0);
        } catch (IOException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }
    }

    //个人信息设置
    @RequestMapping("memberSet")
    public String memberSet(HttpServletRequest request) {
        Member m = (Member) request.getSession().getAttribute("member");
        Member member = memberDAO.findById(m.getId());
        request.setAttribute("member", member);
        return "memberset";
    }

    //个人信息设置
    @RequestMapping("memberXg")
    public String memberXg(Member member, HttpServletRequest request, RedirectAttributes redirectAttributes) {
        memberDAO.update(member);
        ;
        redirectAttributes.addFlashAttribute("message", "编辑成功");
        return "redirect:memberSet";
    }


    //修改个人信息
    @RequestMapping("memberEdit")
    public String memberEdit(Member member, HttpServletRequest request) {
        String newupass = request.getParameter("upass1");
        Member m = (Member) memberDAO.findById(member.getId());
        if (m.getUpass().equals(member.getUpass())) {
            Member mmm = memberDAO.findById(member.getId());
            mmm.setUpass(newupass);
            memberDAO.update(mmm);
            request.setAttribute("msg", "编辑成功");
        } else {
            request.setAttribute("msg", "原密码错误");
        }
        return "memberset";
    }

    //我的主页
    @RequestMapping("Home")
    public String Home(@RequestParam(defaultValue = "1", value = "pageNum") Integer pageNum,int memberid, HttpServletRequest request) {
        Member mmm = (Member) request.getSession().getAttribute("member");
        Member member = memberDAO.findById(memberid);
        //查看关注人数
        int gzmemberid = memberid;
        List<Fans> fanslist = fansDAO.selectFans(gzmemberid);
        //查看是否关注
        String isgz = "";
        if (mmm != null) {
            HashMap<String, String> map = new HashMap<String, String>();
            map.put("gzmemberid", String.valueOf(gzmemberid));
            map.put("memberid", String.valueOf(mmm.getId()));
            List<Fans> isgzlist = fansDAO.selectOne(map);
            if (isgzlist.size() > 0) {
                isgz = "1";
            } else {
                isgz = "0";
            }
        }

        //是否签到
        HashMap sgmap = new HashMap();
        sgmap.put("memberid", memberid);
        sgmap.put("savetime", Info.getDateStr().substring(0, 10));
        List<Signin> sglist = signinDAO.isSignin(sgmap);

        //是否屏蔽
        String ispb = "";
        int pbmemberid = memberid;
        if (mmm != null) {
            HashMap<String, String> map = new HashMap<String, String>();
            map.put("pbmemberid", String.valueOf(pbmemberid));
            map.put("memberid", String.valueOf(mmm.getId()));
            List<Pbinfo> ispblist = pbinfoDAO.selectOne(map);
            if (ispblist.size() > 0) {
                ispb = "1";
            } else {
                ispb = "0";
            }
        }


        HashMap map = new HashMap();
        HashMap ppp = new HashMap();
        map.put("author", memberid);
        PageHelper.startPage(pageNum, 10);
        List<Tzinfo> list = tzinfoDAO.selectAll(map);
		for(Tzinfo tzinfo:list){
            ppp.put("tzid",tzinfo.getId());
			List<Tzhtinfo> htlist = tzhtinfoDAO.selectAll(ppp);
			tzinfo.setAllhtlist(htlist);
		}
        PageInfo<Tzinfo> pageInfo = new PageInfo<Tzinfo>(list);
        request.setAttribute("pageInfo", pageInfo);
        request.setAttribute("sglist", sglist);
        request.setAttribute("ispb", ispb);
        request.setAttribute("isgz", isgz);
        request.setAttribute("fanslist", fanslist);
        request.setAttribute("member", member);
        return "home";
    }

    //用户中心
    @RequestMapping("memberCenter")
    public String memberCenter(@RequestParam(defaultValue = "1", value = "pageNum") Integer pageNum, HttpServletRequest request) {
        Member member = (Member) request.getSession().getAttribute("member");
        if (member != null) {
            HashMap nnn = new HashMap();
            nnn.put("memberid",member.getId());
            List<Tzhtinfo> myhflist = tzhtinfoDAO.selectMyHf(nnn);


            HashMap map = new HashMap();
            map.put("author", member.getId());
            PageHelper.startPage(pageNum, 10);
            List<Tzinfo> list = tzinfoDAO.selectAll(map);
            for (Tzinfo tzinfo : list) {
                Bbstype ftype = bbstypeDAO.findById(Integer.parseInt(tzinfo.getFid()));
                Bbstype stype = bbstypeDAO.findById(Integer.parseInt(tzinfo.getSid()));
                tzinfo.setFtype(ftype);
                tzinfo.setStype(stype);
                HashMap fff = new HashMap();
                fff.put("tzid",tzinfo.getId());
                List<Tzhtinfo> htlist = tzhtinfoDAO.selectAll(map);
                tzinfo.setAllhtlist(htlist);
            }
            PageInfo<Tzinfo> pageInfo = new PageInfo<Tzinfo>(list);
            request.setAttribute("pageInfo", pageInfo);
            request.setAttribute("myhflist", myhflist);
            return "membercenter";
        } else {
            return "login";
        }
    }


    //后台查看会员列表
    @RequestMapping("admin/memberList")
    public String memberList(@RequestParam(defaultValue = "1", value = "pageNum") Integer pageNum, HttpServletRequest request) {
        String key = request.getParameter("key");
        HashMap map = new HashMap();
        map.put("key", key);
        PageHelper.startPage(pageNum, 10);
        List<Member> list = memberDAO.selectAll(map);
        PageInfo<Member> pageInfo = new PageInfo<Member>(list);
        request.setAttribute("pageInfo", pageInfo);
        request.setAttribute("list", list);
        request.setAttribute("key", key);
        return "memberlist";
    }

    //会员审核
    @RequestMapping("admin/shStatus")
    public String shStatus(HttpServletRequest request) {
        String type = request.getParameter("type");
        String id = request.getParameter("id");
        Member member = memberDAO.findById(Integer.parseInt(id));
        if (type.equals("tg")) {
            member.setShstatus("通过审核");
        } else if (type.equals("jj")) {
            member.setShstatus("已拒绝");
        }
        memberDAO.update(member);
        return "redirect:memberList";
    }

    //删除会员
    @RequestMapping("admin/memberDel")
    public String memberDel(int id, HttpServletRequest request) {
        Member member = memberDAO.findById(id);
        member.setDelstatus("1");
        memberDAO.update(member);
        return "redirect:memberList";
    }

    //会员禁言
    @RequestMapping("admin/jinYan")
    public String jinYan(int id, HttpServletRequest request) {
        Member member = memberDAO.findById(id);
        if (member.getIsjy().equals("no")) {
            member.setIsjy("yes");
        } else {
            member.setIsjy("no");
        }
        memberDAO.update(member);
        return "redirect:memberList";
    }


    //查找版块到升级版主页面
    @RequestMapping("admin/szbz")
    public String szbz(int id, HttpServletRequest request) {
        //List<Bbstype> list = bbstypeDAO.selectAll();
        //request.setAttribute("list", list);
        request.setAttribute("id", id);
        return "admin/szbz";
    }

    //封号
    @RequestMapping("admin/fengHao")
    public String fengHao(int id, HttpServletRequest request, HttpServletResponse response) {
        Member member = memberDAO.findById(id);
        if (member.getIsfh().equals("no")) {
            member.setIsfh("yes");
        } else {
            member.setIsfh("no");
        }
        memberDAO.update(member);
        return "redirect:memberList";
    }


}
