package com.project.unicon.board.Controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.http.ResponseEntity;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import common.paging.PagingDTO;

public interface Free_Board_Controller {
	//Free 게시판 리스트
	public String Free_Board_AllList(PagingDTO pagingDTO, Model model) throws Exception;
	
	//Free 게시판 새 글쓰기
	public ResponseEntity FreeAddArticle(MultipartHttpServletRequest multipartRequest, HttpServletResponse response)
				throws Exception;
	
	//FREE 게시판 상세보기
	public String FreeViewArticle(@RequestParam("boardNO") int boardNO, Model model, HttpServletRequest request)
				throws Exception;
	
	//FREE 게시판 글 수정
    public String FreeUpdateArticle(@RequestParam("boardNO")int boardNO, Model model) throws Exception;
	
    //FREE 게시판 글 삭제
    public String FreeDeleteArticle(@RequestParam("boardNO") int boardNO) throws Exception;
    
    //댓글 추가
    public ResponseEntity FreeAddReply(@RequestParam("parentNO") int parentNO,HttpServletRequest request, HttpServletResponse response)
			throws Exception;
    
    //댓글 수정
    public String FreeUpdateReply(HttpServletRequest request) throws Exception;
    
    //댓글 삭제
    public String FreeDeleteReply(@RequestParam("rep_boardNO") int rep_boardNO,
    		@RequestParam("rep_parentNO") int rep_parentNO) throws Exception;
    
}
