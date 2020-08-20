package com.project.unicon.mappers;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.project.unicon.vo.Admin_Notice_VO;
import com.project.unicon.vo.Free_Board_Reply_VO;
import com.project.unicon.vo.Free_Board_VO;

import common.paging.PagingDTO;

@Mapper
public interface Free_BoardMapper {
	// 페이징 쓴거
	public List<Free_Board_VO> FreeSelectAllSearchedBoardsWithPaging(PagingDTO pagingDTO) throws Exception;

	// 페이징 총 행 갯수 가져오는거
	public int FreeSelectSearchedTotalRowsCnt(PagingDTO pagingDTO) throws Exception;

	//새 글 추가하기
	public int FreeInsertNewArticle(Map articleMap) throws Exception;
	
	//새 글 추가한 글번호 가져오기
	public int FreeCurrVal() throws Exception;
	
	//상세 보기
	public Free_Board_VO FreeViewArticle(int boardNO) throws Exception;
	
	//조회수 증가
	public boolean FreeViewCount(int BoardNO) throws Exception;
	
	//글 수정
	public boolean FreeUpdateArticle(Free_Board_VO vo) throws Exception;
	
	//글 삭제
	public boolean FreeDeleteArticle(int boardNO) throws Exception;
	
	//글 삭제할때 댓글 먼저 삭제하는 구문
	public boolean FreeReplyDeleteForDeleteArticle(int boardNO) throws Exception;
	
	//댓글(페이징쓴거)
	public List<Free_Board_Reply_VO> selectFreeReplySearchedBoardsWithPaging(int boardNO) throws Exception;
	
	//댓글 추가하기
	public void FreeInsertReply(Map articleMap) throws Exception;
	
	//댓글 수정하기
	public void FreeUpdateReply(Free_Board_Reply_VO vo) throws Exception;
	
	//댓글 삭제하기
	public boolean FreeDeleteReply(int rep_boardNO) throws Exception;
	
	// 공지사항 출력
	public List<Admin_Notice_VO> exposalNotice() throws Exception;
	
}
