package com.project.unicon.mappers;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.springframework.dao.DataAccessException;

import com.project.unicon.vo.Review_VO;

import common.paging.PagingDTO;

public interface Review_Mapper {
	//	댓글 전체 출력
	public List<Review_VO> reviewlist(String game_code) throws DataAccessException;
	
	//	댓글 입력 기능
	public Integer insertReview(Review_VO review_VO) throws DataAccessException;
	
	//	추천수 1 증가
	public int goodsUpCount(Review_VO review_VO) throws DataAccessException;
	
	//	goods_detail 테이블에 id 및 review_code 입력
	public int insertReviewDetail(Review_VO review_VO) throws DataAccessException;
	
	//	댓글 추천 ID 중복검사 기능
	//	goods_detail 테이블에 id, review_code가 둘다 입력되어 있는 상태면 1, 아니라면 0을 리턴받음 
	public Integer goodsIdCheck(@Param("id") String id, @Param("review_code") int review_code) throws DataAccessException;
	
	//	댓글 삭제 기능
	public int reviewDelete(Review_VO review_VO) throws DataAccessException;
	
	/*0805 김도경 추가*/
	// 리뷰 페이징
	public List<Review_VO> manageReviewWithPaging(PagingDTO pagingDTO) throws Exception;
	
	// 리뷰 페이징 카운트
	public int manageReviewWithPagingCount() throws Exception;
	
	//오늘 등록된 리뷰
	public List<Review_VO> todayReview() throws Exception;
	
	//리뷰 날짜 페이징 검색
	public List<Review_VO> searchDayReview(@Param("startDay") String startDay,@Param("endDay") String endDay,@Param("currentPageNo") int currentPageNo,@Param("recordsPerPage") int recordsPerPage) throws Exception;
	
	//리뷰 날짜 카운트 검색
	public int searchDayReviewCount(@Param("startDay") String startDay,@Param("endDay") String endDay) throws Exception;
	
	//리뷰삭제
	public void deleteReview(int review_code) throws Exception;
	
	// 관리자 메인을 위한 추가 0810
	public int todayReviewCount() throws Exception;
	public int lastDayReviewCount() throws Exception;
}