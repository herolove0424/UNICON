package com.project.unicon.board.Service;

import java.util.List;
import java.util.Map;

import com.project.unicon.vo.All_Board_Reply_VO;
import com.project.unicon.vo.All_Board_VO;

public interface All_Board_Service {

	// 타임라인 표시하기
	public List<All_Board_VO> timeLine(String id) throws Exception;

	// 타임라인 댓글 불러오기
	public List<All_Board_Reply_VO> callReply(int boardNO, int status) throws Exception;

	// 타임라인 댓글 삭제하기
	public void removeReply(int rep_boardNO, int status) throws Exception;

	// 타임라인 댓글 입력하기
	public void timeLineInsertReply(Map<String, Object> map, int status) throws Exception;
	
	// 타임라인에서 댓글 수정하기
	public void timeLineUpdateReply(All_Board_Reply_VO vo,int status) throws Exception;
	
	public List<All_Board_VO> pc_board() throws Exception;
	
	public List<All_Board_VO> mobile_board() throws Exception;
	
	public List<All_Board_VO> console_board() throws Exception;
	
	public List<All_Board_VO> free_board() throws Exception;
}
