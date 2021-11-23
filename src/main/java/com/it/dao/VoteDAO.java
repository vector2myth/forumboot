package com.it.dao;

import com.it.entity.Vote;

import java.util.HashMap;
import java.util.List;

public interface VoteDAO {
	List<Vote> selectAll(HashMap map);
	void add(Vote vote);
	void delete(int id);
}
