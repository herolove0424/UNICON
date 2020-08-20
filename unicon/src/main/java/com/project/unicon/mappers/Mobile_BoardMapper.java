package com.project.unicon.mappers;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.project.unicon.vo.Admin_Notice_VO;
import com.project.unicon.vo.Mobile_Board_Reply_VO;
import com.project.unicon.vo.Mobile_Board_VO;

import common.paging.PagingDTO;

@Mapper
public interface Mobile_BoardMapper {
	// 페이징 쓴거
	public List<Mobile_Board_VO> MobileSelectAllSearchedBoardsWithPaging(PagingDTO pagingDTO) throws Exception;

	// 페이징 총 행 갯수 가져오는거
	public int MobileSelectSearchedTotalRowsCnt(PagingDTO pagingDTO) throws Exception;

	// 새 글 추가하기
	public int MobileInsertNewArticle(Map articleMap) throws Exception;

	// 새 글 추가한 글번호 가져오기
	public int MobileCurrVal() throws Exception;

	// 상세 보기
	public Mobile_Board_VO MobileViewArticle(int boardNO) throws Exception;

	// 조회수 증가
	public boolean MobileViewCount(int BoardNO) throws Exception;

	// 글 수정
	public boolean MobileUpdateArticle(Mobile_Board_VO vo) throws Exception;

	// 글 삭제
	public boolean MobileDeleteArticle(int boardNO) throws Exception;

	// 글 삭제할때 댓글 먼저 삭제하는 구문
	public boolean MobileReplyDeleteForDeleteArticle(int boardNO) throws Exception;

	// 댓글(페이징쓴거)
	public List<Mobile_Board_Reply_VO> selectMobileReplySearchedBoardsWithPaging(int boardNO) throws Exception;

	// 댓글 추가하기
	public void MobileInsertReply(Map articleMap) throws Exception;

	// 댓글 수정하기
	public void MobileUpdateReply(Mobile_Board_Reply_VO vo) throws Exception;

	// 댓글 삭제하기 
	public boolean MobileDeleteReply(int rep_boardNO) throws Exception;

	// 공지사항 출력
	public List<Admin_Notice_VO> exposalNotice() throws Exception;

}
