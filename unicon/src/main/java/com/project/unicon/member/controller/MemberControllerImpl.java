package com.project.unicon.member.controller;

import java.io.File;
import java.text.DateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Locale;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.io.FileUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpHeaders;
import org.springframework.http.ResponseEntity;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.project.unicon.board.Service.Message_Service;
import com.project.unicon.member.service.MemberService;
import com.project.unicon.vo.Console_Board_VO;
import com.project.unicon.vo.Free_Board_VO;
import com.project.unicon.vo.Jjim_VO;
import com.project.unicon.vo.Member_VO;
import com.project.unicon.vo.Mobile_Board_VO;
import com.project.unicon.vo.Pc_Board_VO;

@Controller("memberController")
@RequestMapping(value = "/member")
public class MemberControllerImpl implements MemberController {
	private static final String Member_IMAGE_USER = "C:\\myjava\\GmUnicon\\unicon\\src\\main\\webapp\\resources\\memberimage";
	private static final String Member_IMAGE_TEMP = "C:\\myjava\\GmUnicon\\unicon\\src\\main\\webapp\\resources\\memberimage\\temp";

	@Autowired
	private MemberService memberService;
	
	@Autowired
	private Message_Service message_Service;

	@Autowired
	Member_VO memberVO;

	// 이메일 인증
	@Autowired
	private JavaMailSender mailSender;

	// 로그인하고 받아서 메인으로가는 메소드
	@Override
	@RequestMapping(value = "/main.do", method = RequestMethod.GET)
	public String main(Locale locale, Model model,HttpServletRequest request) throws Exception {
		Date date = new Date();
		DateFormat dateFormat = DateFormat.getDateTimeInstance(DateFormat.LONG, DateFormat.LONG, locale);

		String formattedDate = dateFormat.format(date);
		
		HttpSession session=request.getSession();
		String id=(String) session.getAttribute("memberforBoard");
		int remainMessage = message_Service.countRemainMessage(id);

		model.addAttribute("serverTime", formattedDate);
		model.addAttribute("remainMessage", remainMessage);
		//0807 쪽지 기능으로 인한 추가


		return "/member/main";
	}

	// 로그인 하는 메소드
	@Override
	@RequestMapping(value = "/login.do", method = { RequestMethod.GET, RequestMethod.POST })
	public ModelAndView login(@ModelAttribute("loginById") Member_VO member, RedirectAttributes redirect_rAttr,
			HttpServletRequest request, HttpServletResponse response) throws Exception {
		ModelAndView mav = new ModelAndView();
		HttpSession session = request.getSession();
		
		String id = member.getId();
		Integer count = memberService.email_check(id);		
		
		memberVO = memberService.login(member);
		System.out.println(memberVO);
		if (memberVO != null) {
			if(count == 1) {
				String hp = memberService.gethp(member.getId());
				memberVO.setPhone_number(hp);
				session.setAttribute("member", memberVO);
				session.setAttribute("isLogOn", true);
				
				//쪽지로 인한추가 지우지 말기 ㅡㅡ
				session.setAttribute("memberforBoard", memberVO.getId());
				session.setAttribute("isLogOn", true);
	
				String action = (String) session.getAttribute("action");
				System.out.println("action" + action);
				session.removeAttribute("action");
				mav.setViewName("redirect:/main.do");
			}
			else {
				redirect_rAttr.addAttribute("isLogOn", "email_check");
				mav.setViewName("redirect:/member/email.do");
				mav.addObject("id", id);
			}
		} else {
			redirect_rAttr.addAttribute("isLogOn", false);
			mav.setViewName("redirect:/member/loginForm.do");
		}
		return mav;
	}

	// 로그아웃 메소드
	@Override
	@RequestMapping(value = "/logout.do", method = { RequestMethod.GET, RequestMethod.POST })
	public ModelAndView logout(HttpServletRequest request, HttpServletResponse sponse) throws Exception {
		HttpSession session = request.getSession();
		session.removeAttribute("member");
		session.removeAttribute("isLogOn");
		//쪽지로 인한 추가
		session.removeAttribute("memberforBoard");
		ModelAndView mav = new ModelAndView();
		mav.setViewName("redirect:/main.do");
		return mav;
	}

	@Override
	@RequestMapping(value = "/loginForm.do", method = RequestMethod.GET)
	public String loginform(HttpServletRequest request) throws Exception {

		return "/member/loginForm";
	}

