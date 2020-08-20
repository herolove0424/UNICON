package com.project.unicon.management.controller;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.project.unicon.management.service.Management_Search_Service;
import com.project.unicon.vo.All_Board_VO;
import com.project.unicon.vo.Member_VO;

import common.paging.PagingCreatorDTO;
import common.paging.PagingDTO;



//관리자 페이지에서 회원 정보 검색 등에 사용되는 컨트롤러입니다.
//회원 검색 단에서 사용하는 테이블: member
@Controller("managementMemberSearchController")
@RequestMapping(value = "/management")
public class Management_Search_ControllerImpl implements Management_Search_Controller{
	
	//ViewNameInterceptor viewNameInterceptor = new ViewNameInterceptor();
	
	@Autowired
	private Management_Search_Service management_Search_Service;
	
	@Autowired
	Member_VO member_VO;
	
	//검색 jsp 호출
	@Override
	@RequestMapping(value = "member_Search_Form.ddun")
	public String management_Member_Search_Form(HttpServletRequest request,Model model) throws Exception {
		List<Member_VO> newMemberList = management_Search_Service.newMemberList();
		model.addAttribute("newMemberList", newMemberList);
		return (String) request.getAttribute("viewName");
	}


	//member_Search_Form에서 아이디,이름,휴대폰 번호,이메일 중 선택하고 조건을 입력하면 검색하여 보여줌
	@Override
	@RequestMapping(value = "member_Search.ddun", method = {RequestMethod.POST})
	public ModelAndView management_Member_Search(Map<String, String> search_Info, HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		
		HttpSession session =  request.getSession();
		session.getAttribute("member");
		
		List<Member_VO> resultMember = management_Search_Service.management_Member_Search(search_Info);
		
		//별도의 jsp가 아닌 위의 member_Search_Form에 검색창아래 보여주기 위해 member_Search_Form.jsp로 연결함
		ModelAndView mav = new ModelAndView("/management/member_Search_Form");
		mav.addObject("resultMember", resultMember);
		
		return mav;
		
	}

	//검색 후 , 결과 창에서 아이디 클릭 시 , 해당 아이디를 가진 회원의 상세 정보를 보여줌
	@Override
	@RequestMapping(value = "/management_Detail_Member.ddun", method = RequestMethod.GET)
	public ModelAndView management_Detail_Member(@RequestParam("id") String id, HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		
		ModelAndView mav = new ModelAndView((String)request.getAttribute("viewName"));
		try {
			member_VO = management_Search_Service.management_Detail_Search(id);
			
			//휴대폰 번호를 010-1111-1111 형태로 다듬어줌
			String phone_Number = member_VO.getPhone_number();
			String revise_Phone_Number = phone_Number.substring(0, 3);
			revise_Phone_Number += "-";
			revise_Phone_Number += phone_Number.substring(3, 7);
			revise_Phone_Number += "-";
			revise_Phone_Number += phone_Number.substring(7);
			
			member_VO.setPhone_number(revise_Phone_Number);
			
			
			mav.addObject("id", id);
			mav.addObject("detail_Info", member_VO);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return mav;
	}

	//지금 현재 타일즈를 사용하지 않았기 떄문에, 사이드바가 중첩해서 나오는 문제가 발생하여 임시로 management_Detail_Member와 동일한 기능을 하는 메소드를 만들어서 대처 > 차후 타일즈 도입시 삭제예정
	@Override
	@RequestMapping(value = "/management_Detail_Member_test.ddun", method = RequestMethod.GET)
	public ModelAndView management_Detail_Member_Temp(String id, HttpServletRequest request, HttpServletResponse response) throws Exception {
		member_VO = management_Search_Service.management_Detail_Search(id);
		
		//휴대폰 번호를 010-1111-1111 형태로 다듬어줌
		String phone_Number = member_VO.getPhone_number();
		String revise_Phone_Number = phone_Number.substring(0, 3);
		revise_Phone_Number += "-";
		revise_Phone_Number += phone_Number.substring(3, 7);
		revise_Phone_Number += "-";
		revise_Phone_Number += phone_Number.substring(7);
		
		member_VO.setPhone_number(revise_Phone_Number);
		
		ModelAndView mav = new ModelAndView((String)request.getAttribute("viewName"));
		mav.addObject("id", id);
		mav.addObject("detail_Info", member_VO);
		return mav;
	}
	
	//0804 김도경 추가
	//멤버의 활동 확인
	@Override
	@GetMapping("/memberActivity.ddun")
	public String memberActivity(@RequestParam("id") String id,PagingDTO pagingDTO,Model model) throws Exception{
		List<All_Board_VO> memberActList =management_Search_Service.memberActivityList(pagingDTO);
		
		int total_Record_Cnt=management_Search_Service.memberActivityTotalRows(id);
		
		model.addAttribute("memberActList", memberActList);
		model.addAttribute("pagingCreator", new PagingCreatorDTO(pagingDTO, total_Record_Cnt));
		model.addAttribute("id", id);
		return "/management/memberActivity";
	}
	
	//해당 글로 이동
	@Override
	@GetMapping("/searchMembersBoard.ddun")
	public String searchMembersBoard(@ModelAttribute("searchBoard") All_Board_VO searchBoard) throws Exception{
		
		//서비스의 리턴값이 1:free 2:mobile 3:pc 4:console 게시판에 있다는 이야기
		
		int status = management_Search_Service.searchMembersBoard(searchBoard);
		
		String url="";
		
		
		if(status==1) {
			url="redirect: /unicon/board/FreeViewArticle.do?boardNO=" +searchBoard.getBoardNO();
		}else if(status==2) {
			url="redirect: /unicon/board/MobileViewArticle.do?boardNO=" +searchBoard.getBoardNO();
		}else if(status==3) {
			url="redirect: /unicon/board/viewArticle2.do?boardNO=" +searchBoard.getBoardNO();
		}else if(status==4) {
			url="redirect: /unicon/board/ConsoleViewArticle.do?boardNO=" +searchBoard.getBoardNO();
		}else {
			url="redirect: /unicon/management/searchMembersBoard.ddun?id=" +searchBoard.getId();
		}
		return url;
	}
	
	//0804 신규 개발
	@GetMapping("/deleteMemberActBoard.ddun")
	public String deleteMemberActBoard(@ModelAttribute("delBoard") All_Board_VO delBoard) throws Exception{
		System.out.println("데이터 넘어오나?"+delBoard.getId());
		System.out.println("데이터 넘어오나?"+delBoard.getBoardNO());
		System.out.println("데이터 넘어오나?"+delBoard.getStatus());
		
		management_Search_Service.deleteMemberActBoard(delBoard);
		
		return "redirect: /unicon/management/memberActivity.ddun?id="+delBoard.getId();
		
	}
	
	

}
