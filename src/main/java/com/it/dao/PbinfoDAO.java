package com.it.dao;
import com.it.entity.Pbinfo;

import java.util.*;
public interface PbinfoDAO {
	void add(Pbinfo pbinfo);
	List<Pbinfo> selectOne(HashMap<String, String> map);
	void delete(Pbinfo pbinfo);
	List<Pbinfo> selectPbmember(int memberid);
	void deletePingbi(int id);
    List<Pbinfo> selectAll(HashMap map);
}
