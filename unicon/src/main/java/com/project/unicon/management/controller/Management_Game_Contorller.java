package com.project.unicon.management.controller;


import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.http.ResponseEntity;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.project.unicon.vo.Info_VO;

import common.paging.PagingDTO;

public interface Management_Game_Contorller {
	
	public String list_Game_Articles(@ModelAttribute("pagingDTO") PagingDTO pagingDTO,Model model) throws Exception;
	public  String add_GameForm() throws Exception;
	public ResponseEntity<Object> add_Game(@ModelAttribute("game_Info") Info_VO game_Info,MultipartHttpServletRequest multirequest) throws Exception;
	public String view_Game_Detail(@RequestParam Map<String, String> game_Detail, Model model) throws Exception;
	public ResponseEntity<Object> mod_Game_Info(@ModelAttribute("game_Info") Info_VO mod_Info,@RequestParam Map<String, String> image_Info,MultipartHttpServletRequest multirequest) throws Exception;
	public ResponseEntity<Object> remove_Game_Info(@RequestParam("game_code") String game_code,@RequestParam Map<String, String> info_For_Del) throws Exception;
	public String manageGameReview(HttpServletRequest request,PagingDTO pagingDTO, Model model) throws Exception;
	public String todayReview(HttpServletRequest request,Model model) throws Exception;
	public String searchDayReview(@RequestParam("startDay") String startDay,@RequestParam("endDay") String endDay,PagingDTO pagingDTO,Model model) throws Exception;
	public String delReview(@RequestParam Map<String, String> delReview) throws Exception;
	public String overlapGame(@RequestParam("small_category") String small_category,@RequestParam("game_name") String game_name) throws Exception;
}
