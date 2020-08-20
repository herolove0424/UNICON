package com.project.unicon.board.Controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.json.JSONArray;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.project.unicon.board.Service.Message_Service;
import com.project.unicon.board.Service.MyWall_Service;
import com.project.unicon.timeLine.service.TimeLine_Service;
import com.project.unicon.vo.Member_VO;
import com.project.unicon.vo.MyWall_Reply_VO;
import com.project.unicon.vo.MyWall_VO;
import com.project.unicon.vo.TimeLine_VO;

@Controller("MyWall_Controller")
public class MyWall_ControllerImpl implements MyWall_Controller {

	@Autowired
	private MyWall_Service wallService;
	
	@Autowired
	private TimeLine_Service timeLine_Service;
	
	@Autowired
	private Message_Service message_Service;

	@Autowired
	MyWall_VO vo;

	// 담벼락
	@RequestMapping(value = "/board/myWall.do")
	public String myWall(@RequestParam("id_2") String id_2,Model model, HttpServletRequest request) throws Exception {

		HttpSession session = request.getSession();
		Member_VO vo = (Member_VO) session.getAttribute("member");
		String session_id = vo.getId();
		
		System.out.println("여긴오냐?");
		List<MyWall_VO> myWallList = wallService.myWall(id_2);
		// 담벼락 사이드바에 친구리스트 던지기.
		List<TimeLine_VO> friendList = timeLine_Service.friendList(session_id);
		// 담벼락 사이드바에 친구 수 던지기.
		int friendCount = timeLine_Service.friendCount(session_id);
		
		//드롭박스 받은 친구 신청 수
		int countFriendAccept=timeLine_Service.countFriendAccept(session_id);
		
		//드롭박스 메세지 수
		int remainMessage = message_Service.countRemainMessage(session_id);
		
		//드롭박스 최상단 notice 알림 개수
		int dropboxNotice=countFriendAccept+remainMessage;
		
		model.addAttribute("myWallList", myWallList);
		System.out.println("myWallList가 비어있니~?" + myWallList.isEmpty());
		model.addAttribute("friendList", friendList);
		model.addAttribute("count", friendCount);
		model.addAttribute("MyID", session_id);
		model.addAttribute("WallID", id_2);
		model.addAttribute("countFriendAccept", countFriendAccept);
		model.addAttribute("remainMessage", remainMessage);
		model.addAttribute("dropboxNotice", dropboxNotice);

		return "/board/myWall";
	}
	
	// 담벼락 게시글 추가
	@GetMapping("/board/addWallArticle.do")
	@ResponseBody
	public ResponseEntity addWallArticle(HttpServletRequest request) throws Exception {
		
		request.setCharacterEncoding("utf-8");
		HttpSession session = request.getSession();
		Member_VO memberVO = (Member_VO)session.getAttribute("member");
		String id = memberVO.getId();
		
		String title = request.getParameter("title");
		String content = request.getParameter("content");
		
		System.out.println("지금 여기 까지 와줘  제발");
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("id", id);
		map.put("title", title);
		map.put("content", content);
		
		System.out.println("맵에 담았니?");
		
		String message;
		ResponseEntity resEnt = null;
		HttpHeaders responseHeaders = new HttpHeaders();
		responseHeaders.add("Content-Type", "text/html; charset=utf-8");
		
		wallService.addWallArticle(map);
		System.out.println("서비스 호출해서 기능 수행했니?");
		message = "<script>";
		message += " alert('새 글을 추가했습니다.');";
		message += " location.href='" + request.getContextPath() + "/board/myWall.do?id_2=" + id + "';";
		message += "</script>";
		
		resEnt = new ResponseEntity(message, responseHeaders, HttpStatus.CREATED);
		
		return resEnt;
	}
	
	// 담벼락 게시글 삭제
	@RequestMapping(value = "/board/removeArticle.do")
	@ResponseBody
	public String removeArticle(@RequestParam("boardNO") int boardNO)
			throws Exception {
		String result = "";
		wallService.removeArticle(boardNO);
		result = "success";
		return result;
	}
	
