package com.project.unicon.board.Service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.project.unicon.mappers.Mobile_BoardMapper;
import com.project.unicon.vo.Admin_Notice_VO;
import com.project.unicon.vo.Mobile_Board_Reply_VO;
import com.project.unicon.vo.Mobile_Board_VO;

import common.paging.PagingDTO;

@Service("Mobile_Board_Service")
@Transactional(propagation = Propagation.REQUIRED)
public class Mobile_Board_ServiceImpl implements Mobile_Board_Service {

	@Autowired
	private Mobile_BoardMapper boardMapper;

	// Free 게시판 리스트
	@Override
	public List<Mobile_Board_VO> Mobile_Board_List(PagingDTO pagingDTO) throws Exception {

		return boardMapper.MobileSelectAllSearchedBoardsWithPaging(pagingDTO);
	}

	// PC 게시판 총 행 갯수
	@Override
	public int MobileGetTotalRecordCnt(PagingDTO pagingDTO) throws Exception {

		return boardMapper.MobileSelectSearchedTotalRowsCnt(pagingDTO);
	}

	// 새 글쓰기
	@Override
	public int MobileAddBoard(Map articleMap) throws Exception {
		boardMapper.MobileInsertNewArticle(articleMap);

		return boardMapper.MobileCurrVal();
	}

	// 상세보기
	@Override
	public Mobile_Board_VO MobileViewArticle(int boardNO) throws Exception {
		Mobile_Board_VO boardVO = boardMapper.MobileViewArticle(boardNO);
		return boardVO;
	}

	// 조회수 증가
	@Override
	public boolean MobileViewCount(int boardNO) throws Exception {
		return boardMapper.MobileViewCount(boardNO);
	}

	// 글 수정
	@Override
	public boolean MobileUpdateArticle(Mobile_Board_VO vo) throws Exception {
		return boardMapper.MobileUpdateArticle(vo);
	}

	// 글 삭제
	@Override
	public boolean MobileDeleteArticle(int boardNO) throws Exception {
		boardMapper.MobileReplyDeleteForDeleteArticle(boardNO);
		return boardMapper.MobileDeleteArticle(boardNO);
	}

	// 댓글 리스트
	@Override
	public List<Mobile_Board_Reply_VO> Mobile_Board_Reply_List(int boardNO) throws Exception {
		return boardMapper.selectMobileReplySearchedBoardsWithPaging(boardNO);
	}

	// 댓글 추가하기
	public void MobileInsertReply(Map articleMap) throws Exception {
		boardMapper.MobileInsertReply(articleMap);
	}

	// 댓글 수정
	@Override
	public void MobileUpdateReply(Mobile_Board_Reply_VO vo) throws Exception {
		boardMapper.MobileUpdateReply(vo);
	}

	// 댓글 삭제
	@Override
	public void MobileDeleteReply(int rep_boardNO) throws Exception {
		boardMapper.MobileDeleteReply(rep_boardNO);
	}
	
	@Override
	public List<Admin_Notice_VO> exposalNotice() throws Exception{
		return boardMapper.exposalNotice();
	}

}