	@Override
	@RequestMapping(value = "/memForm.do", method = RequestMethod.GET)
	public String memberform(HttpServletRequest request) throws Exception {

		return "/member/memForm";
	}

	// 회원가입
	@Override
	@RequestMapping(value = "/addMember.do", method = { RequestMethod.GET, RequestMethod.POST })
	public ModelAndView addMember(@ModelAttribute("member") Member_VO member, HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		System.out.println("member : " + member);

		String id = request.getParameter("id");
		member.setId(id);

		String email = request.getParameter("email");
		member.setEmail(email);

		String phone_number = request.getParameter("phone");
		phone_number = phone_number.replace("-", "");
		member.setPhone_number(phone_number);

		String play_type = request.getParameter("play_type");

		if (play_type != null) {
			member.setPlay_type(play_type);

			String small_category = request.getParameter("small_category");
			member.setSmall_category(small_category);

			String[] genre = request.getParameterValues("genre");
			if (genre.length == 1) {
				member.setGenre1(genre[0]);
				member.setGenre2(null);
			} else if (genre.length == 2) {
				member.setGenre1(genre[0]);
				member.setGenre2(genre[1]);
			}

			String[] hash_tag = request.getParameterValues("hash_tag");
			if (hash_tag.length == 1) {
				member.setHashtag1(hash_tag[0]);
				member.setHashtag2(null);
				member.setHashtag3(null);
			} else if (hash_tag.length == 2) {
				member.setHashtag1(hash_tag[0]);
				member.setHashtag2(hash_tag[1]);
				member.setHashtag3(null);
			} else if (hash_tag.length == 3) {
				member.setHashtag1(hash_tag[0]);
				member.setHashtag2(hash_tag[1]);
				member.setHashtag3(hash_tag[2]);
			}
		}
		memberService.addMember(member);
		memberService.recommendinsert(member);
		memberService.mailsendkey(email, id, request);

		ModelAndView mav = new ModelAndView("member/loginForm");
		mav.addObject("result", "addMem");

		return mav;
	}

	// 아이디 중복체크
	@Override
	@RequestMapping(value = "/overlapped.do", method = { RequestMethod.GET, RequestMethod.POST })
	public @ResponseBody String overlapped(@ModelAttribute("vo") Member_VO member, Model model) throws Exception {
		System.out.println("id:" + member.getId());
		int result = memberService.overlapped(member.getId());
		System.out.println("result: " + result);
		return String.valueOf(result);
	}

	// 닉네임 중복체크
	@Override
	@RequestMapping(value = "/overlappednick.do", method = { RequestMethod.GET, RequestMethod.POST })
	public @ResponseBody String overlappednick(@ModelAttribute("vo") Member_VO member, Model model) throws Exception {
		System.out.println("nickname:" + member.getNickname());
		int result = memberService.overlappednick(member.getNickname());
		System.out.println("result: " + result);
		return String.valueOf(result);
	}

	// 이메일 중복체크
	@Override
	@RequestMapping(value = "/overlappedemail.do", method = { RequestMethod.GET, RequestMethod.POST })
	public @ResponseBody String overlappedemail(@ModelAttribute("vo") Member_VO member, Model model) throws Exception {
		System.out.println("email:" + member.getEmail());
		int result = memberService.overlappedemail(member.getEmail());
		System.out.println("result: " + result);
		return String.valueOf(result);
	}

	// 전화번호 중복체크
	@Override
	@RequestMapping(value = "/overlappedphone.do", method = { RequestMethod.GET, RequestMethod.POST })
	public @ResponseBody String overlappedphone(@ModelAttribute("vo") Member_VO member, Model model) throws Exception {
		System.out.println("phone_number:" + member.getPhone_number());
		int result = memberService.overlappedphone(member.getPhone_number());
		System.out.println("result: " + result);
		return String.valueOf(result);
	}

	// 아이디찾기
	@Override
	@RequestMapping(value = "/idfind.do", method = { RequestMethod.GET, RequestMethod.POST })
	public ModelAndView findid(@ModelAttribute("member") Member_VO member, HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		String id = memberService.findid(member);
		ModelAndView mav = new ModelAndView();

		if (id != null) {
			mav.setViewName("redirect:/member/loginForm.do");
			mav.addObject("id", id);
		} else {
			mav.setViewName("redirect:/member/idfindForm.do");
			mav.addObject("result", "notfindid");
		}
		return mav;
	}

