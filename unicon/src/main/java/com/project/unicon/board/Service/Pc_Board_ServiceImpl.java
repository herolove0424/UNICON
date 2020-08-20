package com.project.unicon.board.Service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.project.unicon.vo.Admin_Notice_VO;
import com.project.unicon.vo.Pc_Board_Reply_VO;
import com.project.unicon.vo.Pc_Board_VO;
import com.project.unicon.mappers.Notice_Mapper;
import com.project.unicon.mappers.Pc_BoardMapper;

import common.paging.PagingDTO;

@Service("Pc_Board_Service")
@Transactional(propagation = Propagation.REQUIRED)
public class Pc_Board_ServiceImpl implements Pc_Board_Service {
	
	@Autowired
	private Pc_BoardMapper boardMapper;
	
	@Autowired
	private Notice_Mapper notice_Mapper;

	//PC 게시판 리스트
	@Override
	public List<Pc_Board_VO> Pc_Board_List(PagingDTO pagingDTO) throws Exception {

		return boardMapper.selectAllSearchedBoardsWithPaging(pagingDTO);
	}
	
	//PC 게시판 총 행 갯수
	@Override
	public int getTotalRecordCnt(PagingDTO pagingDTO) throws Exception {
		
		return boardMapper.selectSearchedTotalRowsCnt(pagingDTO);
	}
	
	//PC 게시판 리스트(페이징 안씀)
	@Override
	public List<Pc_Board_VO> AllPCList() throws Exception {
		List<Pc_Board_VO> boardList = null;
		boardList = boardMapper.selectAllPCList();
		return boardList;
	}
	
	//새 글쓰기
	@Override
	public int addBoard(Map articleMap) throws Exception {
		boardMapper.insertNewArticle(articleMap);
		
		return boardMapper.currVal();
	}
	
	
	//상세보기
	@Override
	public Pc_Board_VO viewArticle(int boardNO) throws Exception {
		Pc_Board_VO boardVO = boardMapper.viewArticle(boardNO); 
		return boardVO;
	}
	
	//조회수 증가
	@Override
	public boolean viewCount(int boardNO) throws Exception {
		return boardMapper.viewCount(boardNO);
	}
	
	//글 수정
	@Override
	public boolean modArticle(Pc_Board_VO vo) throws Exception {
		return boardMapper.updateArticle(vo);
	}
	
	//글 삭제
	@Override
	public boolean deleteArticle(int boardNO) throws Exception {
		boardMapper.replyDeleteForDeleteArticle(boardNO);
		return boardMapper.deleteArticle(boardNO);
	}
	
	//댓글 리스트
	@Override
	public List<Pc_Board_Reply_VO> Pc_Board_Reply_List(int boardNO) throws Exception {
		return boardMapper.selectReplySearchedBoardsWithPaging(boardNO);
	}
	
	
	//댓글 추가하기
	public void insertReply(Map articleMap) throws Exception {
		boardMapper.insertReply(articleMap);
	}
	
	//댓글 수정
	@Override
	public void updateReply(Pc_Board_Reply_VO vo) throws Exception {
		boardMapper.updateReply(vo);
	}
	
	//댓글 삭제
	@Override
	public void deleteReply(int rep_boardNO) throws Exception {
		boardMapper.deleteReply(rep_boardNO);
	}
	
	@Override
	public List<Admin_Notice_VO> exposalNotice() throws Exception{
		return boardMapper.exposalNotice();
	}
	
	@Override
	public Admin_Notice_VO detailNotice(int boardno) throws Exception{
		return notice_Mapper.detailNotice(boardno);
	}
	
	@Override
	public void noticeViewCount(int boardno) throws Exception{
		notice_Mapper.noticeViewCount(boardno);
	}
	
}
