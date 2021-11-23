package com.it.dao;
import com.it.entity.Tzhtinfo;
import java.util.*;
public interface TzhtinfoDAO {
	void add(Tzhtinfo tzhtinfo);
	Tzhtinfo findById(int id);
	void updateDz(Tzhtinfo tzhtinfo);
	void delete(int id);
	List<Tzhtinfo> selectAll(HashMap map);
    List<Tzhtinfo> selectMyHf(HashMap map);

}
