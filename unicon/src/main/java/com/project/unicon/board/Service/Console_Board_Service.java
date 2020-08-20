package com.project.unicon.board.Service;

import java.util.List;
import java.util.Map;

import com.project.unicon.vo.Admin_Notice_VO;
import com.project.unicon.vo.Console_Board_Reply_VO;
import com.project.unicon.vo.Console_Board_VO;

import common.paging.PagingDTO;

public interface Console_Board_Service {

	// Free 게시판 리스트
	public List<Console_Board_VO> Console_Board_List(PagingDTO pagingDTO) throws Exception;

	// 총 행 갯수 가져오는 거
	public int ConsoleGetTotalRecordCnt(PagingDTO pagingDTO) throws Exception;

	// 새 글 쓰기
	public int ConsoleAddBoard(Map articleMap) throws Exception;

	// 상세보기
	public Console_Board_VO ConsoleViewArticle(int boardNO) throws Exception;

	// 조회수 증가
	public boolean ConsoleViewCount(int boardNO) throws Exception;

	// 글 수정
	public boolean ConsoleUpdateArticle(Console_Board_VO vo) throws Exception;

	// 글 삭제
	public boolean ConsoleDeleteArticle(int boardNO) throws Exception;

	// 댓글 리스트
	public List<Console_Board_Reply_VO> Console_Board_Reply_List(int boardNO) throws Exception;

	// 댓글 추가하기
	public void ConsoleInsertReply(Map articleMap) throws Exception;
	
	//댓글 수정
	public void ConsoleUpdateReply(Console_Board_Reply_VO vo) throws Exception;
	
	//댓글 삭제
	public void ConsoleDeleteReply(int rep_boardNO) throws Exception;
	
	public List<Admin_Notice_VO> exposalNotice() throws Exception;
	
}