	@Override
	@RequestMapping(value = "/idfindForm.do", method = RequestMethod.GET)
	public String idfindform(HttpServletRequest request) throws Exception {

		return "/member/idfindForm";
	}

	// 비밀번호 찾기
	@Override
	@RequestMapping(value = "/pwfind.do", method = { RequestMethod.GET, RequestMethod.POST })
	public ModelAndView findpw(@ModelAttribute("member") Member_VO member, HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		String id = memberService.findpw(member);
		ModelAndView mav = new ModelAndView();

		if (id != null) {
			// mav.setViewName("redirect:/member/pwfind2.do");
			mav.setViewName("/member/pwfindResult");
			mav.addObject("id", id);
		} else {
			mav.setViewName("redirect:/member/pwfindForm.do");
			mav.addObject("result", "notfindid");
		}
		return mav;
	}

	@Override
	@RequestMapping(value = "/pwfindForm.do", method = RequestMethod.GET)
	public String pwfindform(HttpServletRequest request) throws Exception {

		return "/member/pwfindForm";
	}

	// 새비밀번호 입력
	@Override
	@RequestMapping(value = "/pwfind2.do", method = { RequestMethod.GET, RequestMethod.POST })
	public ModelAndView pwfind2(HttpServletRequest request, HttpServletResponse response) throws Exception {
		String id = request.getParameter("id");
		String pw = request.getParameter("password");
		Member_VO Member_VO = new Member_VO();
		Member_VO.setId(id);
		Member_VO.setPassword(pw);
		memberService.pwfind2(Member_VO);
		ModelAndView mav = new ModelAndView("/member/pwfindFinally");
		return mav;
	}

	// 마이페이지 가기전 비밀번호 확인
	@Override
	@RequestMapping(value = "/mypagepw.do", method = { RequestMethod.GET, RequestMethod.POST })
	public ModelAndView mypagepw(@ModelAttribute("loginById") Member_VO member, HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		HttpSession session = request.getSession();
		Member_VO Member_VO = (Member_VO) session.getAttribute("member");
		member.setId(Member_VO.getId());
		member.setEmail(Member_VO.getEmail());
		String pw = memberService.mypagepw(member);
		System.out.println(pw);
		ModelAndView mav = new ModelAndView();
		if (pw != null) {
			mav.setViewName("/member/mypage");

		} else {
			mav.setViewName("redirect:/member/mypagepwForm.do");
			mav.addObject("result", "notfindid");
		}
		return mav;
	}

	@Override
	@RequestMapping(value = "/mypagepwForm.do", method = RequestMethod.GET)
	public String mypagepwform(HttpServletRequest request) throws Exception {

		return "/member/mypagepw";
	}

	@Override
	@RequestMapping(value = "/mypage.do", method = RequestMethod.GET)
	public ModelAndView mypageform(HttpServletRequest request) throws Exception {
		HttpSession session = request.getSession();
		session.setAttribute("isLogOn", "true");
		ModelAndView mav = new ModelAndView("/member/mypage");
		return mav;
	}

	@Override
	@RequestMapping(value = "/modifyForm.do", method = RequestMethod.GET)
	public ModelAndView modifyform(@ModelAttribute("modifyForm") Member_VO member, HttpServletRequest request)
			throws Exception {
		HttpSession session = request.getSession();
		Member_VO Member_VO = (Member_VO) session.getAttribute("member");
		member.setNickname(Member_VO.getNickname());
		String nickname = member.getNickname();
		member.setEmail(Member_VO.getEmail());
		String email = member.getEmail();
		member.setPhone_number(Member_VO.getPhone_number());
		String phone = member.getPhone_number();
		ModelAndView mav = new ModelAndView("/member/modify");
		mav.addObject("email5", email);
		mav.addObject("phone5", phone);
		mav.addObject("nickname5", nickname);
		return mav;
	}

	@Override
	@RequestMapping(value = "/pwmodifyForm.do", method = RequestMethod.GET)
	public String pwmodifyform(HttpServletRequest request) throws Exception {
		return "/member/pwmodify";
	}

