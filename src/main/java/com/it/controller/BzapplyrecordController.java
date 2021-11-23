package com.it.controller;

import javax.annotation.Resource;


import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.*;

import com.github.pagehelper.PageInfo;
import com.it.dao.BanzhuDAO;
import com.it.dao.BbstypeDAO;
import com.it.dao.BzapplyrecordDAO;
import com.it.dao.MemberDAO;
import com.it.entity.Banzhu;
import com.it.entity.Bbstype;
import com.it.entity.Bzapplyrecord;
import com.it.entity.Member;
import com.it.util.Info;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.github.pagehelper.Page;
import com.github.pagehelper.PageHelper;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.util.*;

@Controller
public class BzapplyrecordController extends BaseController {
    @Resource
    BzapplyrecordDAO bzapplyrecordDAO;
    @Resource
    BbstypeDAO bbstypeDAO;
    @Resource
    MemberDAO memberDAO;
    @Resource
    BanzhuDAO banzhuDAO;
    @Resource
    SaveObject saveObject;
    //前台申请版主列表
    @RequestMapping("bzApply")
    public String bzApply(@RequestParam(defaultValue = "1", value = "pageNum") Integer pageNum,HttpServletRequest request) {
        Member member = (Member) request.getSession().getAttribute("member");
        HashMap map = new HashMap();
        map.put("memberid", member.getId());
        PageHelper.startPage(pageNum, 10);
        List<Bzapplyrecord> list = bzapplyrecordDAO.selectAll(map);
        for (Bzapplyrecord bzapplyrecord : list) {
            Bbstype bbstype = bbstypeDAO.findById(bzapplyrecord.getFid());
            bzapplyrecord.setFtype(bbstype);
        }
        PageInfo<Bzapplyrecord> pageInfo = new PageInfo<Bzapplyrecord>(list);
        request.setAttribute("pageInfo", pageInfo);
        return "bzapply";
    }

    //得到版块类别到申请版主添加页面
    @RequestMapping("bzapplyShowbbstype")
    public String bzapplyShowbbstype(HttpServletRequest request) {
        Member member = (Member) request.getSession().getAttribute("member");
        if (member != null) {
            saveObject.getCategory(request);
            request.setAttribute("member", member);
            return "bzapplyadd";
        } else {
            return "login";
        }
    }

    //添加版主申请
    @RequestMapping("applyAdd")
    public void applyAdd(HttpServletRequest request, HttpServletResponse response) {
        try {
            System.out.println("11111");
            String msgstr = "";
            String fid = request.getParameter("fid");
            String memberid = request.getParameter("memberid");
            String note = request.getParameter("note");
            Bzapplyrecord bzapplyrecord = new Bzapplyrecord();
            bzapplyrecord.setFid(Integer.parseInt(fid));
            bzapplyrecord.setMemberid(Integer.parseInt(memberid));
            bzapplyrecord.setNote(note);

            HashMap map = new HashMap();
            map.put("memberid",memberid);
            map.put("fid",fid);
            map.put("shstatus","待审核");
            List<Bzapplyrecord> issqlist = bzapplyrecordDAO.selectAll(map);
            map.put("shstatus","通过审核");
            List<Bzapplyrecord> isbzlist = bzapplyrecordDAO.selectAll(map);
            if (issqlist.size() == 1) {
                msgstr = "1";//有一条申请记录
            }
            if (isbzlist.size() == 1) {
                msgstr = "2";//已是版主
            }
            if (issqlist.size() == 0 && isbzlist.size() == 0) {
                bzapplyrecord.setSavetime(Info.getDateStr());
                bzapplyrecord.setShstatus("待审核");
                bzapplyrecordDAO.add(bzapplyrecord);
            }
            PrintWriter out = response.getWriter();
            out.print(msgstr);
        } catch (IOException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }

    }

    //后台版主申请列表
    @RequestMapping("admin/barList")
    public String barList(@RequestParam(defaultValue = "1", value = "pageNum") Integer pageNum, HttpServletRequest request) {
        String key = request.getParameter("key");
        HashMap map = new HashMap();
        map.put("key", key);
        PageHelper.startPage(pageNum, 10);
        List<Bzapplyrecord> list = bzapplyrecordDAO.selectAll(map);
        for (Bzapplyrecord bzapplyrecord : list) {
            Bbstype bbstype = bbstypeDAO.findById(bzapplyrecord.getFid());
            Member member = memberDAO.findById(bzapplyrecord.getMemberid());
            bzapplyrecord.setFtype(bbstype);
            bzapplyrecord.setMember(member);
        }
        PageInfo<Bzapplyrecord> pageInfo = new PageInfo<Bzapplyrecord>(list);
        request.setAttribute("pageInfo", pageInfo);
        return "barlist";
    }

    //申请版主审核
    @RequestMapping("admin/barShstatus")
    public String barShstatus(HttpServletRequest request, RedirectAttributes redirectAttributes) {
        String id = request.getParameter("id");
        String type = request.getParameter("type");
        String fid = request.getParameter("fid");
        Bzapplyrecord  bzapplyrecord = bzapplyrecordDAO.findById(Integer.parseInt(id));
        String msg = "";
        HashMap map = new HashMap();
        map.put("fid",fid);
        List<Banzhu> banzhulist = banzhuDAO.selectAll(map);
        if (type.equals("tg") && banzhulist.size() == 0) {
            Member member = (Member) request.getSession().getAttribute("member");
            Banzhu banzhu = new Banzhu();
            banzhu.setFid(fid);
            banzhu.setMemberid(String.valueOf(member.getId()));
            banzhuDAO.add(banzhu);
            bzapplyrecord.setShstatus("通过审核");
            bzapplyrecordDAO.update(bzapplyrecord);
        } else if (type.equals("tg") && banzhulist.size() != 0) {
            redirectAttributes.addFlashAttribute("message","已有版主");
        } else {
            bzapplyrecord.setShstatus("已拒绝");
            bzapplyrecordDAO.update(bzapplyrecord);
        }
        return "redirect:barList";
    }

    //删除记录
    @RequestMapping("admin/bzapplyrecordDel")
    public String bzapplyrecordDel(int id, HttpServletRequest request) {
        bzapplyrecordDAO.delete(id);
        return "redirect:barList";
    }

    //前台删除记录
    @RequestMapping("bzapplyDel")
    public String bzapplyDel(int id, HttpServletRequest request) {
        bzapplyrecordDAO.delete(id);
        return "redirect:bzApply";
    }


}
