package com.it.dao;
import com.it.entity.Jbrecord;

import java.util.*;
public interface JbrecordDAO {
	void add(Jbrecord jbrecord);
	List<Jbrecord> selectAll(HashMap map);
	void delete(int id);
}
