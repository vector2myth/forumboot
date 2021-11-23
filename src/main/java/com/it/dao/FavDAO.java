package com.it.dao;
import com.it.entity.Fav;

import java.util.*;

public interface FavDAO {
	List<Fav> selectAll(HashMap map);
	void add(Fav fav);
	void delete(int id);
}
