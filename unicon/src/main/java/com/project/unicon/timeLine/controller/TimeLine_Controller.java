package com.project.unicon.timeLine.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

public interface TimeLine_Controller {
	public ModelAndView newsFeed(HttpServletRequest request, HttpServletResponse response) throws Exception;
	
	public String timeLineMain(HttpServletRequest request) throws Exception;
	
	public ModelAndView friendList(@RequestParam(value="id") String id, HttpServletRequest request, HttpServletResponse response) throws Exception;
	
	// 민우 통합 08/13 추가
	public ModelAndView friendListDetail(HttpServletRequest request, HttpServletResponse response) throws Exception;
	
	public String searchView(HttpServletRequest request) throws Exception;
	
	public String nicknameSearch(@RequestParam("friend_nickname") String nickname, HttpServletRequest request, HttpServletResponse response,Model model) throws Exception;
	
	public ModelAndView friendDelete(@RequestParam("id_1") String id_1, @RequestParam("id_2") String id_2, HttpServletRequest request, HttpServletResponse response) throws Exception;

	public ModelAndView friendRequestDelete(@RequestParam("id_1") String id_1, @RequestParam("id_2") String id_2, HttpServletRequest request, HttpServletResponse response) throws Exception;
	
	public ModelAndView friendAccept(@RequestParam("id_1") String id_1, @RequestParam("id_2") String id_2, HttpServletRequest request, HttpServletResponse response) throws Exception;
	
	public ModelAndView friendReject(@RequestParam("id_1") String id_1, @RequestParam("id_2") String id_2, HttpServletRequest request, HttpServletResponse response) throws Exception;
	
	public String friendRequest(@RequestParam("id_1") String id_1, @RequestParam("id_2") String id_2,
			HttpServletRequest request, HttpServletResponse response) throws Exception;
}