package com.project.unicon.mappers;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.project.unicon.vo.Admin_Notice_VO;
import com.project.unicon.vo.Pc_Board_Reply_VO;
import com.project.unicon.vo.Pc_Board_VO;

import common.paging.PagingDTO;

@Mapper
public interface Pc_BoardMapper{
	//페이징 쓴거
	public List<Pc_Board_VO> selectAllSearchedBoardsWithPaging(PagingDTO pagingDTO) throws Exception;
	//페이징 총 행 갯수 가져오는거
	public int selectSearchedTotalRowsCnt(PagingDTO pagingDTO) throws Exception;
	//페이징 안쓴거
	public List<Pc_Board_VO> selectAllPCList() throws Exception;
	//새 글 추가하기
	public int insertNewArticle(Map articleMap) throws Exception;
	//새 글 추가한 글번호 가져오기
	public int currVal() throws Exception;
	//상세 보기
	public Pc_Board_VO viewArticle(int boardNO) throws Exception;
	//조회수 증가
	public boolean viewCount(int BoardNO) throws Exception;
	//글 수정
	public boolean updateArticle(Pc_Board_VO vo) throws Exception;
	//글 삭제
	public boolean deleteArticle(int boardNO) throws Exception;
	//글 삭제할때 댓글 먼저 삭제하는 구문
	public boolean replyDeleteForDeleteArticle(int boardNO) throws Exception;
	//댓글(페이징쓴거)
	public List<Pc_Board_Reply_VO> selectReplySearchedBoardsWithPaging(int boardNO) throws Exception;
	//댓글 추가하기
	public void insertReply(Map articleMap) throws Exception;
	//댓글 수정하기
	public void updateReply(Pc_Board_Reply_VO vo) throws Exception;
	//댓글 삭제하기
	public boolean deleteReply(int rep_boardNO) throws Exception;
	
	//공지사항 출력
	public List<Admin_Notice_VO> exposalNotice() throws Exception;
	
}
