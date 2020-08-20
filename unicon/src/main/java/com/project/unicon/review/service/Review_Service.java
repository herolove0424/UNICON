package com.project.unicon.review.service;

import java.util.List;

import org.springframework.dao.DataAccessException;

import com.project.unicon.vo.Review_VO;

public interface Review_Service {
	public List<Review_VO> reviewlist(String game_code) throws DataAccessException;
	public Integer insertReview(Review_VO review_VO) throws DataAccessException;
	public int goodsUpCount(Review_VO review_VO) throws DataAccessException;
	public int insertReviewDetail(Review_VO review_VO) throws DataAccessException;
	public Integer goodsIdCheck(String id, int review_code) throws DataAccessException;
	public int reviewDelete(Review_VO review_VO) throws DataAccessException;
}