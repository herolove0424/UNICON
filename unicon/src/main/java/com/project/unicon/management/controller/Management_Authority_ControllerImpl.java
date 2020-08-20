package com.project.unicon.management.controller;


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
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.project.unicon.management.service.Management_Authority_Service;
import com.project.unicon.member.service.MemberService;
import com.project.unicon.vo.Member_VO;


@Controller("managementAutortyController")
@RequestMapping("/management")
public class Management_Authority_ControllerImpl implements Management_Authority_Controller{

	@Autowired
	Management_Authority_Service management_Authority_Service;
	
	
	@Autowired
	Member_VO member_VO;
	
	
	//권한 페이지로 이동
	@GetMapping("/authorMain.ddun")
	@Override
	public String autority_Form() throws Exception{
		return "/management_author/autority_Form";
	}
	
	//id 중복 체크
	@PostMapping("/idCheck.ddun")
	@ResponseBody
	@Override
	public String idCheck(@RequestParam("id") String id) throws Exception{
		System.out.println("id 중복 확인:"+id);
		int result = management_Authority_Service.manager_Id_Check(id);;
		System.out.println("결과 확인: "+result);
		return String.valueOf(result);
	}
	
	
	//휴대폰 번호
	@PostMapping("/phoneCheck.ddun")
	@ResponseBody
	@Override
	public String phoneCheck(@RequestParam("phone_number") String phone_number) throws Exception{
		String[] array = phone_number.split("-");
		String resultStr = "";
		for(int i=0;i<array.length;i++) {
			resultStr+=array[i];
		}
		
		int result = management_Authority_Service.manager_Phone_Check(resultStr);
		return String.valueOf(result);
	}
	
	
	//관리자 계정 생성
	@PostMapping("/authorRegist.ddun")
	@ResponseBody
	@Override
	public String author_Regist(@ModelAttribute("mem_Info") Member_VO member) throws Exception{
		String phone = member.getPhone_number();
		String[] array = phone.split("-");
		String result = "";
		for(int i=0;i<array.length;i++) {
			result+=array[i];
		}
		
		member.setPhone_number(result);
		
		
		//초기 비밀번호 지정
		member.setPassword("gmUniconTemp");
		
		//이메일 설정(사내 이메일로 가정)
		member.setEmail(member.getId()+"@unicon.com");
		
		management_Authority_Service.add_Authority(member);
		
		
		return "success";
	}
	
	//권한 승인 창
	@PostMapping("/confirm_Form.ddun")
	@Override
	public String confirm_Form(@ModelAttribute("mem_Info") Member_VO member,Model model,HttpServletRequest request) throws Exception{
		System.out.println("POST로 값 넘기기:"+member.getId());
		System.out.println("POST로 값 넘기기:"+request.getParameter("id"));
		request.setCharacterEncoding("UTF-8");
		model.addAttribute("mem_Id", member.getId());
		model.addAttribute("mem_Name", member.getName());
		model.addAttribute("mem_Ph", member.getPhone_number());
		model.addAttribute("mem_Gr", +member.getGrade());
		return "/management_author/confirm_Form";
	}
	
	//권한 승인 창
	@PostMapping("/confirmPassword.ddun")
	@ResponseBody
	@Override
	public ResponseEntity<String> confirm_Password(@RequestParam("inputPw") String inputPw,
			@ModelAttribute("hidden_Info") Member_VO member,HttpServletRequest request) throws Exception{
		
		System.out.println("아작스 요청 확인");
		System.out.println("넘어온 값 확인: "+inputPw);
		System.out.println("넘어온 값 확인2: "+member.getPhone_number());
		
		request.setCharacterEncoding("UTF-8");
		ResponseEntity<String> entity = null;
		
		HttpSession session=request.getSession();
		Member_VO present_Login=(Member_VO) session.getAttribute("member");
		
		//현재 사용자 아이디
		String present_Id=present_Login.getId();
		System.out.println("현재 사용자 확인: "+present_Id);
		
		//현재 사용자 아이디와 입력된 비밀번호가 일치하는 계정이 있는지 확인
		Map<String, String> sendValues = new HashMap<String, String>();
		sendValues.put("id", present_Id);
		sendValues.put("password", inputPw);
		
		int check = management_Authority_Service.confirm_Password(sendValues);
		
		//입력받은 휴대폰 번호에서 - 잘라내기
		if(check==1) {
			String phone = member.getPhone_number();
			String[] array = phone.split("-");
			String result = "";
			for(int i=0;i<array.length;i++) {
				result+=array[i];
			}
			
			member.setPhone_number(result);
			
			//초기 비밀번호 지정
			member.setPassword("gmUniconTemp");
			
			//이메일 설정(사내 이메일로 가정)
			member.setEmail(member.getId()+"@unicon.com");
			
			try {
				//사용자 아이디와 입력된 비밀 번호가 일치할 경우, 입력된 계정 생성
				management_Authority_Service.add_Authority(member);
				entity=new ResponseEntity<String>("success",HttpStatus.OK);
			}catch (Exception e) {
				//에러 처리
				e.printStackTrace();
				System.out.println(e.getMessage());
				entity = new ResponseEntity<String>(e.getMessage(),HttpStatus.BAD_REQUEST);
			}
			
		}else {
			//일치하지 않을 경우 
			entity=new ResponseEntity<String>("no-match",HttpStatus.NOT_ACCEPTABLE);
		}
		
		return entity;
		
	}
	
	
	//관리자 계정 목록
	@PostMapping("authorList.ddun")
	@Override
	public ResponseEntity<Object> ajax_AuthorList() throws Exception{
		HttpHeaders responseHeaders = new HttpHeaders();
		ArrayList<HashMap<Object, Object>> hmList = new ArrayList<HashMap<Object,Object>>();
		
		List<Member_VO> memberLists = management_Authority_Service.selectAuthorList();
		
		if(memberLists.size()>0) {
			for(int i=0;i<memberLists.size();i++) {
				HashMap<Object, Object> hm = new HashMap<Object, Object>();
				//id
				hm.put("id", memberLists.get(i).getId());
				//nickname
				//hm.put("nickname", memberLists.get(i).getNickname());
				//email
				hm.put("email", memberLists.get(i).getEmail());
				//join_date
				hm.put("joindate", memberLists.get(i).getJoin_date());
				//name
				hm.put("name", memberLists.get(i).getName());
				//grade
				hm.put("grade", memberLists.get(i).getGrade());
				
				hmList.add(hm);
			}
		}
		
		JSONArray json = new JSONArray(hmList);
		return new ResponseEntity<Object>(json.toString(), responseHeaders, HttpStatus.CREATED);
	}
	
