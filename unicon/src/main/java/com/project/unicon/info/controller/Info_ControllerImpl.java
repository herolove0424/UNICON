package com.project.unicon.info.controller;

import java.io.File;
import java.io.FileInputStream;
import java.io.OutputStream;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.oreilly.servlet.ParameterParser;
import com.project.unicon.board.Service.Message_Service;
import com.project.unicon.info.service.Info_Service;
import com.project.unicon.member.service.MemberService;
import com.project.unicon.vo.Info_Image_VO;
import com.project.unicon.vo.Info_VO;
import com.project.unicon.vo.Jjim_VO;
import com.project.unicon.vo.Member_VO;

@Controller("info_Controller")
public class Info_ControllerImpl implements Info_Controller {

	@Autowired
	private Info_Service info_Service;
	@Autowired
	private MemberService memberService;

	// 쪽지로 인한 추가
	@Autowired
	private Message_Service message_Service;

	public static final String IMAGE_REPO = "C:\\project\\image";

	// 메인 페이지
	@Override
	@RequestMapping(value = "main.do", method = { RequestMethod.GET, RequestMethod.POST })
	public ModelAndView main(HttpServletRequest request, HttpServletResponse response) throws Exception {
		String viewName = getViewName(request);
		ModelAndView mav = new ModelAndView(viewName);

		// 쪽지로 인한 추가(김도경)
		HttpSession session = request.getSession();
		String id = "";

		memberService.setVisitTotalCount();

		try {
			id = (String) session.getAttribute("memberforBoard");
			System.out.println("세션 바인딩 아이디 찾기" + id);
			if (id != "" || id.length() != 0) {
				int remainMessage = message_Service.countRemainMessage(id);

				// mav.addObject("remainMessage", remainMessage);
				session.setAttribute("remainMessage", remainMessage);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}

		return mav;
	}

	// 모든 게임 리스트 출력
	@Override
	@RequestMapping(value = "/info/gamelist.do", method = { RequestMethod.GET, RequestMethod.POST })
	public ModelAndView gamelist(@RequestParam(value = "small_category", required = false) String small_category,
			HttpServletRequest request, HttpServletResponse response) throws Exception {
		HttpSession session = request.getSession();
		String viewName = getViewName(request);
		ModelAndView mav = new ModelAndView(viewName);
		if (small_category == null) {
			List<Info_VO> gamelist = info_Service.allgamelist();
			mav.addObject("gamelist", gamelist);
			mav.addObject("small_category", "all");
			session.removeAttribute("searchValue");
		} else {
			List<Info_VO> gamelist = info_Service.gamelist(small_category);
			mav.addObject("gamelist", gamelist);
			mav.addObject("small_category", small_category);
			session.removeAttribute("searchValue");
		}
		List<Info_Image_VO> logolist = info_Service.logolist();
	    mav.addObject("logolist",logolist);
	    return mav;
	}

	// // PC게임 리스트 출력
	// @Override
	// @RequestMapping(value = "/info/pcgamelist.do", method = {RequestMethod.GET,
	// RequestMethod.POST})
	// public ModelAndView pcgamelist(HttpServletRequest request,
	// HttpServletResponse response) throws Exception {
	// HttpSession session = request.getSession();
	// String viewName = getViewName(request);
	// List<Info_VO> pcgameList = info_Service.pcgameList();
	// ModelAndView mav = new ModelAndView(viewName);
	// mav.addObject("pcgameList", pcgameList);
	// return mav;
	// }
	//
	// // Mobile게임 리스트 출력
	// @Override
	// @RequestMapping(value = "/info/mobilegamelist.do", method =
	// {RequestMethod.GET, RequestMethod.POST})
	// public ModelAndView mobilegamelist(HttpServletRequest request,
	// HttpServletResponse response) throws Exception {
	// HttpSession session = request.getSession();
	// String viewName = getViewName(request);
	// List<Info_VO> mobilegameList = info_Service.mobilegameList();
	// ModelAndView mav = new ModelAndView(viewName);
	// mav.addObject("mobilegameList", mobilegameList);
	// return mav;
	// }
	//
	// // Xbox게임 리스트 출력
	// @Override
	// @RequestMapping(value = "/info/xboxgamelist.do", method = {RequestMethod.GET,
	// RequestMethod.POST})
	// public ModelAndView xboxgamelist(HttpServletRequest request,
	// HttpServletResponse response) throws Exception {
	// HttpSession session = request.getSession();
	// String viewName = getViewName(request);
	// List<Info_VO> xboxgameList = info_Service.xboxgameList();
	// ModelAndView mav = new ModelAndView(viewName);
	// mav.addObject("xboxgameList", xboxgameList);
	// return mav;
	// }
	//
	// // PS게임 리스트 출력
	// @Override
	// @RequestMapping(value = "/info/psgamelist.do", method = {RequestMethod.GET,
	// RequestMethod.POST})
	// public ModelAndView psgamelist(HttpServletRequest request,
	// HttpServletResponse response) throws Exception {
	// HttpSession session = request.getSession();
	// String viewName = getViewName(request);
	// List<Info_VO> psgameList = info_Service.psgameList();
	// ModelAndView mav = new ModelAndView(viewName);
	// mav.addObject("psgameList", psgameList);
	// return mav;
	// }
	//
	// // Nintendo게임 리스트 출력
	// @Override
	// @RequestMapping(value = "/info/nintendogamelist.do", method =
	// {RequestMethod.GET, RequestMethod.POST})
	// public ModelAndView nintendogamelist(HttpServletRequest request,
	// HttpServletResponse response) throws Exception {
	// HttpSession session = request.getSession();
	// String viewName = getViewName(request);
	// List<Info_VO> nintendogameList = info_Service.nintendogameList();
	// ModelAndView mav = new ModelAndView(viewName);
	// mav.addObject("nintendogameList", nintendogameList);
	// return mav;
	// }

//  게임 상세보기
	@Override
	@RequestMapping(value = "/info/gameview", method = { RequestMethod.GET, RequestMethod.POST })
	public ModelAndView gameview(@RequestParam("game_code") int game_code, HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		HttpSession session = request.getSession();
		String viewName = getViewName(request);
		Info_VO info_VO = info_Service.gameview(game_code);
		ModelAndView mav = new ModelAndView(viewName);
		if (session.getAttribute("member") != null) {
			Member_VO sessmember = (Member_VO) session.getAttribute("member");
			Jjim_VO jjimvo = new Jjim_VO();
			jjimvo.setId(sessmember.getId());
			jjimvo.setGame_code(String.valueOf(game_code));
			int jjim = memberService.getjjim(jjimvo);
			mav.addObject("jjim", jjim);
		}
		Info_Image_VO logo = info_Service.logoImage(game_code);
	    List<Info_Image_VO> imagelist = info_Service.threeImage(game_code);
	    mav.addObject("logo",logo);
	    mav.addObject("imagelist", imagelist);
		mav.addObject("info_VO", info_VO);

		return mav;
	}

//	게임 검색 기능
	@Override
	@RequestMapping(value = "/info/gamesearch.do", method = { RequestMethod.GET, RequestMethod.POST })
	public ModelAndView gamesearch(@RequestParam(value = "searchValue", required = false) String searchValue,
			@RequestParam(value = "small_category", required = false) String small_category, HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		HttpSession session = request.getSession();
		String viewName = getViewName(request);
		ModelAndView mav = new ModelAndView(viewName);

		if (small_category.equals("all")) {
			System.out.println(small_category);
			List<Info_VO> gamelist = info_Service.gamesearch(searchValue, small_category);
			mav.addObject("gamelist", gamelist);
			System.out.println("전체 검색");
			mav.setViewName("info/gamelist");
			session.setAttribute("searchValue", searchValue);
		} else if (small_category.equals("mobile")) {
			System.out.println(small_category);
			List<Info_VO> gamelist = info_Service.gamesearch(searchValue, small_category);
			mav.addObject("gamelist", gamelist);
			System.out.println("모바일 검색");
			mav.setViewName("info/gamelist");
			session.setAttribute("searchValue", searchValue);
		} else if (small_category.equals("pc")) {
			System.out.println(small_category);
			List<Info_VO> gamelist = info_Service.gamesearch(searchValue, small_category);
			mav.addObject("gamelist", gamelist);
			System.out.println("피씨 검색");
			mav.setViewName("info/gamelist");
			session.setAttribute("searchValue", searchValue);
		} else if (small_category.equals("switch")) {
			System.out.println(small_category);
			List<Info_VO> gamelist = info_Service.gamesearch(searchValue, small_category);
			mav.addObject("gamelist", gamelist);
			System.out.println("닌텐도 검색");
			mav.setViewName("info/gamelist");
			session.setAttribute("searchValue", searchValue);
		} else if (small_category.equals("ps4")) {
			System.out.println(small_category);
			List<Info_VO> gamelist = info_Service.gamesearch(searchValue, small_category);
			mav.addObject("gamelist", gamelist);
			System.out.println("ps4 검색");
			mav.setViewName("info/gamelist");
			session.setAttribute("searchValue", searchValue);
		} else if (small_category.equals("xbox")) {
			System.out.println(small_category);
			List<Info_VO> gamelist = info_Service.gamesearch(searchValue, small_category);
			mav.addObject("gamelist", gamelist);
			System.out.println("xbox 검색");
			mav.setViewName("info/gamelist");
			session.setAttribute("searchValue", searchValue);
		}
		return mav;
	}

	// 게임 순위 출력
	@Override
	@RequestMapping(value = "/info/gamerank.do", method = { RequestMethod.GET, RequestMethod.POST })
	public ModelAndView gameRanking(HttpServletRequest request, HttpServletResponse response) throws Exception {
		String viewName = getViewName(request);
		List<Info_VO> rankList = info_Service.gameRanking();
		ModelAndView mav = new ModelAndView(viewName);
		mav.addObject("rankList", rankList);
		return mav;
	}

	// 게임 투표 리스트 출력
	@Override
	@RequestMapping(value = "/info/gamevoteslist.do", method = { RequestMethod.GET, RequestMethod.POST })
	public ModelAndView gamevoteslist(HttpServletRequest request, HttpServletResponse response) throws Exception {
		String viewName = getViewName(request);
		List<Info_VO> gamevoteslist = info_Service.gamevoteslist();
		ModelAndView mav = new ModelAndView(viewName);
		mav.addObject("gamevoteslist", gamevoteslist);
		return mav;
	}

	// 게임 투표 기능
	@Override
	@ResponseBody
	@RequestMapping(value = "/info/gamevotes.do", method = { RequestMethod.GET, RequestMethod.POST })
	public ModelAndView gamevotes(@RequestParam(value = "codelist", required = false) List<String> codelist,
			@RequestParam("id") String id, HttpServletRequest request) throws Exception {
		Info_VO info_VO = new Info_VO();

		info_VO.setId(id);

		if (codelist.size() == 1) {
			System.out.println("투표 수 : 1개");
			info_VO.setVote1(codelist.get(0));
			info_VO.setVote2(null);
			info_VO.setVote3(null);
		} else if (codelist.size() == 2) {
			System.out.println("투표 수 : 2개");
			info_VO.setVote1(codelist.get(0));
			info_VO.setVote2(codelist.get(1));
			info_VO.setVote3(null);
		} else if (codelist.size() == 3) {
			System.out.println("투표 수 : 3개");
			info_VO.setVote1(codelist.get(0));
			info_VO.setVote2(codelist.get(1));
			info_VO.setVote3(codelist.get(2));
		}

		info_Service.votes(info_VO);
		info_Service.votesUp(info_VO);
		ModelAndView mav = new ModelAndView();
		return mav;
	}

	// 투표 ID 중복검사 기능
	@Override
	@ResponseBody
	@RequestMapping(value = "/info/votesidCheck.do", method = { RequestMethod.GET, RequestMethod.POST })
	public Map<Object, Object> votesIdCheck(@RequestParam("id") String id) throws Exception {
		Map<Object, Object> map = new HashMap<Object, Object>();
		// Null을 방지하기 위해 Integer 사용
		Integer count = 0;

		// votes_detail 테이블에 id가 입력되어 있는 상태면 1, 아니라면 0을 리턴받음
		count = info_Service.votesIdCheck(id);
		// JSP에 count라는 값으로 전달
		map.put("count", count);
		return map;
	}

	// 해시태그 검색 기능
	// @Override
	// @RequestMapping(value = "/info/tagsearch.do", method = { RequestMethod.GET,
	// RequestMethod.POST})
	// public ModelAndView tagsearch(@RequestParam("hash_tag") String hash_tag,
	// HttpServletRequest request, HttpServletResponse response) throws Exception {
	// HttpSession session = request.getSession();
	// String viewName = getViewName(request);
	// List<Info_VO> info_VO = info_Service.tagsearch(hash_tag);
	// ModelAndView mav = new ModelAndView(viewName);
	// mav.addObject("tagsearch", info_VO);
	// session.setAttribute("searchValue", hash_tag);
	// return mav;
	// }

	@Override
	@RequestMapping(value = "/info/recommendlist.do", method = { RequestMethod.GET, RequestMethod.POST })
	public ModelAndView recommendlist(@RequestParam("id") String id, HttpServletRequest request) throws Exception {
		String viewName = getViewName(request);
		List<Info_VO> recommendlist = info_Service.recommendlist(id);
		ModelAndView mav = new ModelAndView(viewName);
		List<Info_Image_VO> logolist = info_Service.logolist();
	    mav.addObject("logolist",logolist);
		System.out.println("추천 게임 : " + recommendlist);
		mav.addObject("recommendlist", recommendlist);
		return mav;
	}

	@Override
	@RequestMapping(value = "/info/popularlist.do", method = { RequestMethod.GET, RequestMethod.POST })
	public ModelAndView popularlist(@RequestParam("big_category") String big_category, HttpServletRequest request)
			throws Exception {
		String viewName = getViewName(request);
		ModelAndView mav = new ModelAndView(viewName);
		List<Info_VO> popularlist = info_Service.popularlist(big_category);
		mav.addObject("popularlist", popularlist);
		return mav;
	}

//  사진 다운로드
	@GetMapping(value = "/info/download.do")
	public void download(@RequestParam("imagefilename") String imagefilename,
			@RequestParam("game_code") String game_code, HttpServletResponse response) throws Exception {

		System.out.println("이미지 확인중: " + imagefilename);
		System.out.println("이미지 확인중: " + game_code);

		OutputStream out = response.getOutputStream();
		String path = IMAGE_REPO + "\\" + game_code + "\\" + imagefilename;
		File imageFile = new File(path);
		response.setHeader("Cache-Control", "no-cache");
		response.addHeader("Content-disposition", "attachment;fileName=" + imagefilename);
		FileInputStream in = new FileInputStream(imageFile);
		byte[] buffer = new byte[1024 * 8];
		while (true) {
			int count = in.read(buffer);
			if (count == -1)
				break;
			out.write(buffer, 0, count);
		}
		in.close();
		out.close();
	}

	// View 이름 가져오기
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