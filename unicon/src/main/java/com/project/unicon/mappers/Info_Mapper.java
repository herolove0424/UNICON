package com.project.unicon.mappers;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.springframework.dao.DataAccessException;

import com.project.unicon.vo.Info_Image_VO;
import com.project.unicon.vo.Info_VO;

import common.paging.PagingDTO;

public interface Info_Mapper {
	// 모든 게임 리스트 출력
	List<Info_VO> allgamelist() throws DataAccessException;

	// 선택한 게임 리스트 출력
	List<Info_VO> gamelist(String small_category) throws DataAccessException;

	// 게임 검색 기능
	List<Info_VO> gamesearch(@Param("searchValue") String searchValue, @Param("small_category") String small_category)
			throws DataAccessException;

	// 게임 상세보기
	Info_VO gameview(int game_code) throws DataAccessException;

	// 게임 순위 출력
	List<Info_VO> ranklist() throws DataAccessException;

	// 투표 결과 DB 입력
	public int votes(Info_VO info_VO) throws DataAccessException;

	public int votesUp(Info_VO info_VO) throws DataAccessException;

	// 투표 ID 중복검사 기능
	public Integer votesIdCheck(@Param("id") String id) throws DataAccessException;

	// --- 0706 김도경 추가--

	// 페이징, 검색 기능
	public List<Info_VO> selectSearchedGameWithPaging(PagingDTO pagingDTO) throws Exception;

	public int selectSearchedTotalRows(PagingDTO pagingDTO) throws Exception;

	public int baseGameTotalRow(PagingDTO pagingDTO) throws Exception;

	// 게임 정보 입력
	public String gameInfoCode() throws Exception;

	public void insertGameInfo(Info_VO game_Info) throws Exception;

	// 게임 이미지 입력
	public int gameInfoImageNum() throws Exception;

	public void insertGameInfoImage(Info_Image_VO info_Image_VO) throws Exception;

	public void insertGameInfoLogoImage(Info_Image_VO info_Image_VO) throws Exception;

	// 게임 정보 상세 보기(관리자단)
	public Info_VO detail_Game_Info(String game_code) throws Exception;

	// 게임 정보 상세 변경(관리자단)
	public void mod_Game_Info(Info_VO mod_Info) throws Exception;

	// 게임 정보 삭제(관리자단)
	public void delete_Game_Info(String game_code) throws Exception;

	// --- 0706 김도경 추가 끝--
	
	// 추천 게임 리스트
	List<Info_VO> recommendlist(@Param("id") String id) throws DataAccessException;
	
	public int overlapGame(@Param("game_name") String game_name, @Param("small_category") String small_category) throws Exception;
	
	// 메인 페이지 인기리스트 출력
	List<Info_VO> popularlist(String big_category) throws Exception;
	
	List<Info_VO> votelist() throws DataAccessException;
		
}