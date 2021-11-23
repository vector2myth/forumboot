package com.it.dao;
import com.it.entity.Yqlink;

import java.util.*;
public interface YqlinkDAO {
	List<Yqlink> selectAll(HashMap map);
	void add(Yqlink yqlink);
	Yqlink findById(int id);
	void update(Yqlink yqlink);
	void delete(int id);
}
