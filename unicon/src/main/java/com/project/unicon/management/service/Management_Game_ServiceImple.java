package com.project.unicon.management.service;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.project.unicon.mappers.Info_Image_Mapper;
import com.project.unicon.mappers.Info_Mapper;
import com.project.unicon.mappers.Review_Mapper;
import com.project.unicon.vo.Info_Image_VO;
import com.project.unicon.vo.Info_VO;
import com.project.unicon.vo.Review_VO;

import common.paging.PagingDTO;

@Service("management_game_Service")
@Transactional(propagation = Propagation.REQUIRED)
public class Management_Game_ServiceImple implements Management_Game_Service{
	
	@Autowired
	private Info_Mapper info_Mapper;
	
	@Autowired
	private Info_Image_Mapper info_Image_Mapper;
	
	@Autowired
	private Review_Mapper review_Mapper;
	

	@Override
	public List<Info_VO> management_Search_All_Games(PagingDTO pageDTO) throws Exception {
		List<Info_VO> gameList = null;
		gameList = info_Mapper.selectSearchedGameWithPaging(pageDTO);
		return gameList;
	}

	@Override
	public int management_Searched_Total_Rows(PagingDTO pageDTO) throws Exception {
		int pages = info_Mapper.selectSearchedTotalRows(pageDTO);
		return pages;
	}
	
	
	@Override
	public String add_Game_Info(Info_VO info_VO) throws Exception{
		String game_Info_Code=info_Mapper.gameInfoCode();
		info_VO.setGame_code(game_Info_Code);
		
		info_Mapper.insertGameInfo(info_VO);
		
		return game_Info_Code;
		
	}
	
	@Override
	public void add_Game_Info_Logo_Image(Info_Image_VO info_Image_VO) throws Exception{
		int imagefileno = info_Mapper.gameInfoImageNum();
		info_Image_VO.setImagefileno(imagefileno);
		info_Mapper.insertGameInfoLogoImage(info_Image_VO);
	}
	
	@Override
	public void add_Game_Info_Image(Info_Image_VO info_Image_VO) throws Exception{
		int imagefileno = info_Mapper.gameInfoImageNum();
		info_Image_VO.setImagefileno(imagefileno);
		info_Mapper.insertGameInfoImage(info_Image_VO);
	}
	
	@Override
	public Info_VO detail_Game_Info(String game_code) throws Exception{
		return info_Mapper.detail_Game_Info(game_code);
	}
	
	@Override
	public Info_Image_VO detail_Game_Image_Logo_Info(String game_code) throws Exception{
		return info_Image_Mapper.detail_Game_Image_Logo_Info(game_code);
	}
	
	@Override
	public List<Info_Image_VO> detail_Game_Image_Info(String game_code) throws Exception{
		return info_Image_Mapper.detail_Game_Image_Info(game_code);
	}
	
	@Override
	public void mod_Game_Info(Info_VO mod_Info) throws Exception{
		info_Mapper.mod_Game_Info(mod_Info);
	}
	
	@Override
	public void update_Game_Image(Info_Image_VO info_Image_VO) throws Exception{
		info_Image_Mapper.update_Game_Image(info_Image_VO);
	}
	
	@Override
	public void delete_Game_Info(String game_code) throws Exception{
		//info테이블에서 삭제
		info_Mapper.delete_Game_Info(game_code);
		
		
	}
	
	@Override
	public void delete_Game_Image_Info(String game_code) throws Exception{
		//image 테이블에서 삭제 
		info_Image_Mapper.delete_Game_Image_Info(game_code);
	}

	/*0805 김도경 추가*/
	@Override
	public List<Review_VO> manageReviewWithPaging(PagingDTO pagingDTO) throws Exception{
		return review_Mapper.manageReviewWithPaging(pagingDTO);
	}
	
	@Override
	public int manageReviewWithPagingCount() throws Exception{
		return review_Mapper.manageReviewWithPagingCount();
	}
	
	@Override
	public List<Review_VO> todayReview() throws Exception{
		return review_Mapper.todayReview();
	}
	
	@Override
	public List<Review_VO> searchDayReview(String startDay,String endDay,PagingDTO pagingDTO) throws Exception{
		return review_Mapper.searchDayReview(startDay, endDay, pagingDTO.getCurrentPageNo(),pagingDTO.getRecordsPerPage());
	}
	
	@Override
	public int searchDayReviewCount(String startDay,String endDay) throws Exception{
		return review_Mapper.searchDayReviewCount(startDay, endDay);
	}
	
	@Override
	public void deleteReview(int review_code) throws Exception{
		review_Mapper.deleteReview(review_code);
	}
	
	@Override
	public int overlapGame(String game_name, String small_category) throws Exception{
		int serviceResult= info_Mapper.overlapGame(game_name, small_category);
		System.out.println("serviceResult"+serviceResult);
		return serviceResult;
	}

}
