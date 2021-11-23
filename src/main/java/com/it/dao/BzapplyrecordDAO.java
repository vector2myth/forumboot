package com.it.dao;
import com.it.entity.Bzapplyrecord;

import java.util.*;
public interface BzapplyrecordDAO {
	void add(Bzapplyrecord bzapplyrecord);
	List<Bzapplyrecord> selectAll(HashMap map);
	void update(Bzapplyrecord bzapplyrecord);
	void delete(int id);
    Bzapplyrecord findById(int id);
}
