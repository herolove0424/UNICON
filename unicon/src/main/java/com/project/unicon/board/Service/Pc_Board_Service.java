package com.project.unicon.board.Service;

import java.util.List;
import java.util.Map;

import org.springframework.web.bind.annotation.RequestParam;

import com.project.unicon.vo.Admin_Notice_VO;
import com.project.unicon.vo.Pc_Board_Reply_VO;
import com.project.unicon.vo.Pc_Board_VO;

import common.paging.PagingDTO;

public interface Pc_Board_Service {

	//PC 게시판 리스트
	public List<Pc_Board_VO> Pc_Board_List(PagingDTO pagingDTO) throws Exception;
	
	//총 행 갯수 가져오는 거
	public int getTotalRecordCnt(PagingDTO pagingDTO) throws Exception;
	
	//PC 게시판 리스트(페이징 안씀)
	public List<Pc_Board_VO> AllPCList() throws Exception; 
	
	//새 글 쓰기
	public int addBoard(Map articleMap) throws Exception;
	
	//상세보기
	public Pc_Board_VO viewArticle(int boardNO) throws Exception;
	
	//조회수 증가
	public boolean viewCount(int boardNO) throws Exception;
	
	//글 수정
	public boolean modArticle(Pc_Board_VO vo) throws Exception;
	
	//글 삭제
	public boolean deleteArticle(int boardNO) throws Exception;
	
	//글 삭제할때 댓글 먼저 삭제하는구문.
	/* public void replyDeleteForDeleteArticle(int boardNO) throws Exception; */
	
	//댓글 리스트
	public List<Pc_Board_Reply_VO> Pc_Board_Reply_List(int boardNO) throws Exception;
	
	//댓글 추가하기
	public void insertReply(Map articleMap) throws Exception;
	
	//댓글 수정
	public void updateReply(Pc_Board_Reply_VO vo) throws Exception;
	
	//댓글 삭제
	public void deleteReply(int rep_boardNO) throws Exception;
	
	public List<Admin_Notice_VO> exposalNotice() throws Exception;
	
	public Admin_Notice_VO detailNotice(int boardno) throws Exception;
	
	public void noticeViewCount(int boardno) throws Exception;
}
