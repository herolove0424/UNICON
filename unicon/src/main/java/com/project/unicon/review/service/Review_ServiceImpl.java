package com.project.unicon.review.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataAccessException;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.project.unicon.mappers.Review_Mapper;
import com.project.unicon.vo.Review_VO;

@Service("review_Service")
@Transactional(propagation = Propagation.REQUIRED)
public class Review_ServiceImpl implements Review_Service {
	
	@Autowired
	private Review_Mapper review_Mapper;
	
	@Override
	public List<Review_VO> reviewlist(String game_code) throws DataAccessException {
		return review_Mapper.reviewlist(game_code);
	}
	
	@Override
	public Integer insertReview(Review_VO review_VO) throws DataAccessException {
		System.out.println(review_VO.getGame_code());
		System.out.println(review_VO.getId());
		System.out.println(review_VO.getContent());
		System.out.println(review_VO.getScore());
		return review_Mapper.insertReview(review_VO);
	}
	
	@Override
	public int goodsUpCount(Review_VO review_VO) throws DataAccessException {
		return review_Mapper.goodsUpCount(review_VO);
	}
	
	@Override
	public int insertReviewDetail(Review_VO review_VO) throws DataAccessException {
		return review_Mapper.insertReviewDetail(review_VO);
	}
	
	@Override
	public Integer goodsIdCheck(String id, int review_code) throws DataAccessException {
		return review_Mapper.goodsIdCheck(id, review_code);
	}
	
	@Override
	public int reviewDelete(Review_VO review_VO) throws DataAccessException {
		return review_Mapper.reviewDelete(review_VO);
	}

}