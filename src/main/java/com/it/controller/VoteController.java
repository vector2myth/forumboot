package com.it.controller;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.it.dao.*;
import com.it.entity.Member;
import com.it.entity.Tzinfo;
import com.it.entity.Vote;
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
public class VoteController extends BaseController {
	@Resource
    VoteDAO voteDAO;
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


	//新增点赞
    @ResponseBody
	@RequestMapping("voteAdd")
	public HashMap<String,Object> voteAdd(Vote vote, HttpServletRequest request) {
        HashMap<String,Object> res = new HashMap<String,Object>();
        Member member = (Member)request.getSession().getAttribute("member");
        Tzinfo tzinfo = tzinfoDAO.findById(Integer.parseInt(vote.getTzid()));

        if(member==null){
            res.put("data",500 );
        }else{

            HashMap map = new HashMap();
            map.put("memberid", member.getId());
            map.put("tzid",vote.getTzid() );
            List<Vote> list = voteDAO.selectAll(map);

            if(member.getId()==tzinfo.getAuthor()){
                res.put("data",300 );//不能为自己点赞
            }else{
                if(list.size()==0){
                    vote.setMemberid(String.valueOf(member.getId()));
                    voteDAO.add(vote);

                    tzinfo.setDznum(tzinfo.getDznum()+1);
                    tzinfoDAO.update(tzinfo);
                    res.put("data",200 );
                    res.put("dznum",tzinfo.getDznum());
                }else{
                    res.put("data",400 );
                }
            }
        }

		return res;
	}

	

}
