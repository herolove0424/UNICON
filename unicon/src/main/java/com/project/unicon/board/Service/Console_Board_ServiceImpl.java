package com.project.unicon.board.Service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.project.unicon.mappers.Console_BoardMapper;
import com.project.unicon.vo.Admin_Notice_VO;
import com.project.unicon.vo.Console_Board_Reply_VO;
import com.project.unicon.vo.Console_Board_VO;

import common.paging.PagingDTO;

@Service("Console_Board_Service")
@Transactional(propagation = Propagation.REQUIRED)
public class Console_Board_ServiceImpl implements Console_Board_Service {

	@Autowired
	private Console_BoardMapper boardMapper;

	// Console 게시판 리스트
	@Override
	public List<Console_Board_VO> Console_Board_List(PagingDTO pagingDTO) throws Exception {
		List<Console_Board_VO> list;
		if (pagingDTO.getPlatform() == null || pagingDTO.getPlatform() == "") {
			list = boardMapper.ConsoleSelectAllSearchedBoardsWithPagingAll(pagingDTO);
		} else {
			list = boardMapper.ConsoleSelectAllSearchedBoardsWithPagingPlatform(pagingDTO);
		}
		return list;
	}

	// Console 게시판 총 행 갯수
	@Override
	public int ConsoleGetTotalRecordCnt(PagingDTO pagingDTO) throws Exception {
		int Cnt;
		if (pagingDTO.getPlatform() == null || pagingDTO.getPlatform() == "") {

			Cnt = boardMapper.ConsoleSelectSearchedTotalRowsCntAll(pagingDTO);
			System.out.println("플랫폼없어:" + Cnt);
		} else {
			Cnt = boardMapper.ConsoleSelectSearchedTotalRowsCntPlatform(pagingDTO);
			System.out.println("플랫폼있어:" + Cnt);
		}
		return Cnt;
	}

	// 새 글쓰기
	@Override
	public int ConsoleAddBoard(Map articleMap) throws Exception {
		boardMapper.ConsoleInsertNewArticle(articleMap);

		return boardMapper.ConsoleCurrVal();
	}

	// 상세보기
	@Override
	public Console_Board_VO ConsoleViewArticle(int boardNO) throws Exception {
		Console_Board_VO boardVO = boardMapper.ConsoleViewArticle(boardNO);
		return boardVO;
	}

	// 조회수 증가
	@Override
	public boolean ConsoleViewCount(int boardNO) throws Exception {
		return boardMapper.ConsoleViewCount(boardNO);
	}

	// 글 수정
	@Override
	public boolean ConsoleUpdateArticle(Console_Board_VO vo) throws Exception {
		return boardMapper.ConsoleUpdateArticle(vo);
	}

	// 글 삭제
	@Override
	public boolean ConsoleDeleteArticle(int boardNO) throws Exception {
		boardMapper.ConsoleReplyDeleteForDeleteArticle(boardNO);
		return boardMapper.ConsoleDeleteArticle(boardNO);
	}

	// 댓글 리스트
	@Override
	public List<Console_Board_Reply_VO> Console_Board_Reply_List(int boardNO) throws Exception {
		return boardMapper.selectConsoleReplySearchedBoardsWithPaging(boardNO);
	}

	// 댓글 추가하기
	public void ConsoleInsertReply(Map articleMap) throws Exception {
		boardMapper.ConsoleInsertReply(articleMap);
	}

	// 댓글 수정
	@Override
	public void ConsoleUpdateReply(Console_Board_Reply_VO vo) throws Exception {
		boardMapper.ConsoleUpdateReply(vo);
	}

	// 댓글 삭제
	@Override
	public void ConsoleDeleteReply(int rep_boardNO) throws Exception {
		boardMapper.ConsoleDeleteReply(rep_boardNO);
	}

	@Override
	public List<Admin_Notice_VO> exposalNotice() throws Exception {
		return boardMapper.exposalNotice();
	}

}
