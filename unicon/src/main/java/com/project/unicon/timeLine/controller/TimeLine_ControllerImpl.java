package com.project.unicon.timeLine.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.project.unicon.timeLine.service.TimeLine_Service;
import com.project.unicon.vo.Member_VO;
import com.project.unicon.vo.TimeLine_VO;

@Controller("timeLine_Controller")
public class TimeLine_ControllerImpl implements TimeLine_Controller {

	@Autowired
	private TimeLine_Service timeLine_Service;

	@Autowired
	private TimeLine_VO timeLine_VO;

	// 메인 페이지
	@Override
	@RequestMapping(value = "/timeLine/timeLineMain.do", method = RequestMethod.GET)
	public String timeLineMain(HttpServletRequest request) throws Exception {
		HttpSession session = request.getSession();
		session.removeAttribute("searchValue");
		return "/timeLine/main";
	}

	// 뉴스피드로 이동
	@Override
	@RequestMapping(value = "/timeLine/newsFeed.do", method = { RequestMethod.GET, RequestMethod.POST })
	public ModelAndView newsFeed(HttpServletRequest request, HttpServletResponse response) throws Exception {
		ModelAndView mav = new ModelAndView();

		return mav;
	}

	// 친구 목록
	@Override
	@RequestMapping(value = "/timeLine/friendList.do", method = { RequestMethod.GET, RequestMethod.POST })
	public ModelAndView friendList(@RequestParam(value = "id") String id, HttpServletRequest request,
			HttpServletResponse response) throws Exception {

		List<TimeLine_VO> friendList = timeLine_Service.friendList(id);
		List<TimeLine_VO> friendRequestList = timeLine_Service.friendRequestList(id);
		List<TimeLine_VO> friendAcceptList = timeLine_Service.friendAcceptList(id);
		Integer friendCount = timeLine_Service.friendCount(id);
		ModelAndView mav = new ModelAndView();
		mav.addObject("friendList", friendList);
		mav.addObject("count", friendCount);
		mav.addObject("friendRequestList", friendRequestList);
		mav.addObject("friendAcceptList", friendAcceptList);
		mav.setViewName("/timeLine/friendList");
		return mav;
	}

	// 친구 목록 디테일(사이트바에 detail)버튼
	@Override
	@RequestMapping(value = "/timeLine/friendListDetail.do", method = { RequestMethod.GET, RequestMethod.POST })
	public ModelAndView friendListDetail(HttpServletRequest request, HttpServletResponse response) throws Exception {
		HttpSession session = request.getSession();
		Member_VO memberVO = (Member_VO) session.getAttribute("member");
		String id = memberVO.getId();
		List<TimeLine_VO> friendList = timeLine_Service.friendList(id);

		ModelAndView mav = new ModelAndView();
		mav.addObject("friendList", friendList);
		mav.setViewName("timeLine/friendListDetail");
		return mav;
	}

	// 친구 삭제
	@Override
	@RequestMapping(value = "/timeLine/friendDelete.do", method = { RequestMethod.GET, RequestMethod.POST })
	public ModelAndView friendDelete(@RequestParam("id_1") String id_1, @RequestParam("id_2") String id_2,
			HttpServletRequest request, HttpServletResponse response) throws Exception {
		timeLine_VO.setId_1(id_1);
		timeLine_VO.setId_2(id_2);
		timeLine_Service.friendDelete(timeLine_VO);
		ModelAndView mav = new ModelAndView();
		mav.setViewName("/timeLine/friendList");
		return mav;
	}

	// 친구 요청 취소
	@Override
	@RequestMapping(value = "/timeLine/friendRequestDelete.do", method = { RequestMethod.GET, RequestMethod.POST })
	public ModelAndView friendRequestDelete(@RequestParam("id_1") String id_1, @RequestParam("id_2") String id_2,
			HttpServletRequest request, HttpServletResponse response) throws Exception {
		timeLine_VO.setId_1(id_1);
		timeLine_VO.setId_2(id_2);
		timeLine_Service.friendRequestDelete(timeLine_VO);
		ModelAndView mav = new ModelAndView();
		mav.setViewName("/timeLine/friendList");
		return mav;
	}

	// 친구 수락
	@Override
	@RequestMapping(value = "/timeLine/friendAccept.do", method = { RequestMethod.GET, RequestMethod.POST })
	public ModelAndView friendAccept(@RequestParam("id_1") String id_1, @RequestParam("id_2") String id_2,
			HttpServletRequest request, HttpServletResponse response) throws Exception {
		System.out.println(id_1);
		System.out.println(id_2);
		timeLine_VO.setId_1(id_1);
		timeLine_VO.setId_2(id_2);
		timeLine_Service.friendAccept1(timeLine_VO);
		timeLine_Service.friendAccept2(timeLine_VO);
		ModelAndView mav = new ModelAndView();
		mav.setViewName("/timeLine/friendList");
		return mav;
	}

	// 친구 거절
	@Override
	@RequestMapping(value = "/timeLine/friendReject.do", method = { RequestMethod.GET, RequestMethod.POST })
	public ModelAndView friendReject(@RequestParam("id_1") String id_1, @RequestParam("id_2") String id_2,
			HttpServletRequest request, HttpServletResponse response) throws Exception {
		timeLine_VO.setId_1(id_1);
		timeLine_VO.setId_2(id_2);
		timeLine_Service.friendReject(timeLine_VO);
		ModelAndView mav = new ModelAndView();
		mav.setViewName("/timeLine/friendList");
		return mav;
	}

	// 친구 검색 창으로 이동
	@Override
	@RequestMapping(value = "/timeLine/search.do", method = { RequestMethod.GET, RequestMethod.POST })
	public String searchView(HttpServletRequest request) throws Exception {

		return "/timeLine/friendSearch";
	}

