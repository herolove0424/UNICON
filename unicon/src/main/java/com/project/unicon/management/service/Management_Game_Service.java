package com.project.unicon.management.service;

import java.util.List;

import com.project.unicon.vo.Info_Image_VO;
import com.project.unicon.vo.Info_VO;
import com.project.unicon.vo.Review_VO;

import common.paging.PagingDTO;



public interface Management_Game_Service {
	
	//public List<Info_VO> base_Game_Paging(PagingDTO pageDTO) throws Exception;
	//public int base_Game_Total_Rows(PagingDTO pageDTO) throws Exception;
	
	
	public List<Info_VO> management_Search_All_Games(PagingDTO pageDTO) throws Exception;
	public int management_Searched_Total_Rows(PagingDTO pageDTO) throws Exception;
	public String add_Game_Info(Info_VO info_VO) throws Exception;
	
	public void add_Game_Info_Logo_Image(Info_Image_VO info_Image_VO) throws Exception;
	public void add_Game_Info_Image(Info_Image_VO info_Image_VO) throws Exception;
	public Info_VO detail_Game_Info(String game_code) throws Exception;
	
	public Info_Image_VO detail_Game_Image_Logo_Info(String game_code) throws Exception;
	public List<Info_Image_VO> detail_Game_Image_Info(String game_code) throws Exception;
	
	public void mod_Game_Info(Info_VO mod_Info) throws Exception;
	public void update_Game_Image(Info_Image_VO info_Image_VO) throws Exception;

	
	public void delete_Game_Image_Info(String game_code) throws Exception;
	public void delete_Game_Info(String game_code) throws Exception;
	
	//0805추가
	public List<Review_VO> manageReviewWithPaging(PagingDTO pagingDTO) throws Exception;
	public int manageReviewWithPagingCount() throws Exception;
	public List<Review_VO> todayReview() throws Exception;
	public List<Review_VO> searchDayReview(String startDay,String endDay,PagingDTO pagingDTO) throws Exception;
	public int searchDayReviewCount(String startDay,String endDay) throws Exception;
	public void deleteReview(int review_code) throws Exception;
	public int overlapGame(String game_name, String small_category) throws Exception;
}
