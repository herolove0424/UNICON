package com.project.unicon.board.Controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.http.ResponseEntity;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.google.gson.JsonObject;

import common.paging.PagingDTO;

public interface Pc_Board_Controller {

	//PC 게시판 리스트 (페이징완성안됨)
	public String Pc_Board_AllList(PagingDTO pagingDTO, Model model) throws Exception;
	
	//PC 게시판 새 글쓰기
	public ResponseEntity addArticle(MultipartHttpServletRequest multipartRequest, HttpServletResponse response)
			throws Exception;
	
	//PC 게시판 상세보기
	public String viewArticle(@RequestParam("boardNO") int boardNO, Model model, HttpServletRequest request)
			throws Exception;
	
    //PC 게시판 글 수정
    public String modArticle(@RequestParam("boardNO")int boardNO, Model model) throws Exception;
    
    //PC 게시판 글 삭제
    public String deleteArticle(@RequestParam("boardNO") int boardNO) throws Exception;

    //댓글 추가
    public ResponseEntity addReply(@RequestParam("parentNO") int parentNO,HttpServletRequest request, HttpServletResponse response)
			throws Exception;
    
    //댓글 삭제
    public String deleteReply(@RequestParam("rep_boardNO") int rep_boardNO,
    						@RequestParam("rep_parentNO") int rep_parentNO) throws Exception;
    
    //댓글 수정
    public String updateReply(HttpServletRequest request) throws Exception;
    
    public String noticeView(@RequestParam("boardno") int boardno,@RequestParam("status") int status,Model model) throws Exception;
    public JsonObject uploadSummernoteImageFile(@RequestParam("file") MultipartFile multipartFile);
}
