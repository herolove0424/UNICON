package com.project.unicon.management.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.project.unicon.vo.Member_VO;

public interface Management_Controller {
	
	public String management_Main(HttpServletRequest request,Model model) throws Exception;
	public String management_Login_Form(HttpServletRequest request) throws Exception;
	public ModelAndView management_Login(@ModelAttribute("login_Info") Member_VO member_VO,RedirectAttributes redirect_Attr, HttpServletRequest request, HttpServletResponse response) throws Exception;
	public ModelAndView logout(HttpServletRequest request, HttpServletResponse sponse) throws Exception;
}