	/* 0801 변경 */
	@PostMapping("/removeAuthor.ddun")
	@ResponseBody
	@Override
	public String removeAuthor(@ModelAttribute("removeInfo") Member_VO removemember,HttpServletRequest request) throws Exception{
		HttpSession session=request.getSession();
		Member_VO present_Login=(Member_VO) session.getAttribute("member");
		
		//현재 사용자 아이디
		String present_Id=present_Login.getId();
		String inputPw=removemember.getPassword();
		
		System.out.println("현재 사용자 id"+present_Id);
		System.out.println("입력 inputPw"+inputPw);
		System.out.println("삭제 요청"+removemember.getId());
		
		
		Map<String, String> sendValues = new HashMap<String, String>();
		sendValues.put("id", present_Id);
		sendValues.put("password", inputPw);
		
		int check = management_Authority_Service.confirm_Password(sendValues);
		String result="";
		if(check==1) {
			try {
				management_Authority_Service.deleteAuthor(removemember.getId());
				result="success";
			}catch (Exception e) {
				e.printStackTrace();
				result="failed";
			}
		}else {
			result="none";
		}
		return result;
	}
	
	/* 0801 추가 */
	@PostMapping("modifyAuthor.ddun")
	@ResponseBody
	@Override
	public String modifyAuthor(@ModelAttribute("modInfo") Member_VO modmember,HttpServletRequest request) throws Exception{
		
		HttpSession session=request.getSession();
		//Member_VO present_Login=(Member_VO) session.getAttribute("member");
		
		//현재 사용자 아이디
		String present_Id=(String) session.getAttribute("memberforBoard");
		String inputPw=modmember.getPassword();
		
		Map<String, String> sendValues = new HashMap<String, String>();
		sendValues.put("id", present_Id);
		sendValues.put("password", inputPw);
		
		int check = management_Authority_Service.confirm_Password(sendValues);
		
		System.out.println("아작스 확인중..."+check);
		String result="";
		if(check==1) {
			try {
				management_Authority_Service.modifyAuthor(modmember.getId(), modmember.getGrade());
				result="success";
			}catch (Exception e) {
				e.printStackTrace();
				result="failed";
			}
		}else {
			result="none";
		}
		
		return result;
	}
	
	@PostMapping("/changePrimaryPw.go")
	@Override
	public ResponseEntity<String> changePrimaryPw(@RequestParam("valueById") String valueById,@RequestParam("valueByPw") String valueByPw) throws Exception{
		System.out.println("정상 호출 확인");
		System.out.println("valueByPw확인: "+valueByPw);
		System.out.println("id확인: "+valueById);
		
		String message=null;
		ResponseEntity<String> resEnt = null;
		HttpHeaders headers = new HttpHeaders();
		headers.add("Content-Type", "text/html; charset=utf-8");
		
		try {
			management_Authority_Service.updateAuthorPw(valueById, valueByPw);
			
			message +="<script>";
			message +=" alert('비밀번호 수정이 완료되었습니다.');";
			message +=" location.href='/unicon/management/loginForm.go'; ";
			message +="</script>";
			
			resEnt =  new ResponseEntity<String>(message, headers, HttpStatus.CREATED);
		}catch (Exception e) {
			e.printStackTrace();
			message +="<script>";
			message +=" alert('오류가 발생했습니다. 다시 시도해주세요');";
			message +=" location.href='/unicon/member/login.do'; ";
			message +="</script>";
			
			resEnt =  new ResponseEntity<String>(message, headers, HttpStatus.BAD_REQUEST);
		}
		
		return resEnt;
		
	}
	
	
	
}
