package com.project.unicon.management.service;

import java.util.List;
import java.util.Map;

import com.project.unicon.vo.Member_VO;

public interface Management_Authority_Service {
	
	public int manager_Id_Check(String id) throws Exception;
	public int manager_Phone_Check(String id) throws Exception;
	
	public void add_Authority(Member_VO member) throws Exception;
	public int confirm_Password(Map<String, String> values) throws Exception;
	
	public List<Member_VO> selectAuthorList() throws Exception;
	public void deleteAuthor(String id) throws Exception;
	
	public void updateAuthorPw(String id, String pw) throws Exception;
	public void modifyAuthor(String id, int grade) throws Exception;
}