	// 담벼락 게시글 수정
	@RequestMapping(value="/board/updateWallArticle.do")
	@ResponseBody
	public String updateWallArticle(@RequestParam("boardNO") int boardNO , @RequestParam("content") String content) throws Exception {
		
		String result = "";
		
		MyWall_VO vo = new MyWall_VO();
		vo.setBoardNO(boardNO);
		vo.setContent(content);
		
		wallService.updateWallArticle(vo);
		result = "success";
		return result;
	}
	
	// 담벼락 댓글 리스트 가져오기
	@RequestMapping(value="board/getWallReplyList.do", method = { RequestMethod.GET, RequestMethod.POST })
	public ResponseEntity<Object> callWallReply(@RequestParam("rep_parentNO") int rep_parentNO) throws Exception {
		
		HttpHeaders responseHeaders = new HttpHeaders();
		ArrayList<HashMap<Object, Object>> hmList = new ArrayList<HashMap<Object, Object>>();
		
		List<MyWall_Reply_VO> replyLists = wallService.myWallReplyList(rep_parentNO);
		if (replyLists.size() > 0) {
			for (int i = 0; i < replyLists.size(); i++) {
				HashMap<Object, Object> hm = new HashMap<Object, Object>();

				hm.put("rep_content", replyLists.get(i).getRep_content());
				hm.put("rep_writeDate", replyLists.get(i).getRep_writeDate());
				hm.put("rep_id", replyLists.get(i).getRep_id());
				hm.put("rep_boardNO", replyLists.get(i).getRep_boardNO());

				hmList.add(hm);
			}
		}
		JSONArray json = new JSONArray(hmList);
		return new ResponseEntity<Object>(json.toString(), responseHeaders, HttpStatus.CREATED);
	}
	
	// 담벼락 댓글 삭제하기
	@GetMapping("/board/ajaxDelWallReply.do")
	@ResponseBody
	public String ajax_delWallReply(@RequestParam("rep_boardNO") int rep_boardNO) throws Exception {
		String result = "";
		wallService.removeWallReply(rep_boardNO);
		result = "success";

		return result;
	}
	
	// 담벼락 댓글 추가하기
	@GetMapping("/board/ajaxAddWallReply.do")
	@ResponseBody
	public String ajax_addWallReply(@RequestParam("rep_parentNO") int rep_parentNO,
			@RequestParam("rep_content") String rep_content,
			HttpServletRequest request) throws Exception {

		String result = "";

		Map<String, Object> map = new HashMap<String, Object>();

		HttpSession session = request.getSession();
		Member_VO memberVO = (Member_VO) session.getAttribute("member");
		String id = memberVO.getId();

		map.put("rep_id", id);
		map.put("rep_content", rep_content);
		map.put("rep_parentNO", rep_parentNO);
		
		wallService.insertWallReply(map);
		
		result = "success";

		return result;
	}
	
	// 댓글 수정하기
	@RequestMapping(value="/board/updateWallReply.do")
	@ResponseBody
	public String updateWallReply(@RequestParam("rep_content") String rep_content, 
							@RequestParam("rep_boardNO") int rep_boardNO,
							HttpServletRequest request) throws Exception {
		String result = "";
		
		MyWall_Reply_VO vo = new MyWall_Reply_VO();
		vo.setRep_boardNO(rep_boardNO);
		vo.setRep_content(rep_content);
		wallService.updateWallReply(vo);
		result = "success";
		
		return result;
	}
	
	// 새 글쓰기 폼
	@RequestMapping(value="/board/addWallArticleForm.do")
	public String addWallArticleForm(HttpServletRequest request, Model model) throws Exception {
		HttpSession session = request.getSession();
		Member_VO memberVO = (Member_VO) session.getAttribute("member");
		String id = memberVO.getId();
		
		// 담벼락 사이드바에 친구리스트 던지기.
	    List<TimeLine_VO> friendList = timeLine_Service.friendList(id);
	    // 담벼락 사이드바에 친구 수 던지기.
	    int friendCount = timeLine_Service.friendCount(id);
	      
	    model.addAttribute("friendList", friendList);
	    model.addAttribute("count", friendCount);
		
		model.addAttribute("addWallID", id);
		return "/board/addWallArticleForm";
	}

}
