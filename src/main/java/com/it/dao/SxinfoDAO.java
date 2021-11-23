package com.it.dao;
import com.it.entity.Sxinfo;

import java.util.*;
public interface SxinfoDAO {
	void add(Sxinfo sxinfo);
	void updateSxHf(HashMap<String, String> map);
	void delete(int id);
    List<Sxinfo> selectAll(HashMap map);
}

