package com.it.dao;
import java.util.*;
import com.it.entity.Bbstype;

public interface BbstypeDAO {
	List<Bbstype> selectAll(HashMap map);
	void add(Bbstype bbstype);
	Bbstype findById(int id);
	void update(Bbstype bbstype);
}
