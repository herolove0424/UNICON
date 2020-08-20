package com.project.unicon.review.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.project.unicon.review.service.Review_Service;
import com.project.unicon.vo.Review_VO;

@Controller("review_Controller")
public class Review_ControllerImpl implements Review_Controller {
	@Autowired
	private Review_Service review_Service;
	
	//	댓글 전체 출력
	@Override
	@RequestMapping(value = "/review/reviewlist.do", method = {RequestMethod.GET, RequestMethod.POST})
	public ModelAndView reviewlist(@RequestParam String game_code, HttpServletRequest request) throws Exception {
		String viewName = getViewName(request);
		List<Review_VO> reviewlist = review_Service.reviewlist(game_code);
		ModelAndView mav = new ModelAndView(viewName);
		mav.addObject("reviewlist",reviewlist);
		return mav;
	}
	
	//	댓글 입력 기능
	@Override
	@RequestMapping(value = "/review/insertReview.do", method = {RequestMethod.GET, RequestMethod.POST})
	public ModelAndView insertReview(@RequestParam("game_code") String game_code, @RequestParam("id") String id, 
			@RequestParam("content") String content, @RequestParam("score") int score, 
					HttpServletRequest request, HttpServletResponse response) throws Exception {
		Review_VO review_VO = new Review_VO();
		review_VO.setGame_code(game_code);
		review_VO.setId(id);
		review_VO.setContent(content);
		review_VO.setScore(score);
		
		review_Service.insertReview(review_VO);		
		
		ModelAndView mav = new ModelAndView(); 
		return mav;		
	}
	
	//	댓글 추천 기능
	@Override
	@RequestMapping(value = "/review/goodsUp.do", method = {RequestMethod.GET, RequestMethod.POST})
	public ModelAndView goodsUpCount(@RequestParam("review_code") int review_code, 
			@RequestParam("id") String id, HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		Review_VO review_VO = new Review_VO();
		review_VO.setReview_code(review_code);
		review_VO.setId(id);
		
		//	추천수를 1 증가
		review_Service.goodsUpCount(review_VO);
		//	goods_detail 테이블에 id 및 review_code 입력
		review_Service.insertReviewDetail(review_VO);
		
		ModelAndView mav = new ModelAndView(); 
		return mav;
	}
	
	//	댓글 추천 ID 중복검사 기능
	@Override
	@ResponseBody
	@RequestMapping(value = "/review/idCheck.do", method = {RequestMethod.GET, RequestMethod.POST})
	public Map<Object, Object> goodsIdCheck(@RequestParam("id") String id, @RequestParam("review_code") int review_code) throws Exception {
		Map<Object, Object> map = new HashMap<Object, Object>();
		//	Null을 방지하기 위해 Integer 사용
		Integer count = 0;
		
		//	goods_detail 테이블에 id, review_code가 둘다 입력되어 있는 상태면 1, 아니라면 0을 리턴받음 
		count = review_Service.goodsIdCheck(id, review_code);
		//	JSP에 count라는 값으로 전달
		map.put("count", count);	
		return map;
	}
	
	//	댓글 삭제 기능
	@Override
	@RequestMapping(value = "/review/reviewDelete.do", method = {RequestMethod.GET, RequestMethod.POST})
	public ModelAndView reviewDelete(@RequestParam("id") String id, @RequestParam("review_code") int review_code, HttpServletRequest request, HttpServletResponse response) throws Exception {
		Review_VO review_VO = new Review_VO();
		review_VO.setReview_code(review_code);
		review_VO.setId(id);
		review_Service.reviewDelete(review_VO);
		ModelAndView mav = new ModelAndView();
		return mav;
	}

	//	View 이름 가져오기
	private String getViewName(HttpServletRequest request) throws Exception {
		String contextPath = request.getContextPath();
		String uri = (String) request.getAttribute("javax.servlet.include.request_uri");
		if (uri == null || uri.trim().equals("")) {
			uri = request.getRequestURI();
		}

		int begin = 0;
		if (!((contextPath == null) || ("".equals(contextPath)))) {
			begin = contextPath.length();
		}

		int end;
		if (uri.indexOf(";") != -1) {
			end = uri.indexOf(";");
		} else if (uri.indexOf("?") != -1) {
			end = uri.indexOf("?");
		} else {
			end = uri.length();
		}

		// System.out.println("begin:"+begin);
		// System.out.println("end:"+end);
		String viewName = uri.substring(begin, end);
		if (viewName.indexOf(".") != -1) {
			viewName = viewName.substring(0, viewName.lastIndexOf("."));
		}
		if (viewName.lastIndexOf("/") != -1) {
			// viewName = viewName.substring(viewName.lastIndexOf("/"), viewName.length());
			viewName = viewName.substring(viewName.lastIndexOf("/", 1), viewName.length());
		}
		return viewName;
	}
}