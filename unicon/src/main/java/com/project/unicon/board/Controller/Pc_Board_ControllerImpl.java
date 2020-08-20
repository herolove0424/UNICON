package com.project.unicon.board.Controller;

import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.util.Enumeration;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.io.FileUtils;
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
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;

import com.google.gson.JsonObject;
import com.project.unicon.board.Service.Pc_Board_Service;
import com.project.unicon.management.service.Management_Notice_Service;
import com.project.unicon.vo.Admin_Notice_VO;
import com.project.unicon.vo.Member_VO;
import com.project.unicon.vo.Pc_Board_Reply_VO;
import com.project.unicon.vo.Pc_Board_VO;

import common.paging.PagingCreatorDTO;
import common.paging.PagingDTO;

@Controller("Pc_Board_Comtroller")
public class Pc_Board_ControllerImpl implements Pc_Board_Controller {
	
	private static final String PC_BOARD_IMAGE_REPO = "C:\\summernote\\summernote_image";
	
	@Autowired
	private Pc_Board_Service boardService;
	@Autowired
	Pc_Board_VO boardVO;
	
	@Autowired
	Admin_Notice_VO admin_Notice_VO;
	
	
	//민우꺼에 공지사항 출력 추가
	
	@RequestMapping(value="/board/mainBoard.do")
	public String mainBoard() throws Exception {
		return "/board/mainBoard";
	}
	
	//PC_게시판 리스트 (페이징 완성덜됨)(0806김도경 수정)
	@Override
	@RequestMapping(value = "/board/Pc_Board_AllList.do", method =  {RequestMethod.GET,RequestMethod.POST})
	public String Pc_Board_AllList(PagingDTO pagingDTO, Model model) throws Exception {
		
		List<Pc_Board_VO> boardList = boardService.Pc_Board_List(pagingDTO);
		model.addAttribute("boardList",boardList);
		
		int searchedTotalBoardsCnt = boardService.getTotalRecordCnt(pagingDTO);
		
		model.addAttribute("pagingCreatorDTO", new PagingCreatorDTO(pagingDTO, searchedTotalBoardsCnt));
		
		//도경 추가
		List<Admin_Notice_VO> noticeList = boardService.exposalNotice();
		model.addAttribute("noticeList", noticeList);
		model.addAttribute("status", 3);
		
		return "/board/Pc_Board_AllList";
	}
	//(0806김도경 추가)
	@Override
	@GetMapping("/board/noticeView.do")
	public String noticeView(@RequestParam("boardno") int boardno,@RequestParam("status") int status,Model model) throws Exception{
		boardService.noticeViewCount(boardno);
		Admin_Notice_VO noticeView = boardService.detailNotice(boardno);
		model.addAttribute("noticeView", noticeView);
		model.addAttribute("status", status);
		
		return "/board/AllNoticeView";
	}
	
	
	//새 글쓰기
	@Override
	@RequestMapping(value="/board/addArticle.do", method= {RequestMethod.GET,RequestMethod.POST})
	@ResponseBody
	public ResponseEntity addArticle(MultipartHttpServletRequest multipartRequest, HttpServletResponse response)
			throws Exception {
		
		multipartRequest.setCharacterEncoding("utf-8");
		Map<String, Object> articleMap = new HashMap<String, Object>();
		Enumeration enu = multipartRequest.getParameterNames();
		while(enu.hasMoreElements()) {
			String name = (String)enu.nextElement();
			String value = multipartRequest.getParameter(name);
			articleMap.put(name, value);
		}
		HttpSession session = multipartRequest.getSession();
		Member_VO memberVO = (Member_VO) session.getAttribute("member");
		String id = memberVO.getId();
		String title = (String) articleMap.get("title");
		System.out.println(title);
		String content = (String) articleMap.get("content");
		System.out.println(content);
		
		articleMap.put("id", id);
		articleMap.put("title", title);
		articleMap.put("content", content);
		
		// message 는 밑에 스크립트 알림창과 location.href를 위해서 씀!
		String message;
		ResponseEntity resEnt = null;
		HttpHeaders responseHeaders = new HttpHeaders();
		responseHeaders.add("Content-Type", "text/html; charset=utf-8");
		
		try {
			int boardNO = boardService.addBoard(articleMap);
			message = "<script>";
			message += " alert('새 글을 추가했습니다.');";
			message += " location.href='" + multipartRequest.getContextPath() + "/board/Pc_Board_AllList.do'; ";
			message += "</script>";
			
			resEnt = new ResponseEntity(message, responseHeaders, HttpStatus.CREATED);
			
		} catch(Exception e) {

			message = "<script>";
			message += " alert('오류가 발생했습니다. 다시 시도해 주세요');";
			message += " location.href='" + multipartRequest.getContextPath() + "/board/articleForm2.do'; ";
			message += "</script>";

			resEnt = new ResponseEntity(message, responseHeaders, HttpStatus.CREATED);
			e.printStackTrace();
		}
		return resEnt;
	}
	//상세보기
	@Override
	//@RequestMapping(value = "/board/viewArticle.do", method = RequestMethod.GET)
	@RequestMapping(value = "/board/viewArticle2.do", method = {RequestMethod.GET,RequestMethod.POST})
	public String viewArticle(@RequestParam("boardNO") int boardNO, Model model, HttpServletRequest request)
			throws Exception {
		
		try {
			boardService.viewCount(boardNO);
			model.addAttribute("board", boardService.viewArticle(boardNO));

			List<Pc_Board_Reply_VO> replyList = boardService.Pc_Board_Reply_List(boardNO);
			model.addAttribute("replyList", replyList);
			System.out.println("replyList리스트가 비어있니?   : " + replyList.isEmpty());

			model.addAttribute("boardNO", boardNO);
			System.out.println("가져올 부모글번호(상세보기의 해당 글번호) : " + boardNO);

			// 세션에 로그인한 아이디 바인딩해서 댓글에 작성자와 비교하고 같으면 수정 삭제 해야함!
			HttpSession session = request.getSession();
			Member_VO memVO = (Member_VO) session.getAttribute("member");

			model.addAttribute("session_id", memVO.getId());
			System.out.println("세션의 아이디 : " + memVO.getId());

		} catch (Exception e) {
			model.addAttribute("session_id", "");
		}
		return "/board/viewArticle2";
	}
	
	
	//글 수정
	@Override
	@GetMapping("/board/modArticle1.do")
	public String modArticle(@RequestParam("boardNO")int boardNO, Model model) throws Exception {
		model.addAttribute("board", boardService.viewArticle(boardNO));
		return "/board/modArticle";
	}
	
