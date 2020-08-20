package com.project.unicon.board.Service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.project.unicon.vo.All_Board_Reply_VO;
import com.project.unicon.vo.All_Board_VO;
import com.project.unicon.mappers.All_BoardMapper;

@Service("All_Board_Service")
@Transactional(propagation = Propagation.REQUIRED)
public class All_Board_ServiceImpl implements All_Board_Service {

	@Autowired
	private All_BoardMapper boardMapper;

	// 타임라인
	@Override
	public List<All_Board_VO> timeLine(String id) throws Exception {
		return boardMapper.timeLine(id);
	}

	// 타임라인에서 댓글 불러오기
	@Override
	public List<All_Board_Reply_VO> callReply(int boardNO, int status) throws Exception {
		return boardMapper.callReply(boardNO, status);
	}

	// 댓글 삭제
	@Override
	public void removeReply(int rep_boardNO, int status) throws Exception {
		boardMapper.removeReply(rep_boardNO, status);
	}

	// 댓글 추가하기
	public void timeLineInsertReply(Map<String, Object> map, int status) throws Exception {
		
		if(status == 1) {
			boardMapper.timeLineInsertReplyFree(map);
		} else if (status == 2) {
			boardMapper.timeLineInsertReplyMobile(map);
		} else if (status == 3) {
			boardMapper.timeLineInsertReplyPc(map);
		} else if (status == 4) {
			boardMapper.timeLineInsertReplyConsole(map);
		}
		
	}
	
	// 댓글 수정하기
	public void timeLineUpdateReply(All_Board_Reply_VO vo, int status) throws Exception {
		if(status == 1) {
			boardMapper.timeLineUpdateReplyFree(vo);
		} else if (status == 2) {
			boardMapper.timeLineUpdateReplyMobile(vo);
		} else if (status == 3) {
			boardMapper.timeLineUpdateReplyPc(vo);
		} else if (status == 4) {
			boardMapper.timeLineUpdateReplyConsole(vo);
		}
	}
	
	
	// 메인 페이지 인기 게시글 가져오기
	   @Override
	   public List<All_Board_VO> pc_board() throws Exception {
	      return boardMapper.pc_board();
	   }
	   
	   @Override
	   public List<All_Board_VO> mobile_board() throws Exception {
	      return boardMapper.mobile_board();
	   }
	   
	   @Override
	   public List<All_Board_VO> console_board() throws Exception {
	      return boardMapper.console_board();
	   }
	   
	   @Override
	   public List<All_Board_VO> free_board() throws Exception {
	      return boardMapper.free_board();
	   }
	
}