	// 친구 검색
	@Override
	@RequestMapping(value = "/timeLine/nicknameSearch.do", method = { RequestMethod.GET, RequestMethod.POST })
	public String nicknameSearch(@RequestParam("friend_nickname") String nickname, HttpServletRequest request,
			HttpServletResponse response, Model model) throws Exception {

		List<Member_VO> friend_VO = timeLine_Service.nicknameSearch(nickname);
		System.out.println("friend_VO.getNickName()" + friend_VO.isEmpty());

		// 유저검색하는 페이지에도 친구리스트 던져줘야함.
		HttpSession session = request.getSession();
		Member_VO memberVO = (Member_VO) session.getAttribute("member");
		String id = memberVO.getId();
		List<TimeLine_VO> friendList = timeLine_Service.friendList(id);
		int friendCount = timeLine_Service.friendCount(id);

		model.addAttribute("friendList", friendList);
		model.addAttribute("count", friendCount);
		model.addAttribute("value", friend_VO);
		model.addAttribute("searchValue", nickname);

		return "/timeLine/friendSearch";
	}

		// 친구 요청
		//도경 수정 0812----------------------------------
		@Override
		//@PostMapping("/timeLine/friendRequest.do")
		@GetMapping("/timeLine/friendRequest.do")
		@ResponseBody
		public String friendRequest(@RequestParam("id_1") String id_1, @RequestParam("id_2") String id_2,
				HttpServletRequest request, HttpServletResponse response) throws Exception {
			System.out.println("친구 신청됐니?");
			//민우 이거 넣기전에 나랑 상의
			
			int status = 0;
			String friendId1="";
			String friendId2="";
			int alter=0;
			
			int count=timeLine_Service.countFriendAccept(id_1);
			
			if(count==0) {
			alter = 0;

			timeLine_VO.setId_1(id_1);
			timeLine_VO.setId_2(id_2);
			timeLine_Service.friendRequest(timeLine_VO);
			}else if(count==1) {
				TimeLine_VO friendYN = timeLine_Service.alreadyFriend(id_1, id_2);
				status = friendYN.getStatus();
				friendId1 = friendYN.getId_1();//이게 나
				friendId2 = friendYN.getId_2();//상대방
				
				if(friendId1.equals(id_1)) {
					//본인이 친구신청 한 사람한테 친구 신청함
					alter=2;
				}else if(friendId2.equals(id_1)){
					//해당 사람한테 친구 신청을 받은 상태
					alter=3;
				}
			}else {
				alter=1;
			}
			
			
			/*
			try {
				TimeLine_VO friendYN = timeLine_Service.alreadyFriend(id_1, id_2);
				status = friendYN.getStatus();
				friendId1 = friendYN.getId_1();//이게 나
				friendId2 = friendYN.getId_2();//상대방
			}catch (Exception e) {
				//친구아님
				alter=0;
				
				timeLine_VO.setId_1(id_1);
				timeLine_VO.setId_2(id_2);
				timeLine_Service.friendRequest(timeLine_VO);
			}
			
			//1이면 이미 친구임
			if(status==1) {
				alter=1;
			}else {
				//status가 0이면 친구 신청만 들어간 상태
				if(friendId1.equals(id_1)) {
					//본인이 친구신청 한 사람한테 친구 신청함
					alter=2;
				}else if(friendId2.equals(id_2)){
					//해당 사람한테 친구 신청을 받은 상태
					alter=3;
				}
			}*/
			System.out.println("alter값" + alter);
			String result = String.valueOf(alter);
			
			//friendVO.setId_1(id_1);
			//friendVO.setId_2(id_2);
			//friendService.friendRequest(friendVO);
			//ModelAndView mav = new ModelAndView();
			//mav.addObject("alter", alter);
			//mav.setViewName("/friend/friendList");
			return result;
		}
	

	// 김도경 추가
	@GetMapping("/timeLine/requestPop.do")
	public String requestPop(@RequestParam("id_2") String id_2, HttpServletRequest request, Model model)
			throws Exception {
		HttpSession session = request.getSession();
		String id_1 = (String) session.getAttribute("memberforBoard");
		// 기존 친구 여부 및 신청 여부확인
		int status = 0;
		String friendId1 = "";
		String friendId2 = "";
		int alter = 0;
		try {
			TimeLine_VO friendYN = timeLine_Service.alreadyFriend(id_1, id_2);
			status = friendYN.getStatus();
			friendId1 = friendYN.getId_1();
			friendId2 = friendYN.getId_2();
		} catch (Exception e) {
			alter = 0;
		}

		// 1이면 이미 친구임
		if (status == 1) {
			alter = 1;
		} else {
			// status가 0이면 친구 신청만 들어간 상태
			if (friendId1.equals(id_1)) {
				// 본인이 친구신청 한 사람한테 친구 신청함
				alter = 2;
			} else if (friendId2.equals(id_1)) {
				// 해당 사람한테 친구 신청을 받은 상태
				alter = 3;
			}
		}

		model.addAttribute("id_1", id_1);
		model.addAttribute("id_2", id_2);
		model.addAttribute("alter", alter);
		return "/board/requestPop";
	}

	@PostMapping("/timeLine/friendRequestPop.do")
	public String friendRequestPop(@RequestParam("id_1") String id_1, @RequestParam("id_2") String id_2)
			throws Exception {
		System.out.println("친구 신청됐니?");
		String result = "";
		try {
			timeLine_VO.setId_1(id_1);
			timeLine_VO.setId_2(id_2);
			timeLine_Service.friendRequest(timeLine_VO);
			result = "success";
		} catch (Exception e) {
			result = "error";
		}

		return result;
	}

}