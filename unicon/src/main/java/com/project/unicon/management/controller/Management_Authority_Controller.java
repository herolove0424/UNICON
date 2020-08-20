package com.project.unicon.management.controller;

import javax.servlet.http.HttpServletRequest;

import org.springframework.http.ResponseEntity;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestParam;

import com.project.unicon.vo.Member_VO;


public interface Management_Authority_Controller {
	public String autority_Form() throws Exception;
	public String idCheck(@RequestParam("id") String id) throws Exception;
	public String phoneCheck(@RequestParam("phone_Number") String phone_Number) throws Exception;
	
	public String author_Regist(@ModelAttribute("mem_Info") Member_VO member) throws Exception;
	public String confirm_Form(@ModelAttribute("mem_Info") Member_VO member,Model model,HttpServletRequest request) throws Exception;
	public ResponseEntity<String> confirm_Password(@RequestParam("inputPw") String inputPw,
			@ModelAttribute("hidden_Info") Member_VO member,HttpServletRequest request) throws Exception;
	
	public ResponseEntity<Object> ajax_AuthorList() throws Exception;
	//public String removeAuthor(@RequestParam("id") String id) throws Exception;
	public String removeAuthor(@ModelAttribute("removeInfo") Member_VO removemember,HttpServletRequest request) throws Exception;
	public ResponseEntity<String> changePrimaryPw(@RequestParam("valueById") String valueById,@RequestParam("valueByPw") String valueByPw) throws Exception;
	public String modifyAuthor(@ModelAttribute("modInfo") Member_VO modmember,HttpServletRequest request) throws Exception;
}
