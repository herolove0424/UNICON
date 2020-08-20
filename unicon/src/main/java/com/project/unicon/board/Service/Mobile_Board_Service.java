package com.project.unicon.board.Service;

import java.util.List;
import java.util.Map;

import com.project.unicon.vo.Admin_Notice_VO;
import com.project.unicon.vo.Mobile_Board_Reply_VO;
import com.project.unicon.vo.Mobile_Board_VO;

import common.paging.PagingDTO;

public interface Mobile_Board_Service {

	// Free 게시판 리스트
	public List<Mobile_Board_VO> Mobile_Board_List(PagingDTO pagingDTO) throws Exception;

	// 총 행 갯수 가져오는 거
	public int MobileGetTotalRecordCnt(PagingDTO pagingDTO) throws Exception;

	// 새 글 쓰기
	public int MobileAddBoard(Map articleMap) throws Exception;

	// 상세보기
	public Mobile_Board_VO MobileViewArticle(int boardNO) throws Exception;

	// 조회수 증가
	public boolean MobileViewCount(int boardNO) throws Exception;

	// 글 수정
	public boolean MobileUpdateArticle(Mobile_Board_VO vo) throws Exception;

	// 글 삭제
	public boolean MobileDeleteArticle(int boardNO) throws Exception;

	// 댓글 리스트
	public List<Mobile_Board_Reply_VO> Mobile_Board_Reply_List(int boardNO) throws Exception;

	// 댓글 추가하기
	public void MobileInsertReply(Map articleMap) throws Exception;
	
	//댓글 수정
	public void MobileUpdateReply(Mobile_Board_Reply_VO vo) throws Exception;
	
	//댓글 삭제
	public void MobileDeleteReply(int rep_boardNO) throws Exception;
	
	public List<Admin_Notice_VO> exposalNotice() throws Exception;
	
}
