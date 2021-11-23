package com.it.dao;
import java.util.*;
import com.it.entity.Banzhu;

public interface BanzhuDAO {
	List<Banzhu> selectOne(int fid);
	void add(Banzhu banzhu);
	List<Banzhu> selectAll(HashMap map);
	void delete(Banzhu banzhu);
}
