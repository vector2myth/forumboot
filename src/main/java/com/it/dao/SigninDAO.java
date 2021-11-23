package com.it.dao;
import com.it.entity.Signin;

import java.util.*;
public interface SigninDAO {
	List<Signin> isSignin(HashMap map);
	void add(Signin signin);
}
