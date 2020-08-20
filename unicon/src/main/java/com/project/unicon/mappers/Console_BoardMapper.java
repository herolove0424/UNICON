package com.project.unicon.mappers;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.project.unicon.vo.Admin_Notice_VO;
import com.project.unicon.vo.Console_Board_Reply_VO;
import com.project.unicon.vo.Console_Board_VO;

import common.paging.PagingDTO;

@Mapper
public interface Console_BoardMapper {
	// 페이징 쓴거(플랫폼 전체)
	public List<Console_Board_VO> ConsoleSelectAllSearchedBoardsWithPagingAll(PagingDTO pagingDTO) throws Exception;

	// 페이징 쓴거(플랫폼 별로)
	public List<Console_Board_VO> ConsoleSelectAllSearchedBoardsWithPagingPlatform(PagingDTO pagingDTO)
			throws Exception;

	// 페이징 총 행 갯수 가져오는거(플랫폼 전체)
	public int ConsoleSelectSearchedTotalRowsCntAll(PagingDTO pagingDTO) throws Exception;

	// 페이징 총 행 갯수 가져오는거(플랫폼 별로)
	public int ConsoleSelectSearchedTotalRowsCntPlatform(PagingDTO pagingDTO) throws Exception;

	// 새 글 추가하기
	public int ConsoleInsertNewArticle(Map articleMap) throws Exception;

	// 새 글 추가한 글번호 가져오기
	public int ConsoleCurrVal() throws Exception;

	// 상세 보기
	public Console_Board_VO ConsoleViewArticle(int boardNO) throws Exception;

	// 조회수 증가
	public boolean ConsoleViewCount(int BoardNO) throws Exception;

	// 글 수정
	public boolean ConsoleUpdateArticle(Console_Board_VO vo) throws Exception;

	// 글 삭제
	public boolean ConsoleDeleteArticle(int boardNO) throws Exception;

	// 글 삭제할때 댓글 먼저 삭제하는 구문
	public boolean ConsoleReplyDeleteForDeleteArticle(int boardNO) throws Exception;

	// 댓글(페이징쓴거)
	public List<Console_Board_Reply_VO> selectConsoleReplySearchedBoardsWithPaging(int boardNO) throws Exception;

	// 댓글 추가하기
	public void ConsoleInsertReply(Map articleMap) throws Exception;

	// 댓글 수정하기
	public void ConsoleUpdateReply(Console_Board_Reply_VO vo) throws Exception;

	// 댓글 삭제하기
	public boolean ConsoleDeleteReply(int rep_boardNO) throws Exception;

	// 공지사항 출력
	public List<Admin_Notice_VO> exposalNotice() throws Exception;

}
