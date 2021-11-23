package com.it.dao;
import com.it.entity.News;

import java.util.*;
public interface NewsDAO {
	List<News> selectAll(HashMap map);
	void add(News news);
	void delete(int id);
	News findById(int id);
	void update(News news);
}
