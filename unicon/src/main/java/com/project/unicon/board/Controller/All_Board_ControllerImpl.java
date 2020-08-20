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
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.project.unicon.board.Service.All_Board_Service;
import com.project.unicon.board.Service.Message_Service;
import com.project.unicon.timeLine.service.TimeLine_Service;
import com.project.unicon.vo.All_Board_Reply_VO;
import com.project.unicon.vo.All_Board_VO;
import com.project.unicon.vo.Member_VO;
import com.project.unicon.vo.TimeLine_VO;

@Controller("All_Board_Controller")
public class All_Board_ControllerImpl implements All_Board_Controller {
	
	@Autowired
	private All_Board_Service allBoardService;
	
	@Autowired
	private TimeLine_Service timeLineService;
	
	@Autowired
	private Message_Service message_Service;
	
	@Autowired
	All_Board_VO allBoardVO;

	
	// 타임라인 이동.
	@RequestMapping(value="/board/timeLine.do", method= {RequestMethod.GET,RequestMethod.POST})
	public String timeLine(Model model, HttpServletRequest request) throws Exception {
		
		HttpSession session = request.getSession();
		Member_VO memberVO = (Member_VO)session.getAttribute("member");
		String id = memberVO.getId();
		
		List<All_Board_VO> timeLineList = allBoardService.timeLine(id);
		System.out.println("타임라인 리스트는 비어있니?" + timeLineList.isEmpty());
		// 타임라인 사이드바에 친구리스트 던지기.
		List<TimeLine_VO> friendList = timeLineService.friendList(id);
		// 타임라인 사이드바에 친구 수 던지기.
		int friendCount = timeLineService.friendCount(id);
		
		// 드롭박스 받은 친구 신청 수
		int countFriendAccept = timeLineService.countFriendAccept(id);

		// 드롭박스 메세지 수
		int remainMessage = message_Service.countRemainMessage(id);

		// 드롭박스 최상단 notice 알림 개수
		int dropboxNotice = countFriendAccept + remainMessage;
		
		model.addAttribute("timeLineList", timeLineList);
		model.addAttribute("friendList", friendList);
		model.addAttribute("count", friendCount);
		session.setAttribute("countFriendAccept", countFriendAccept);
		session.setAttribute("remainMessage", remainMessage);
		session.setAttribute("dropboxNotice", dropboxNotice);
		session.setAttribute("session_id", id);
		
		return "/board/timeLine3";
	}
	
	//0813도갱추가
		@GetMapping("/board/friendRequest.do")
		@Override
		public String friendRequest (Model model, HttpServletRequest request) throws Exception{
			HttpSession session = request.getSession();
			Member_VO memberVO = (Member_VO)session.getAttribute("member");
			String id = memberVO.getId();
			
			// 타임라인 사이드바에 친구리스트 던지기.
			List<TimeLine_VO> friendList = timeLineService.friendList(id);
			// 타임라인 사이드바에 친구 수 던지기.
			int friendCount = timeLineService.friendCount(id);

			//내가 친구 신청한 리스트
			List<TimeLine_VO> friendRequestList = timeLineService.friendRequestList(id);
			
			//내가 받은 친구 요청
			List<TimeLine_VO> friendAcceptList = timeLineService.friendAcceptList(id);
			
			model.addAttribute("friendList", friendList);
			model.addAttribute("count", friendCount);
			model.addAttribute("friendRequestList", friendRequestList);
			model.addAttribute("friendAcceptList", friendAcceptList);
			
			return "board/friendRequestList";
		}
	
