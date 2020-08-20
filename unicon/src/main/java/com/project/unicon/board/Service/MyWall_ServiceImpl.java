package com.project.unicon.board.Service;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.project.unicon.vo.MyWall_Reply_VO;
import com.project.unicon.vo.MyWall_VO;
import com.project.unicon.mappers.MyWall_Mapper;

@Service("MyWall_Service")
@Transactional(propagation = Propagation.REQUIRED)
public class MyWall_ServiceImpl implements MyWall_Service {

	@Autowired
	MyWall_Mapper wallMapper;

	// 담벼락 가져오기
	@Override
	public List<MyWall_VO> myWall(String id) throws Exception {
		return wallMapper.myWall(id);
	}
	
	// 담벼락 새 글 쓰기
	public void addWallArticle(Map<String,Object> map) throws Exception {
		wallMapper.addWallArticle(map);
	}
	// 담벼락에서 게시글 삭제
	@Override
	public void removeArticle(int boardNO) throws Exception {
		wallMapper.removeWallReplyBeforeArticle(boardNO);
		wallMapper.removeArticle(boardNO);
	}
	
	// 담벼락에서 게시글 수정하기
	@Override
	public void updateWallArticle(MyWall_VO vo) throws Exception {
		wallMapper.updateWallArticle(vo);
	}

	// 담벼락 댓글 리스트 불러오기
	@Override
	public List<MyWall_Reply_VO> myWallReplyList(int boardNO) throws Exception {
		return wallMapper.myWallReplyList(boardNO);
	}

	// 담벼락 댓글 삭제하기
	@Override
	public void removeWallReply(int rep_boardNO) throws Exception {
		wallMapper.removeWallReply(rep_boardNO);
	}
	
	// 담벼락 댓글 입력하기
	@Override
	public void insertWallReply(Map<String, Object> map) throws Exception {
		wallMapper.insertWallReply(map);
	}
	
	// 담벼락 댓글 수정하기
	@Override
	public void updateWallReply(MyWall_Reply_VO vo) throws Exception {
		wallMapper.updateWallReply(vo);
	}
}
