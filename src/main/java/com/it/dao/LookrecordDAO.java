package com.it.dao;

import com.it.entity.Lookrecord;

import java.util.HashMap;
import java.util.List;

public interface LookrecordDAO {
	List<Lookrecord> selectAll(HashMap map);
    List<Lookrecord> selectdistinct(HashMap map);
	void add(Lookrecord lookrecord);
}
