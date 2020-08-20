package com.project.unicon.board.Controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.http.ResponseEntity;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartHttpServletRequest;

public interface Console_Board_Controller {
	//Console 게시판 리스트
	//public String Console_Board_AllList(PagingDTO pagingDTO, Model model, HttpServletRequest request) throws Exception;
	
	//Console 게시판 새 글쓰기
	public ResponseEntity ConsoleAddArticle(MultipartHttpServletRequest multipartRequest, HttpServletResponse response)
				throws Exception;
	
	//Console 게시판 상세보기
	public String ConsoleViewArticle(@RequestParam("boardNO") int boardNO, Model model, HttpServletRequest request)
				throws Exception;
	
	//Console 게시판 글 수정
    public String ConsoleUpdateArticle(@RequestParam("boardNO")int boardNO, Model model) throws Exception;
	
    //Console 게시판 글 삭제
    public String ConsoleDeleteArticle(@RequestParam("boardNO") int boardNO) throws Exception;
    
    //댓글 추가
    public ResponseEntity ConsoleAddReply(@RequestParam("parentNO") int parentNO,HttpServletRequest request, HttpServletResponse response)
			throws Exception;
    
    //댓글 수정
    public String ConsoleUpdateReply(HttpServletRequest request) throws Exception;
    
    //댓글 삭제
    public String ConsoleDeleteReply(@RequestParam("rep_boardNO") int rep_boardNO,
    		@RequestParam("rep_parentNO") int rep_parentNO) throws Exception;
    
}
