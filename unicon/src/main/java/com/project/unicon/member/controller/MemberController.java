package com.project.unicon.member.controller;

import java.util.List;
import java.util.Locale;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.http.ResponseEntity;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.project.unicon.vo.Member_VO;

public interface MemberController {

	public ModelAndView login(@ModelAttribute("loginById") Member_VO member, RedirectAttributes rAttr,
			HttpServletRequest request, HttpServletResponse response) throws Exception;

	public String loginform(HttpServletRequest request) throws Exception;

	public String memberform(HttpServletRequest request) throws Exception;

	public String main(Locale locale, Model model,HttpServletRequest request) throws Exception;

	public ModelAndView logout(HttpServletRequest request, HttpServletResponse sponse) throws Exception;

	public ModelAndView addMember(@ModelAttribute("member") Member_VO member, HttpServletRequest request, HttpServletResponse response) throws Exception;

	public String overlapped(@ModelAttribute("vo") Member_VO member, Model model) throws Exception;

	public @ResponseBody String overlappednick(@ModelAttribute("vo") Member_VO member, Model model) throws Exception;

	public @ResponseBody String overlappedemail(@ModelAttribute("vo") Member_VO member, Model model) throws Exception;

	public @ResponseBody String overlappedphone(@ModelAttribute("vo") Member_VO member, Model model) throws Exception;

	public ModelAndView findid(@ModelAttribute("member") Member_VO member, HttpServletRequest request,
			HttpServletResponse response) throws Exception;

	public String idfindform(HttpServletRequest request) throws Exception;

	public ModelAndView pwfind2(HttpServletRequest request, HttpServletResponse response) throws Exception;

	public ModelAndView mypagepw(@ModelAttribute("loginById") Member_VO member, HttpServletRequest request,
			HttpServletResponse response) throws Exception;

	public String mypagepwform(HttpServletRequest request) throws Exception;

	public ModelAndView modima(Member_VO memberVO, HttpServletRequest request, MultipartHttpServletRequest multipartRequest, HttpServletResponse response) throws Exception;

	public ModelAndView modifyform(@ModelAttribute("modifyForm") Member_VO member, HttpServletRequest request)
			throws Exception;
	
	public String upload(MultipartHttpServletRequest multipartRequest) throws Exception;

	public String pwmodifyform(HttpServletRequest request) throws Exception;

	public ModelAndView pwmodify(@ModelAttribute("member") Member_VO member, HttpServletRequest request,
			HttpServletResponse response) throws Exception;

	public String pwfindform(HttpServletRequest request) throws Exception;

	public ModelAndView findpw(Member_VO member, HttpServletRequest request, HttpServletResponse response) throws Exception;
	
	//	public String sendMail(@RequestParam("email") String email, HttpServletRequest request) throws Exception;
	
	//	public ResponseEntity<String> email_check(@RequestParam("email_check_number") int email_check_number, HttpServletRequest request) throws Exception;
	
	public ModelAndView mypageform(HttpServletRequest request) throws Exception;
	
	public String certification(@RequestParam("id") String id, @RequestParam("key") String key) throws Exception;
	
	public ModelAndView removemember(HttpServletRequest request, HttpServletResponse response) throws Exception;
	
	public ModelAndView reply(@RequestParam("id") String id, HttpServletRequest request) throws Exception;
	
	public ModelAndView boardlist(@RequestParam("id") String id, HttpServletRequest request) throws Exception;
	
	public void jjim(@RequestParam(value = "jjim") int jjim, @RequestParam(value = "id") String id,  @RequestParam(value = "game_name") String game_name, 
			@RequestParam(value = "small_category") String small_category, @RequestParam(value = "game_code") String game_code,
			HttpServletRequest request, HttpServletResponse response) throws Exception;

	public ModelAndView jjimlist(String id, HttpServletRequest request) throws Exception;
	
	public ModelAndView email(@RequestParam("id") String id, HttpServletRequest request) throws Exception;
	
	public String requestSend(@RequestParam("id") String id, HttpServletRequest request) throws Exception;
	
	public ModelAndView changeEmailView(@RequestParam("id") String id, HttpServletRequest request) throws Exception;
	
	public void changeEmail(@RequestParam("id") String id, @RequestParam("email") String email, HttpServletRequest request, HttpServletResponse response) throws Exception;
}
