package com.project.unicon.mappers;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.springframework.dao.DataAccessException;

import com.project.unicon.vo.Member_VO;
import com.project.unicon.vo.TimeLine_VO;

@Mapper
public interface TimeLine_Mapper {
	List<TimeLine_VO> friendList(@Param("id") String id) throws DataAccessException;
	List<TimeLine_VO> friendRequestList(@Param("id") String id) throws DataAccessException;
	List<TimeLine_VO> friendAcceptList(@Param("id") String id) throws DataAccessException;
	Integer friendCount(@Param("id") String id) throws DataAccessException;
	int friendDelete(TimeLine_VO timeLine_VO) throws DataAccessException;
	int friendRequestDelete(TimeLine_VO timeLine_VO) throws DataAccessException;
	int friendAccept1(TimeLine_VO timeLine_VO) throws DataAccessException;
	int friendAccept2(TimeLine_VO timeLine_VO) throws DataAccessException;
	int friendReject(TimeLine_VO timeLine_VO) throws DataAccessException;
	List<Member_VO> nicknameSearch(@Param("nickname") String nickname ) throws DataAccessException;
	//Map<String, String> nicknameSearch(@Param("nickname") String nickname ) throws DataAccessException;
	int friendRequest(TimeLine_VO timeLine_VO) throws DataAccessException;
	TimeLine_VO alreadyFriend(@Param("id_1") String id_1,@Param("id_2") String id_2) throws Exception;
	int alreadyFriendCount(@Param("id_1") String id_1,@Param("id_2") String id_2) throws Exception;
	int countFriendAccept(@Param("id") String id) throws DataAccessException;	
}
