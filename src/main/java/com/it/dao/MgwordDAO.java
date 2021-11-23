package com.it.dao;
import com.it.entity.Mgword;

import java.util.*;
public interface MgwordDAO {
	List<Mgword> selectAll(HashMap map);
	void add(Mgword mgword);
	Mgword findById(int id);
	void update(Mgword mgword);
	void delete(int id);
}
