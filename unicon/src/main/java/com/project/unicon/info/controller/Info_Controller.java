package com.project.unicon.info.controller;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

	public interface Info_Controller {
	public ModelAndView main(HttpServletRequest request, HttpServletResponse response) throws Exception;
	public ModelAndView gamelist(@RequestParam(value = "small_category") String small_category, HttpServletRequest request, HttpServletResponse response) throws Exception;
	//	public ModelAndView pcgamelist(HttpServletRequest request, HttpServletResponse response) throws Exception;
	//	public ModelAndView mobilegamelist(HttpServletRequest request, HttpServletResponse response) throws Exception;
	//	public ModelAndView xboxgamelist(HttpServletRequest request, HttpServletResponse response) throws Exception;
	//	public ModelAndView psgamelist(HttpServletRequest request, HttpServletResponse response) throws Exception;
	//	public ModelAndView nintendogamelist(HttpServletRequest request, HttpServletResponse response) throws Exception;
	public ModelAndView gameview(@RequestParam("game_code") int game_code, HttpServletRequest request, HttpServletResponse response) throws Exception;
	public ModelAndView gamesearch(@RequestParam(value="searchValue", required=false) String searchValue, 
		@RequestParam(value="genre", required=false) String genre, HttpServletRequest request, HttpServletResponse response) throws Exception;
	public ModelAndView gameRanking(HttpServletRequest request, HttpServletResponse response) throws Exception;
	public ModelAndView gamevoteslist(HttpServletRequest request, HttpServletResponse response) throws Exception;
	public ModelAndView gamevotes(List<String> codelist, @RequestParam("id") String id, HttpServletRequest request) throws Exception;
	public Map<Object, Object> votesIdCheck(@RequestParam("id") String id) throws Exception;
	//	public ModelAndView tagsearch(@RequestParam("hash_tag") String hash_tag, HttpServletRequest request, HttpServletResponse response) throws Exception;
	public ModelAndView recommendlist(@RequestParam("id") String id, HttpServletRequest request) throws Exception;
	public ModelAndView popularlist(@RequestParam("big_category") String big_category, HttpServletRequest request) throws Exception;
}