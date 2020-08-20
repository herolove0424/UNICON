package com.project.unicon.management.controller;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.http.ResponseEntity;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.project.unicon.vo.All_Board_VO;

import common.paging.PagingDTO;

public interface Management_Search_Controller {
	
	public String management_Member_Search_Form(HttpServletRequest request,Model model) throws Exception;	
	public ModelAndView management_Member_Search(@RequestParam Map<String, String> search_Info, HttpServletRequest request, HttpServletResponse response) throws Exception;
	public ModelAndView management_Detail_Member(@RequestParam("id") String id, HttpServletRequest request, HttpServletResponse response) throws Exception;
	public ModelAndView management_Detail_Member_Temp(@RequestParam("id") String id, HttpServletRequest request, HttpServletResponse response) throws Exception;
	public String memberActivity(@RequestParam("id") String id,PagingDTO pagingDTO,Model model) throws Exception;
	public String searchMembersBoard(@ModelAttribute("searchBoard") All_Board_VO searchBoard) throws Exception;
	
}
