package com.it.dao;
import com.it.entity.Chat;

import java.util.*;
public interface ChatDAO {
	List<Chat> selectAll(HashMap map);
	void add(Chat chat);
	void update(Chat chat);
	void delete(int id);
}
