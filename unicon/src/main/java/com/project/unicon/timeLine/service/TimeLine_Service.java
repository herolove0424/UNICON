package com.project.unicon.timeLine.service;

import java.util.List;

import org.springframework.dao.DataAccessException;

import com.project.unicon.vo.Member_VO;
import com.project.unicon.vo.TimeLine_VO;

public interface TimeLine_Service {
	public List<TimeLine_VO> friendList(String id) throws DataAccessException;
	
	public List<TimeLine_VO> friendRequestList(String id) throws DataAccessException;
	
	public List<TimeLine_VO> friendAcceptList(String id) throws DataAccessException;
	
	public Integer friendCount(String id) throws DataAccessException;
	
	public int friendDelete(TimeLine_VO timeLine_VO) throws DataAccessException;
	
	public List<Member_VO> nicknameSearch(String nickname) throws DataAccessException;
	//public Map<String, String> nicknameSearch(String nickname) throws DataAccessException;
	
	public int friendRequestDelete(TimeLine_VO timeLine_VO) throws DataAccessException;
	
	public int friendAccept1(TimeLine_VO timeLine_VO) throws DataAccessException;
	
	public int friendAccept2(TimeLine_VO timeLine_VO) throws DataAccessException;
	
	public int friendReject(TimeLine_VO timeLine_VO) throws DataAccessException;
	
	public int friendRequest(TimeLine_VO timeLine_VO) throws DataAccessException;
	public TimeLine_VO alreadyFriend(String id_1,String id_2) throws Exception;
	public int countFriendAccept(String id) throws Exception;
}