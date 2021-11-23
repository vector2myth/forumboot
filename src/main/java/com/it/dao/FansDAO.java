package com.it.dao;
import com.it.entity.Fans;

import java.util.*;
public interface FansDAO {
	List<Fans> selectOne(HashMap<String, String> map);
	List<Fans> selectFans(int gzmemberid);
	List<Fans> selectMyFans(int memberid);
	void add(Fans fans);
	void delete(Fans fans);
	void deleteFs(int id);
    List<Fans> selectAll(HashMap map);
}
