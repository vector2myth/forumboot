package com.it.controller;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.it.dao.*;
import com.it.entity.History;
import com.it.entity.Tzinfo;
import com.it.util.Info;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import java.util.HashMap;
import java.util.List;

@Controller
public class HistoryController extends BaseController {
	@Resource
    HistoryDAO historyDAO;
	@Resource
    MemberDAO memberDAO;
	@Resource
    BbstypeDAO bbstypeDAO;
	@Resource
    YqlinkDAO yqlinkDAO;
	@Resource
    TzinfoDAO tzinfoDAO;
    @Resource
    SaveObject saveObject;
	//后台新闻列表
	@RequestMapping("historyList")
	public String historyList(@RequestParam(defaultValue = "1", value = "pageNum") Integer pageNum, HttpServletRequest request) {
        String key = request.getParameter("key");
        HashMap map = new HashMap();
        map.put("key", key);
        PageHelper.startPage(pageNum, 10);
		List<History> list = historyDAO.selectAll(map);
		for(History history: list){
            Tzinfo tzinfo = tzinfoDAO.findById(Integer.parseInt(history.getTzid()));
            history.setTzinfo(tzinfo);
        }
        PageInfo<History> pageInfo = new PageInfo<History>(list);
        request.setAttribute("pageInfo", pageInfo);
        request.setAttribute("key", key);
		return "historylist";
	}


    //删除新闻
	@RequestMapping("historyDel")
	public String historyDel(int id, HttpServletRequest request) {
		historyDAO.delete(id);
		return "redirect:historyList";
	}
	

	

}
