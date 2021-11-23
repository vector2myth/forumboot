package com.it.dao;
import com.it.entity.Tzinfo;

import java.util.*;
public interface TzinfoDAO {
	List<Tzinfo> selectAll(HashMap map);
	void add(Tzinfo tzinfo);
	Tzinfo findById(int id);
	void update(Tzinfo tzinfo);
	void delete(int id);
}