	@PostMapping("/board/modArticle2.do")
	public String modArticle(Pc_Board_VO vo) throws Exception {
		boardService.modArticle(vo);
		return "redirect: /unicon/board/viewArticle2.do?boardNO=" + vo.getBoardNO();
	}
	
	
	//글 삭제
	@Override
	@RequestMapping(value = "/board/deleteArticle.do", method = {RequestMethod.POST, RequestMethod.GET})
	public String deleteArticle(@RequestParam("boardNO") int boardNO) throws Exception {
		boardService.deleteArticle(boardNO);
		return "redirect: /unicon/board/Pc_Board_AllList.do";
	}
	
	
	//댓글 쓰기
	@Override
	@RequestMapping(value="/board/addReply.do", method= {RequestMethod.POST})
	public ResponseEntity addReply(@RequestParam("rep_parentNO") int rep_parentNO,HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		
		request.setCharacterEncoding("utf-8");
		Map<String, Object> articleMap = new HashMap<String, Object>();
		Enumeration enu = request.getParameterNames();
		while(enu.hasMoreElements()) {
			String name = (String)enu.nextElement();
			String value = request.getParameter(name);
			articleMap.put(name, value);
			System.out.println("이름 : " + name);
			System.out.println("값 : " + value);
		}
		HttpSession session = request.getSession();
		Member_VO memberVO = (Member_VO) session.getAttribute("member");
		String id = memberVO.getId();
		articleMap.put("rep_id", id);
		articleMap.put("rep_parentNO", rep_parentNO);
		
		// message 는 밑에 스크립트 알림창과 location.href를 위해서 씀!
		String message;
		ResponseEntity resEnt = null;
		HttpHeaders responseHeaders = new HttpHeaders();
		responseHeaders.add("Content-Type", "text/html; charset=utf-8");
		
		try {
			String daedatNO = request.getParameter("daedatNO"); 
			if(daedatNO != null) {
				articleMap.put("daedatNO", Integer.parseInt(daedatNO));
			} else {
				System.out.println("daedatNO가 널이래");
			}
			boardService.insertReply(articleMap);
			
			message = "<script>";
			message += " location.href='" + request.getContextPath() + "/board/viewArticle2.do?boardNO=" + rep_parentNO + "'; ";
			message += "</script>";
			
			resEnt = new ResponseEntity(message, responseHeaders, HttpStatus.CREATED);
			
		} catch(Exception e) {

			message = "<script>";
			message += " alert('오류가 발생했습니다. 다시 시도해 주세요');";
			message += " location.href='" + request.getContextPath() + "/board/viewArticle2.do?boardNO=" + rep_parentNO + "'; ";
			message += "</script>";

			resEnt = new ResponseEntity(message, responseHeaders, HttpStatus.CREATED);
			e.printStackTrace();
		}
		return resEnt;
	}
	
