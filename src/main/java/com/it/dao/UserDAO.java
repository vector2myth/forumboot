package com.it.dao;
import com.it.entity.User;

import java.util.*;
public interface UserDAO {
   User findById(int id);
   void update(User user);
   void updatepwd(int id, String userpassword);
   List<User> selectOne(User user);
   List<User> selectTeacherAll();
   List<User> checkUsername(String username);
   void add(User user);
   void deleteTeahcer(int id);
   void updateTeacher(User user);
   List<User> searchTeacher(String key);
   List<User> selectStudentAll();
   List<User> searchStudent(String key);
   List<User> chengyuanList(int bj);
   List<User> searchChengyuan(int bj, String key);
   void updateStudent(User user);
}