	// 마이페이지에서 비밀번호 변경 입력
	@Override
	@RequestMapping(value = "/pwmodify.do", method = { RequestMethod.GET, RequestMethod.POST })
	public ModelAndView pwmodify(@ModelAttribute("member") Member_VO member, HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		HttpSession session = request.getSession();
		Member_VO member_VO = (Member_VO) session.getAttribute("member");
		member.setId(member_VO.getId());
		String id = member.getId();
		System.out.println("아이디좀찾아줘" + id);
		String pw = request.getParameter("password");
		Member_VO member_vo = new Member_VO();
		member_vo.setId(id);
		member_vo.setPassword(pw);
		member.setId(member_VO.getId());
		member.setName(member_VO.getName());
		member.setBirthday(member_VO.getBirthday());
		member.setEmail(member_VO.getEmail());
		member.setPhone_number(member_VO.getPhone_number());
		member.setNickname(member_VO.getNickname());
		member.setSex(member_VO.getSex());
		member.setSmall_category(member_VO.getSmall_category());
		member.setGenre1(member_VO.getGenre1());
		member.setGenre2(member_VO.getGenre2());
		member.setHashtag1(member_VO.getHashtag1());
		member.setHashtag2(member_VO.getHashtag2());
		member.setHashtag3(member_VO.getHashtag3());
		member.setPlay_type(member_VO.getPlay_type());
		member.setImageFileName(member_VO.getImageFileName());
		System.out.println(member_VO.getPhone_number());
		System.out.println(member_VO.getPlay_type());
		memberService.pwmodify(member_vo);
		ModelAndView mav = new ModelAndView("/member/mypage");
		mav.addObject("result", "mod2");
		return mav;
	}

	// test
	@RequestMapping(value = "/modima2test.do", method = { RequestMethod.POST, RequestMethod.GET })
	public void modimatest(Member_VO modmember, HttpServletRequest request,
			MultipartHttpServletRequest multipartRequest, HttpServletResponse response) throws Exception {
		System.out.println("확인룰루:" + modmember.getNickname());
	}

	// 마이페이지 수정
	@Override
	@RequestMapping(value = "/modima2.do", method = { RequestMethod.POST, RequestMethod.GET })
	public ModelAndView modima(@ModelAttribute("modmembervalue") Member_VO modmember, HttpServletRequest request,
			MultipartHttpServletRequest multipartRequest, HttpServletResponse response) throws Exception {
		multipartRequest.setCharacterEncoding("utf-8");
		HttpSession session = request.getSession();
		Member_VO sessmember = (Member_VO) session.getAttribute("member");
		System.out.println("확인룰루:" + modmember.getId());
		System.out.println("확인룰루:" + modmember.getNickname());

		String originalFileName = modmember.getOriginalFileName();

		System.out.println("email값" + modmember.getEmail());

		System.out.println("setPhone_number:" + modmember.getPhone_number());

		String imageFileName = upload(multipartRequest);

		String message = null;
		ResponseEntity<Object> resEnt = null;
		HttpHeaders responseHeaders = new HttpHeaders();
		responseHeaders.add("Content-Type", "text/html; charset=utf-8");

		String play_type = modmember.getPlay_type();
		System.out.println(play_type);
		if (play_type != null) {
			memberVO.setPlay_type(play_type);

			String small_category = modmember.getSmall_category();
			memberVO.setSmall_category(small_category);

			String[] genre = modmember.getGenre();
			if (genre.length == 1) {
				memberVO.setGenre1(genre[0]);
				memberVO.setGenre2(null);
			} else if (genre.length == 2) {
				memberVO.setGenre1(genre[0]);
				memberVO.setGenre2(genre[1]);
			}

			String[] Hashtag = modmember.getHash_tag();
			if (Hashtag.length == 1) {
				memberVO.setHashtag1(Hashtag[0]);
				memberVO.setHashtag2(null);
				memberVO.setHashtag3(null);
			} else if (Hashtag.length == 2) {
				memberVO.setHashtag1(Hashtag[0]);
				memberVO.setHashtag2(Hashtag[1]);
				memberVO.setHashtag3(null);
			} else if (Hashtag.length == 3) {
				memberVO.setHashtag1(Hashtag[0]);
				memberVO.setHashtag2(Hashtag[1]);
				memberVO.setHashtag3(Hashtag[2]);
			}
		} else {

			memberVO.setHashtag1(sessmember.getHashtag1());
			memberVO.setHashtag2(sessmember.getHashtag2());
			memberVO.setHashtag3(sessmember.getHashtag3());

			memberVO.setGenre1(sessmember.getGenre1());
			memberVO.setGenre2(sessmember.getGenre2());

			memberVO.setSmall_category(sessmember.getSmall_category());
			memberVO.setPlay_type(sessmember.getPlay_type());

		}

		System.out.println("image" + imageFileName);
		System.out.println("original" + originalFileName);
		if (imageFileName != null && imageFileName.length() != 0) {
			File srcFile = new File(Member_IMAGE_TEMP + "\\" + imageFileName);
			File destDir = new File(Member_IMAGE_USER + "\\" + modmember.getId());
			FileUtils.moveFileToDirectory(srcFile, destDir, true);
			modmember.setImageFileName(imageFileName);

			if (originalFileName != null || originalFileName != "") {
				File oldFile = new File(Member_IMAGE_USER + "\\" + modmember.getId() + "\\" + originalFileName);
				oldFile.delete();
			}
		}
		System.out.println("BEFORE" + memberVO);
		memberVO.setEmail(memberVO.getEmail());
		memberVO.setPhone_number(memberVO.getPhone_number());
		memberVO.setNickname(memberVO.getNickname());
		System.out.println("AFTER" + memberVO);
		memberService.recommendmodify(memberVO);
		memberService.modify(modmember);
		request.setAttribute("msg", "수정을 완료했습니다.<br> 다시 로그인 해주세요.");

		ModelAndView mav = new ModelAndView();
		mav.setViewName("redirect:/member/logout.do");
		return mav;
	}

