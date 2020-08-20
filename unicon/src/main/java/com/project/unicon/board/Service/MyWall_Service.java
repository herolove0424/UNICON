package com.project.unicon.board.Service;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;

import com.project.unicon.vo.MyWall_Reply_VO;
import com.project.unicon.vo.MyWall_VO;

public interface MyWall_Service {

	// 담벼락 가져오기
	public List<MyWall_VO> myWall(String id) throws Exception;
	
	// 담벼락 새 글 쓰기
	public void addWallArticle(Map<String,Object> map) throws Exception;

	// 담벼락에서 게시글 지우기
	public void removeArticle(@Param("boardNO") int boardNO) throws Exception;
	
	// 담벼락에서 게시글 수정하기
	public void updateWallArticle(MyWall_VO vo) throws Exception;

	// 담벼락 리스트 불러오기
	public List<MyWall_Reply_VO> myWallReplyList(int boardNO) throws Exception;

	// 담벼락 댓글 삭제하기
	public void removeWallReply(int rep_boardNO) throws Exception;

	// 담벼락 댓글 입력하기
	public void insertWallReply(Map<String, Object> map) throws Exception;
	
	// 담벼락 댓글 수정하기
	public void updateWallReply(MyWall_Reply_VO vo) throws Exception;

}