	// 댓글 삭제
	@Override
	@RequestMapping(value = "/board/deleteReply.do", method = { RequestMethod.POST, RequestMethod.GET })
	public String deleteReply(@RequestParam("rep_boardNO") int rep_boardNO,
			@RequestParam("rep_parentNO") int rep_parentNO) throws Exception {
		int viewNO = rep_parentNO;
		System.out.println("댓글의 글번호를 받아왔닝...?" + rep_boardNO);
		boardService.deleteReply(rep_boardNO);
		return "redirect: /unicon/board/viewArticle2.do?boardNO=" + viewNO;
	}

	//댓글 수정
	@Override
	@RequestMapping(value="/board/updateReply.do", method= {RequestMethod.POST,RequestMethod.GET} )
	public String updateReply(HttpServletRequest request) throws Exception {
		String rep_content = request.getParameter("rep_content");
		int rep_boardNO = Integer.parseInt(request.getParameter("rep_boardNO"));
		String rep_parentNO = request.getParameter("rep_parentNO");
		
		System.out.println("댓글 수정할 때 가져오는 값들----");
		System.out.println("수정할 댓글 번호" + rep_boardNO);
		System.out.println("수정된 댓글 내용" + rep_content);
		System.out.println("상세보기로 이동할 부모글 번호" + rep_parentNO);
		Pc_Board_Reply_VO vo  = new Pc_Board_Reply_VO();
		vo.setRep_boardNO(rep_boardNO);
		vo.setRep_content(rep_content);
		boardService.updateReply(vo);
		return "redirect: /unicon/board/viewArticle2.do?boardNO=" + rep_parentNO;
	}
	
	//새 글 쓰기폼.
	@RequestMapping(value = "/board/articleForm2.do", method = RequestMethod.GET)
	public ModelAndView form(HttpServletRequest request, HttpServletResponse response) throws Exception { // String
		String viewName = (String) request.getAttribute("viewName");
		ModelAndView mav = new ModelAndView();
		mav.setViewName(viewName);
		return mav;
	}
	
	@PostMapping(value="/uploadSummernoteImageFile", produces = "application/json")
	@Override
	@ResponseBody
	public JsonObject uploadSummernoteImageFile(@RequestParam("file") MultipartFile multipartFile) {
		System.out.println("여기 들어오긴하니?");
		JsonObject jsonObject = new JsonObject();
		
		String fileRoot = "C:\\summernote\\summernote_image\\";	//저장될 외부 파일 경로
		String originalFileName = multipartFile.getOriginalFilename();	//오리지날 파일명
		System.out.println("오리지날 파일네임" + originalFileName);
		String extension = originalFileName.substring(originalFileName.lastIndexOf("."));	//파일 확장자
				
		String savedFileName = UUID.randomUUID() + extension;	//저장될 파일 명
		
		File targetFile = new File(fileRoot + savedFileName);	
		
		try {
			InputStream fileStream = multipartFile.getInputStream();
			FileUtils.copyInputStreamToFile(fileStream, targetFile);	//파일 저장
			jsonObject.addProperty("url", "/summernoteImage/"+savedFileName);
			jsonObject.addProperty("responseCode", "success");
				
		} catch (IOException e) {
			FileUtils.deleteQuietly(targetFile);	//저장된 파일 삭제
			jsonObject.addProperty("responseCode", "error");
			e.printStackTrace();
		}
		
		return jsonObject;
	}
	
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

		String viewName = uri.substring(begin, end);
		if (viewName.indexOf(".") != -1) {
			viewName = viewName.substring(0, viewName.lastIndexOf("."));
		}
		if (viewName.lastIndexOf("/") != -1) {
			viewName = viewName.substring(viewName.lastIndexOf("/", 1), viewName.length());
		}
		return viewName;
	}

	
	
}