	public String upload(MultipartHttpServletRequest multipartRequest) throws Exception {
		String imageFileName = null;
		Iterator<String> fileNames = multipartRequest.getFileNames();

		while (fileNames.hasNext()) {
			String fileName = fileNames.next();
			MultipartFile mFile = multipartRequest.getFile(fileName);
			imageFileName = mFile.getOriginalFilename();
			File file = new File(Member_IMAGE_USER + "\\" + fileName);
			if (mFile.getSize() != 0) {
				if (!file.exists()) {
					if (file.getParentFile().mkdirs()) {
						file.createNewFile();
					}
				}
				mFile.transferTo(new File(Member_IMAGE_USER + "\\" + "temp" + "\\" + imageFileName));
			}
		}
		return imageFileName;
	}

	@Override
	@RequestMapping(value = "/certification", method = { RequestMethod.GET, RequestMethod.POST })
	public String certification(@RequestParam("id") String id, @RequestParam("key") String key) throws Exception {
		memberService.change_Key(id, key);
		return "/member/sucess";
	}

	@Override
	@RequestMapping(value = "/removemember.do", method = { RequestMethod.POST, RequestMethod.GET })
	public ModelAndView removemember(HttpServletRequest request, HttpServletResponse response) throws Exception {
		HttpSession session = request.getSession();
		Member_VO sessmember = (Member_VO) session.getAttribute("member");
		memberService.removemember(sessmember.getId());
		ModelAndView mav = new ModelAndView();
		mav.setViewName("redirect:/member/logout.do");
		return mav;
	}

	// 내 댓글 출력
	@Override
	@RequestMapping(value = "/reply.do", method = { RequestMethod.GET, RequestMethod.POST })
	public ModelAndView reply(@RequestParam("id") String id, HttpServletRequest request) throws Exception {
		List<Map> reply = memberService.reply(id);
		List<Map> pcboardReply = memberService.pcboardReply(id);
		List<Map> mobileboardReply = memberService.mobileboardReply(id);
		List<Map> freeboardReply = memberService.freeboardReply(id);
		List<Map> consoleboardReply = memberService.consoleboardReply(id);
		Map<String, Object> replymap = new HashMap<String, Object>();
		Map<String, Object> pcmap = new HashMap<String, Object>();
		Map<String, Object> mobilemap = new HashMap<String, Object>();
		Map<String, Object> freemap = new HashMap<String, Object>();
		Map<String, Object> consolemap = new HashMap<String, Object>();
		replymap.put("replylist", reply);
		pcmap.put("pcboardReplylist", pcboardReply);
		mobilemap.put("mobileboardReplylist", mobileboardReply);
		freemap.put("freeboardReplylist", freeboardReply);
		consolemap.put("consoleboardReplylist", consoleboardReply);
		System.out.println(freeboardReply);
		System.out.println(reply);
		ModelAndView mav = new ModelAndView();
		mav.setViewName("member/reply");
		mav.addObject("reply", replymap);
		mav.addObject("pcboardReply", pcmap);
		mav.addObject("mobileReply", mobilemap);
		mav.addObject("freeboardReply", freemap);
		mav.addObject("consoleboardReply", consolemap);
		return mav;
	}

