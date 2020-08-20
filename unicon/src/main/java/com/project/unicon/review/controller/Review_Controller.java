package com.project.unicon.review.controller;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

public interface Review_Controller {
	public ModelAndView reviewlist(@RequestParam String game_code, HttpServletRequest request) throws Exception;
	public ModelAndView insertReview(@RequestParam("game_code") String game_code, @RequestParam("id") String id, 
			@RequestParam("content") String content, @RequestParam("score") int score, 
					HttpServletRequest request, HttpServletResponse response) throws Exception;
	public ModelAndView goodsUpCount(@RequestParam("review_code") int review_code,
			@RequestParam("id") String id,	HttpServletRequest request, HttpServletResponse response) throws Exception;
	public Map<Object, Object> goodsIdCheck(@RequestParam("id") String id, @RequestParam("review_code") int review_code) throws Exception;
	public ModelAndView reviewDelete(@RequestParam("id") String id, @RequestParam("review_code") int review_code, HttpServletRequest request, HttpServletResponse response) throws Exception;
}