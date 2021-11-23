package com.it.dao;
import com.it.entity.Member;

import java.util.*;
public interface MemberDAO {
	void add(Member member);
	Member findById(int id);
	List<Member> selectAll(HashMap map);
	void update(Member member);
}
