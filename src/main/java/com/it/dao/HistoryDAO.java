package com.it.dao;

import com.it.entity.History;

import java.util.HashMap;
import java.util.List;

public interface HistoryDAO {
	List<History> selectAll(HashMap map);
	void add(History history);
	void delete(int id);
    History findById(int id);
	void update(History history);
}
