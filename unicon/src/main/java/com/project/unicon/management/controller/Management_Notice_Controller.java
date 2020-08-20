package com.project.unicon.management.controller;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.http.ResponseEntity;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import com.google.gson.JsonObject;
import com.project.unicon.vo.Admin_Notice_VO;

import common.paging.PagingDTO;

public interface Management_Notice_Controller {
	public String notice_List(PagingDTO pagingDTO, Model model) throws Exception;
	public String notice_Form(HttpServletRequest request, Model model) throws Exception;
	public ResponseEntity<Object> notice_Add(@ModelAttribute("notice") Admin_Notice_VO notice, HttpServletRequest multirequest) throws Exception;
	public JsonObject uploadSummernoteImageFile(@RequestParam("file") MultipartFile multipartFile);
	public String noticeView(@RequestParam Map<String, String> urlInfo, Model model) throws Exception;
	public String modNoticeForm(@RequestParam Map<String, String> urlInfo, Model model) throws Exception;
	public String modNotice(@RequestParam Map<String, String> urlInfo, @ModelAttribute("notice") Admin_Notice_VO notice) throws Exception;
}
