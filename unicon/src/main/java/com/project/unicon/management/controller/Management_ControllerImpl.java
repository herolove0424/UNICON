package com.project.unicon.management.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.project.unicon.management.service.Management_Service;
import com.project.unicon.vo.Member_VO;



//관리자 페이지 메인 컨트롤러 입니다.
//관리자 페이지 단에서 사용하는 테이블: member
@Controller("managementMainController")
@RequestMapping(value = "/management")


public class Management_ControllerImpl implements Management_Controller{
	
	//ViewNameInterceptor에서 메소드 끌고옴
	//ViewNameInterceptor viewNameInterceptor =  new ViewNameInterceptor();
	
	@Autowired
	private Management_Service management_Service;
	
	@Autowired
	Member_VO member_VO;
	
	//만약 로그인이 풀리거나 로그인하지 않은 상태로 관리자 메인으로 들어올 경우 LoginCheckInterceptor가 작동하여 로그인 페이지로 보냄
	@Override
	@RequestMapping(value = "/main.ddun", method = {RequestMethod.POST,RequestMethod.GET})
	public String management_Main(HttpServletRequest request, Model model) throws Exception {
		//가입 관련(오늘 어제)
				int newMember = management_Service.countNewMember();
				double lastdayMember = management_Service.countLastDayNewMember();
				
				double upDown = ((newMember-lastdayMember)/lastdayMember)*100;
				if(Double.isInfinite(upDown)) {
					upDown=100*newMember;
				}else if(Double.isNaN(upDown)) {
					upDown=100*newMember;
				}
				
				//방문자 관련(오늘 어제)
				int todayCount=management_Service.getVisitTodayCount();
				double lastDayCount=management_Service.getLastVisitCount();
				
				double visitUpDown=((todayCount-lastDayCount)/lastDayCount)*100;
				if(Double.isInfinite(visitUpDown)) {
					visitUpDown=100*todayCount;
				}else if(Double.isNaN(visitUpDown)) {
					visitUpDown=100*todayCount;
				}
				
				//새로 등록된 게시글
				int todayBoard = management_Service.todayRegistBoard();
				double lastDayBoard=management_Service.lastDayRegistBoard();
				
				double boardUpDown=((todayBoard-lastDayBoard)/lastDayBoard)*100;
				if(Double.isInfinite(boardUpDown)) {
					boardUpDown=100*todayBoard;
				}else if(Double.isNaN(boardUpDown)) {
					boardUpDown=100*todayBoard;
				}
				
				//새로 등록된 리뷰
				int todayReview = management_Service.todayReviewCount();
				double lastDayReview=management_Service.lastDayReviewCount();
				
				double reviewUpDown=((todayReview-lastDayReview)/lastDayReview)*100;
				if(Double.isInfinite(reviewUpDown)) {
					reviewUpDown=100*todayReview;
				}else if(Double.isNaN(reviewUpDown)) {
					reviewUpDown=100*todayReview;
				}
				
				System.out.println("boardUpDown"+boardUpDown);
				model.addAttribute("newMember", newMember);
				model.addAttribute("upDown", upDown);
				
				model.addAttribute("todayCount", todayCount);
				model.addAttribute("visitUpDown", visitUpDown);
				
				model.addAttribute("todayBoard", todayBoard);
				model.addAttribute("boardUpDown",boardUpDown);
				
				model.addAttribute("todayReview", todayReview);
				model.addAttribute("reviewUpDown",reviewUpDown);
				
				return (String) request.getAttribute("viewName");
	}
	
	/*매핑이름 .go 이유: LoginCheckInterceptor가 .ddun로 들어오는 매핑에 대해서 로그인 검사를 하기 떄문에, 
	로그인 하는 과정인 loginForm.go와 login.go는 제외 시키기 위해 인위적으로 매핑 이름을 .go로 지정*/
	// management_Login기능: 관리자 페이지에서 로그인이 풀릴 경우 로그인을 진행 할 수 있도록 함
	@Override
	@RequestMapping(value = "/loginForm.go")
	public String management_Login_Form(HttpServletRequest request) throws Exception {
		//return viewNameInterceptor.getViewName(request);
		HttpSession session = request.getSession();
		session.removeAttribute("isLogOn");
		return "/management/loginForm";
	}//end of management_Login
	
	
	//management_Login 기능: 로그인 시, 아이디와 비밀번호를 자동으로 member_VO에 바인딩
	//RedirectAttributes? redirect시 값을 함께 보낼 수 있음. 이떄 addAttribute 매소드를 이용하면 해당 값이 url에 표시됌(아래 경우 isLogOn=false 로 주소에 붙어나옴)
	@Override
	@RequestMapping(value = "/login.go", method = RequestMethod.POST)
	public ModelAndView management_Login(@ModelAttribute("login_Info") Member_VO member_Info,RedirectAttributes redirect_Attr, HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		ModelAndView mav = new ModelAndView();
		HttpSession session = request.getSession();
		//session.removeAttribute("isLogOn");
		/*
		if(session.getAttribute("member")!=null) {
			session.removeAttribute("member");
		}*/
		
		
		member_VO = management_Service.management_Login(member_Info);
		
		if(member_VO!=null) {
			String id=member_VO.getId();
			session.setAttribute("member", member_VO);
			session.setAttribute("isLogOn", true);
			String action = (String) request.getAttribute("action");
			session.removeAttribute("action");
			session.setAttribute("memberforBoard", id);
			
			if(action!=null) {
				mav.setViewName("redirect:"+action);
			}else {
				mav.setViewName("redirect:/management/main.ddun");
			}
			
		}else {
			redirect_Attr.addAttribute("isLogOn", false);
			mav.setViewName("redirect:/management/loginForm.go");
		}
		
		return mav;
		
	}
	
	@Override
	@RequestMapping(value = "/logout.do", method = { RequestMethod.GET, RequestMethod.POST })
	public ModelAndView logout(HttpServletRequest request, HttpServletResponse sponse) throws Exception {
		HttpSession session = request.getSession();
		session.removeAttribute("member");
		session.removeAttribute("isLogOn");
		//쪽지로 인한 추가
		session.removeAttribute("memberforBoard");
		ModelAndView mav = new ModelAndView();
		mav.setViewName("redirect:/management/main.ddun");
		return mav;
	}
	

	

}
