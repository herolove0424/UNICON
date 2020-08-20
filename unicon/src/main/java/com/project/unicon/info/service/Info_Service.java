package com.project.unicon.info.service;

import java.util.List;

import org.springframework.dao.DataAccessException;

import com.project.unicon.vo.Info_Image_VO;
import com.project.unicon.vo.Info_VO;

public interface Info_Service {
	public List<Info_VO> allgamelist() throws DataAccessException;
	public List<Info_VO> gamelist(String small_category) throws DataAccessException;
	//	public List<Info_VO> pcgameList() throws DataAccessException;
	//	public List<Info_VO> mobilegameList() throws DataAccessException;
	//	public List<Info_VO> xboxgameList() throws DataAccessException;
	//	public List<Info_VO> psgameList() throws DataAccessException;
	//	public List<Info_VO> nintendogameList() throws DataAccessException;
	public List<Info_VO> gamesearch(String searchValue, String small_category) throws DataAccessException;
	public Info_VO gameview(int game_code) throws DataAccessException;
	public List<Info_VO> gameRanking() throws DataAccessException;
	public List<Info_VO> gamevoteslist() throws DataAccessException;
	public int votes(Info_VO info_VO) throws DataAccessException;
	public int votesUp(Info_VO info_VO) throws DataAccessException;
	public Integer votesIdCheck(String id) throws DataAccessException;
	//	public List<Info_VO> tagsearch(String hash_tag) throws DataAccessException;
	public List<Info_VO> recommendlist(String id) throws DataAccessException;
	public List<Info_VO> popularlist(String big_category) throws Exception;
	public Info_Image_VO logoImage(int game_code) throws Exception;
	public List<Info_Image_VO> threeImage(int game_code) throws Exception;
	public List<Info_Image_VO> logolist() throws Exception;
}