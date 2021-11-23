package com.it.dao;

import com.it.entity.Hthf;

import java.util.HashMap;
import java.util.List;

public interface HthfDAO {
	List<Hthf> selectAll(HashMap map);
	void add(Hthf hthf);
	void delete(int id);
}
