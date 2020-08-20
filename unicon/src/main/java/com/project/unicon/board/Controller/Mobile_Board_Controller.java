package com.project.unicon.board.Controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.http.ResponseEntity;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import common.paging.PagingDTO;

public interface Mobile_Board_Controller {
	//Mobile 게시판 리스트
	public String Mobile_Board_AllList(PagingDTO pagingDTO, Model model) throws Exception;
	
	//Mobile 게시판 새 글쓰기
	public ResponseEntity MobileAddArticle(MultipartHttpServletRequest multipartRequest, HttpServletResponse response)
				throws Exception;
	
	//Mobile 게시판 상세보기
	public String MobileViewArticle(@RequestParam("boardNO") int boardNO, Model model, HttpServletRequest request)
				throws Exception;
	
	//Mobile 게시판 글 수정
    public String MobileUpdateArticle(@RequestParam("boardNO")int boardNO, Model model) throws Exception;
	
    //Mobile 게시판 글 삭제
    public String MobileDeleteArticle(@RequestParam("boardNO") int boardNO) throws Exception;
    
    //댓글 추가
    public ResponseEntity MobileAddReply(@RequestParam("parentNO") int parentNO,HttpServletRequest request, HttpServletResponse response)
			throws Exception;
    
    //댓글 수정
    public String MobileUpdateReply(HttpServletRequest request) throws Exception;
    
    //댓글 삭제
    public String MobileDeleteReply(@RequestParam("rep_boardNO") int rep_boardNO,
    		@RequestParam("rep_parentNO") int rep_parentNO) throws Exception;
    
}