	// 내 게시글 출력
	@Override
	@RequestMapping(value = "/boardlist.do", method = { RequestMethod.GET, RequestMethod.POST })
	public ModelAndView boardlist(@RequestParam("id") String id, HttpServletRequest request) throws Exception {
		List<Pc_Board_VO> pcboard = memberService.pcboard(id);
		List<Console_Board_VO> consoleboard = memberService.consoleboard(id);
		List<Mobile_Board_VO> mobileboard = memberService.mobileboard(id);
		List<Free_Board_VO> freeboard = memberService.freeboard(id);
		System.out.println(pcboard);
		ModelAndView mav = new ModelAndView();
		mav.setViewName("member/boardlist");
		mav.addObject("pcboard", pcboard);
		mav.addObject("consoleboard", consoleboard);
		mav.addObject("mobileboard", mobileboard);
		mav.addObject("freeboard", freeboard);
		return mav;
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

	@Override
	@RequestMapping(value = "/jjim.do", method = { RequestMethod.POST, RequestMethod.GET })
	public void jjim(@RequestParam(value = "jjim") int jjim, @RequestParam(value = "id") String id,
			@RequestParam(value = "game_name") String game_name,
			@RequestParam(value = "small_category") String small_category,
			@RequestParam(value = "game_code") String game_code, HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		System.out.println(jjim);
		Jjim_VO jjimvo = new Jjim_VO();
		jjimvo.setGame_code(game_code);
		jjimvo.setGame_name(game_name);
		jjimvo.setId(id);
		jjimvo.setSmall_category(small_category);
		if (jjim == 1) {
			memberService.deletejjim(jjimvo);
		} else {
			memberService.insertjjim(jjimvo);
		}

	}

	@Override
	@RequestMapping(value = "/jjimlist.do", method = { RequestMethod.GET, RequestMethod.POST })
	public ModelAndView jjimlist(@RequestParam("id") String id, HttpServletRequest request) throws Exception {
		List<Jjim_VO> jjimlist = memberService.jjimlist(id);
		ModelAndView mav = new ModelAndView();
		mav.setViewName("member/jjim");
		mav.addObject("jjimlist", jjimlist);
		return mav;
	}
	
	//이메일 인증 웹으로 가는 메소드
	@Override
	@RequestMapping(value = "/email.do", method = { RequestMethod.GET, RequestMethod.POST })
	public ModelAndView email(@RequestParam("id") String id, HttpServletRequest request) throws Exception {
		System.out.println(id);
		ModelAndView mav = new ModelAndView();
		mav.addObject("id", id);
		mav.setViewName("/member/email");
		return mav;
	}
	
	//이메일 재전송
	@Override
	@RequestMapping(value = "/requestSend.do", method = { RequestMethod.GET, RequestMethod.POST })
	public String requestSend(@RequestParam("id") String id, HttpServletRequest request) throws Exception {
		String email = memberService.getEmail(id);
		memberService.requestSend(id, email, request);
		
		return "/main";
	}
	
	//이메일 변경창 띄우기
	@Override
	@RequestMapping(value = "/changeEmailForm.do", method = {RequestMethod.GET, RequestMethod.POST})
	public ModelAndView changeEmailView(@RequestParam("id") String id, HttpServletRequest request) throws Exception {
		ModelAndView mav = new ModelAndView();
		mav.addObject("id", id);
		mav.setViewName("/member/changeEmailForm");
		return mav;
	
	}
	
	
	
	//이메일 변경
	@Override
	@RequestMapping(value = "/changeEmail.do", method = {RequestMethod.GET, RequestMethod.POST})
	public void changeEmail(@RequestParam("id") String id, @RequestParam("email") String email, HttpServletRequest request, HttpServletResponse response) throws Exception {
		System.out.println("이메일 변경의 id : "+ id);
		System.out.println(email);
		memberService.changeEmail(id, email);
	}
	
	
}