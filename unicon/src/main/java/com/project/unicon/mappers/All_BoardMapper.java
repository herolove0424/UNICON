package com.project.unicon.mappers;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.project.unicon.vo.All_Board_Reply_VO;
import com.project.unicon.vo.All_Board_VO;

@Mapper
public interface All_BoardMapper{
	
	// 타임라인 가져오기
	public List<All_Board_VO> timeLine(String id) throws Exception;
		
	// 타임라인에서 댓글 리스트 가져오기
	public List<All_Board_Reply_VO> callReply(@Param("boardNO") int boardNO,@Param("status") int status) throws Exception;
	
	// 타임라인에서 댓글 삭제하기
	public boolean removeReply(@Param("rep_boardNO") int rep_boardNO,@Param("status") int status) throws Exception;
	
	// 타임라인에서 댓글 입력하기
	public void timeLineInsertReplyFree(Map<String, Object> map) throws Exception;
	public void timeLineInsertReplyMobile(Map<String, Object> map) throws Exception;
	public void timeLineInsertReplyPc(Map<String, Object> map) throws Exception;
	public void timeLineInsertReplyConsole(Map<String, Object> map) throws Exception;
	
	// 타임라인에서 댓글 수정하기
	public void timeLineUpdateReplyFree(All_Board_Reply_VO vo) throws Exception;
	public void timeLineUpdateReplyMobile(All_Board_Reply_VO vo) throws Exception;
	public void timeLineUpdateReplyPc(All_Board_Reply_VO vo) throws Exception;
	public void timeLineUpdateReplyConsole(All_Board_Reply_VO vo) throws Exception;
	
	public List<All_Board_VO> pc_board() throws Exception;
	public List<All_Board_VO> mobile_board() throws Exception;
	public List<All_Board_VO> console_board() throws Exception;
	public List<All_Board_VO> free_board() throws Exception;
	
}