	// 댓글 리스트
	@RequestMapping(value="board/getReplyList.do", method = { RequestMethod.GET, RequestMethod.POST })
	public ResponseEntity<Object> callReply(@RequestParam("rep_parentNO") int rep_parentNO,
			@RequestParam("status") int status) throws Exception {
		
		HttpHeaders responseHeaders = new HttpHeaders();
		ArrayList<HashMap<Object, Object>> hmList = new ArrayList<HashMap<Object, Object>>();
		
		List<All_Board_Reply_VO> replyLists = allBoardService.callReply(rep_parentNO, status);
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
	
	// 댓글 삭제하기
	@GetMapping("/board/ajaxDelReply.do")
	@ResponseBody
	public String ajax_delReply(@RequestParam("rep_boardNO") int rep_boardNO,
			@RequestParam("status") int status) throws Exception {
		String result = "";

		allBoardService.removeReply(rep_boardNO, status);
		result = "success";

		return result;
	}
	
	// 댓글 추가하기
	@GetMapping("/board/ajaxAddReply.do")
	@ResponseBody
	public String ajax_addReply(@RequestParam("rep_parentNO") int rep_parentNO,
			@RequestParam("rep_content") String rep_content,
			@RequestParam("status") int status, HttpServletRequest request) throws Exception {

		String result = "";

		Map<String, Object> map = new HashMap<String, Object>();

		HttpSession session = request.getSession();
		Member_VO memberVO = (Member_VO) session.getAttribute("member");
		String id = memberVO.getId();

		map.put("rep_id", id);
		map.put("rep_content", rep_content);
		map.put("rep_parentNO", rep_parentNO);
		
		allBoardService.timeLineInsertReply(map, status);
		
		result = "success";

		return result;
	}
	
	// 댓글 수정하기
	@RequestMapping(value="/board/timeLineUpdateReply.do")
	@ResponseBody
	public String timeLineUpdateReply(@RequestParam("rep_content") String rep_content, @RequestParam("rep_boardNO") int rep_boardNO,
							@RequestParam("status") int status,HttpServletRequest request) throws Exception {
		//int rep_boardNO = Integer.parseInt(request.getParameter("rep_boardNO"));
		//String rep_content = request.getParameter("rep_content");
		//int status = Integer.parseInt(request.getParameter("status"));
		
		String result = "";
		
		All_Board_Reply_VO vo = new All_Board_Reply_VO();
		vo.setRep_boardNO(rep_boardNO);
		vo.setRep_content(rep_content);
		allBoardService.timeLineUpdateReply(vo, status);
		result = "success";
		
		return result;
	}
	// 도경추가
	@PostMapping(value="/board/getSessionId.do")
	@ResponseBody
	public String getSessionId(HttpServletRequest request) throws Exception {
		//int rep_boardNO = Integer.parseInt(request.getParameter("rep_boardNO"));
		//String rep_content = request.getParameter("rep_content");
		//int status = Integer.parseInt(request.getParameter("status"));
		HttpSession session = request.getSession();
		String myID="";
		try {
			myID=(String) session.getAttribute("memberforBoard");
		} catch (Exception e) {
			
		}
		System.out.println("session아이디를 확인합니다."+myID);
		return myID;
	}
	
	
//  메인 페이지 인기 게시글 불러오기
  @RequestMapping(value = "/board/pc_board.do")
  public ModelAndView pc_board(HttpServletRequest request) throws Exception {
     String viewName = getViewName(request);
     ModelAndView mav = new ModelAndView(viewName);
     List<All_Board_VO> pclist = allBoardService.pc_board();
     mav.addObject("pclist",pclist);
     return mav;
  }
  
  @RequestMapping(value = "/board/mobile_board.do")
  public ModelAndView mobile_board(HttpServletRequest request) throws Exception {
     String viewName = getViewName(request);
     ModelAndView mav = new ModelAndView(viewName);
     List<All_Board_VO> mobilelist = allBoardService.mobile_board();
     mav.addObject("mobilelist",mobilelist);
     return mav;
  }
  
  @RequestMapping(value = "/board/console_board.do")
  public ModelAndView console_board(HttpServletRequest request) throws Exception {
     String viewName = getViewName(request);
     ModelAndView mav = new ModelAndView(viewName);
     List<All_Board_VO> consolelist = allBoardService.console_board();
     mav.addObject("consolelist",consolelist);
     return mav;
  }
  
  @RequestMapping(value = "/board/free_board.do")
  public ModelAndView free_board(HttpServletRequest request) throws Exception {
     String viewName = getViewName(request);
     ModelAndView mav = new ModelAndView(viewName);
     List<All_Board_VO> freelist = allBoardService.free_board();
     mav.addObject("freelist",freelist);
     return mav;
  }
  
  //   View 이름 가져오기
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
