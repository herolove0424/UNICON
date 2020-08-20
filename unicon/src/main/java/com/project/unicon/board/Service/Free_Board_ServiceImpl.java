package com.project.unicon.board.Service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.project.unicon.mappers.Free_BoardMapper;
import com.project.unicon.vo.Admin_Notice_VO;
import com.project.unicon.vo.Free_Board_Reply_VO;
import com.project.unicon.vo.Free_Board_VO;

import common.paging.PagingDTO;

@Service("Free_Board_Service")
@Transactional(propagation = Propagation.REQUIRED)
public class Free_Board_ServiceImpl implements Free_Board_Service {

	@Autowired
	private Free_BoardMapper boardMapper;

	// Free 게시판 리스트
	@Override
	public List<Free_Board_VO> Free_Board_List(PagingDTO pagingDTO) throws Exception {

		return boardMapper.FreeSelectAllSearchedBoardsWithPaging(pagingDTO);
	}

	// PC 게시판 총 행 갯수
	@Override
	public int FreeGetTotalRecordCnt(PagingDTO pagingDTO) throws Exception {

		return boardMapper.FreeSelectSearchedTotalRowsCnt(pagingDTO);
	}

	// 새 글쓰기
	@Override
	public int FreeAddBoard(Map articleMap) throws Exception {
		boardMapper.FreeInsertNewArticle(articleMap);

		return boardMapper.FreeCurrVal();
	}

	// 상세보기
	@Override
	public Free_Board_VO FreeViewArticle(int boardNO) throws Exception {
		Free_Board_VO boardVO = boardMapper.FreeViewArticle(boardNO);
		return boardVO;
	}

	// 조회수 증가
	@Override
	public boolean FreeViewCount(int boardNO) throws Exception {
		return boardMapper.FreeViewCount(boardNO);
	}

	// 글 수정
	@Override
	public boolean FreeUpdateArticle(Free_Board_VO vo) throws Exception {
		return boardMapper.FreeUpdateArticle(vo);
	}

	// 글 삭제
	@Override
	public boolean FreeDeleteArticle(int boardNO) throws Exception {
		boardMapper.FreeReplyDeleteForDeleteArticle(boardNO);
		return boardMapper.FreeDeleteArticle(boardNO);
	}

	// 댓글 리스트
	@Override
	public List<Free_Board_Reply_VO> Free_Board_Reply_List(int boardNO) throws Exception {
		return boardMapper.selectFreeReplySearchedBoardsWithPaging(boardNO);
	}

	// 댓글 추가하기
	public void FreeInsertReply(Map articleMap) throws Exception {
		boardMapper.FreeInsertReply(articleMap);
	}

	// 댓글 수정
	@Override
	public void FreeUpdateReply(Free_Board_Reply_VO vo) throws Exception {
		boardMapper.FreeUpdateReply(vo);
	}

	// 댓글 삭제
	@Override
	public void FreeDeleteReply(int rep_boardNO) throws Exception {
		boardMapper.FreeDeleteReply(rep_boardNO);
	}
	
	@Override
	public List<Admin_Notice_VO> exposalNotice() throws Exception{
		return boardMapper.exposalNotice();
	}

}
