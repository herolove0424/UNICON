package com.project.unicon.info.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataAccessException;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.project.unicon.mappers.Info_Image_Mapper;
import com.project.unicon.mappers.Info_Mapper;
import com.project.unicon.vo.Info_Image_VO;
import com.project.unicon.vo.Info_VO;

@Service("info_Service")
@Transactional(propagation = Propagation.REQUIRED)
public class Info_ServiceImpl implements Info_Service {
	
	@Autowired
	private Info_Mapper info_Mapper;
	
	@Autowired
	private Info_Image_Mapper info_Image_Mapper;
	
	@Override
	public List<Info_VO> allgamelist() throws DataAccessException {
		List<Info_VO> allgamelist;
		allgamelist = info_Mapper.allgamelist();
		return allgamelist;
	}
	
	@Override
	public List<Info_VO> gamelist(String small_category) throws DataAccessException {
		List<Info_VO> gamelist = null;
		gamelist =  info_Mapper.gamelist(small_category);
		
		return gamelist;
	}
	
	@Override
	public List<Info_Image_VO> logolist() throws Exception {
		List<Info_Image_VO> logolist = null;
		logolist =  info_Image_Mapper.logolist();
		
		return logolist;
	}
	
	//	@Override
	//	public List<Info_VO> pcgameList() throws DataAccessException {
	//		List<Info_VO> pcgameList;
	//		pcgameList = info_Mapper.pcgamelist();
	//		return pcgameList;
	//	}
	//	
	//	@Override
	//	public List<Info_VO> mobilegameList() throws DataAccessException {
	//		List<Info_VO> mobilegameList;
	//		mobilegameList = info_Mapper.mobilegamelist();
	//		return mobilegameList;
	//	}
	//	
	//	@Override
	//	public List<Info_VO> xboxgameList() throws DataAccessException {
	//		List<Info_VO> xboxgameList;
	//		xboxgameList = info_Mapper.xboxgamelist();
	//		return xboxgameList;
	//	}
	//	
	//	@Override
	//	public List<Info_VO> psgameList() throws DataAccessException {
	//		List<Info_VO> psgameList;
	//		psgameList = info_Mapper.psgamelist();
	//		return psgameList;
	//	}
	//	
	//	@Override
	//	public List<Info_VO> nintendogameList() throws DataAccessException {
	//		List<Info_VO> nintendogameList;
	//		nintendogameList = info_Mapper.nintendogamelist();
	//		return nintendogameList;
	//	}
	
	@Override
	public Info_VO gameview(int game_code) throws DataAccessException {
		Info_VO info_VO = null;
		info_VO =  info_Mapper.gameview(game_code);
		return info_VO;
	}
	
	@Override
	public List<Info_VO> gamesearch(String searchValue, String small_category) throws DataAccessException {
		List<Info_VO> searchGameList;
		searchGameList = info_Mapper.gamesearch(searchValue, small_category);
		return searchGameList;
	}
	
	@Override
	public List<Info_VO> gameRanking() throws DataAccessException {
		List<Info_VO> rankList;
		rankList = info_Mapper.ranklist();
		return rankList;
	}
	
	@Override
	public List<Info_VO> gamevoteslist() throws DataAccessException {
		List<Info_VO> gamevoteslist;
		gamevoteslist = info_Mapper.votelist();
		return gamevoteslist;
	}
	
	@Override
	public int votes(Info_VO info_VO) throws DataAccessException {
		return info_Mapper.votes(info_VO);
	}
	
	@Override
	public int votesUp(Info_VO info_VO) throws DataAccessException {
		return info_Mapper.votesUp(info_VO);
	}
	
	@Override
	public Integer votesIdCheck(String id) throws DataAccessException {
		return info_Mapper.votesIdCheck(id);
	}
	
	//	@Override
	//	public List<Info_VO> tagsearch(String hash_tag) throws DataAccessException {
	//		List<Info_VO> info_VO = null;
	//		info_VO =  info_Mapper.tagsearch(hash_tag);
	//		return info_VO;
	//	}
	
	@Override
	public List<Info_VO> recommendlist(String id) throws DataAccessException {
		return info_Mapper.recommendlist(id);
	}
	
	@Override
	public List<Info_VO> popularlist(String big_category) throws Exception {
		return info_Mapper.popularlist(big_category);
	}
	

	//로고 출력
	@Override
	public Info_Image_VO logoImage(int game_code) throws Exception {
		
		return info_Image_Mapper.detail_Game_Image_Logo_Info(String.valueOf(game_code));
	}
	
	//이미지 3장 출력
	@Override
	public List<Info_Image_VO> threeImage(int game_code) throws Exception {
		
		return info_Image_Mapper.detail_Game_Image_Info(String.valueOf(game_code));
	}
	
	
}