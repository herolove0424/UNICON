package com.project.unicon.timeLine.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataAccessException;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.project.unicon.mappers.TimeLine_Mapper;
import com.project.unicon.vo.Member_VO;
import com.project.unicon.vo.TimeLine_VO;

@Service("timeLine_Service")
@Transactional(propagation = Propagation.REQUIRED)
public class TimeLine_ServiceImpl implements TimeLine_Service {
	
	@Autowired
	private TimeLine_Mapper timeLine_Mapper;
	
	@Override
	public List<TimeLine_VO> friendList(String id) throws DataAccessException {
		
		List<TimeLine_VO> friendList = timeLine_Mapper.friendList(id);
		
		System.out.println("친구 : " + friendList);
		
		return friendList; 
	}
	
	@Override
	public List<TimeLine_VO> friendRequestList(String id) throws DataAccessException {
		
		List<TimeLine_VO> friendRequestList = timeLine_Mapper.friendRequestList(id);
		
		return friendRequestList; 
	}
	
	@Override
	public List<TimeLine_VO> friendAcceptList(String id) throws DataAccessException {
		
		List<TimeLine_VO> friendAcceptList = timeLine_Mapper.friendAcceptList(id);
		
		return friendAcceptList; 
	}
	
	@Override
	public Integer friendCount(String id) throws DataAccessException {
		
		Integer friendcount = timeLine_Mapper.friendCount(id);
		
		System.out.println("친구 수 : " +friendcount);
		
		return friendcount; 
	}
	
	@Override
	public int friendDelete(TimeLine_VO timeLine_VO) throws DataAccessException {
		return timeLine_Mapper.friendDelete(timeLine_VO);
	}
	
	@Override
	public int friendRequestDelete(TimeLine_VO timeLine_VO) throws DataAccessException {
		return timeLine_Mapper.friendRequestDelete(timeLine_VO);
	}
	
	@Override
	public int friendAccept1(TimeLine_VO timeLine_VO) throws DataAccessException {
		return timeLine_Mapper.friendAccept1(timeLine_VO);
	}
	
	@Override
	public int friendAccept2(TimeLine_VO timeLine_VO) throws DataAccessException {
		return timeLine_Mapper.friendAccept2(timeLine_VO);
	}
	
	@Override
	public int friendReject(TimeLine_VO timeLine_VO) throws DataAccessException {
		return timeLine_Mapper.friendReject(timeLine_VO);
	}
	
	
	@Override
	//public Map<String, String> nicknameSearch(String nickname) throws DataAccessException {
	public List<Member_VO> nicknameSearch(String nickname) throws DataAccessException {
		return timeLine_Mapper.nicknameSearch(nickname);
		
	}
	
	
	@Override
	public int friendRequest(TimeLine_VO timeLine_VO) throws DataAccessException {
		return timeLine_Mapper.friendRequest(timeLine_VO);
	}
	
	@Override
	public TimeLine_VO alreadyFriend(String id_1,String id_2) throws Exception{
		return timeLine_Mapper.alreadyFriend(id_1, id_2);
	}
	
	public int alreadyFriendCount(String id_1,String id_2) throws Exception{
		return timeLine_Mapper.alreadyFriendCount(id_1, id_2);
	}
	
	@Override
	public int countFriendAccept(String id) throws Exception{
		return timeLine_Mapper.countFriendAccept(id);
	}
}