package com.project.unicon.management.controller;

import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.util.ArrayList;
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
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.google.gson.JsonObject;
import com.project.unicon.management.service.Management_Notice_Service;
import com.project.unicon.vo.Admin_Notice_VO;
import com.project.unicon.vo.Member_VO;

import common.paging.PagingCreatorDTO;
import common.paging.PagingDTO;


@Controller("managementNoticeController")
@RequestMapping(value = "/management")
public class Management_Notice_ControllerImpl implements Management_Notice_Controller{
	
	@Autowired
	Admin_Notice_VO admin_Notice_VO;
	
	@Autowired
	private Management_Notice_Service notice_Service;
	
	//공지 목록
	@GetMapping("/notice.ddun")
	@Override
	public String notice_List(PagingDTO pagingDTO, Model model) throws Exception{
		List<Admin_Notice_VO> noticeList = notice_Service.bring_Notice_List(pagingDTO);
		System.out.println("noticeList 여부 확인:"+noticeList.isEmpty());
		model.addAttribute("noticeList", noticeList);
		
		int allNoticeRows = notice_Service.allNoticeRows(pagingDTO);
		model.addAttribute("pagingCreatorDTO", new PagingCreatorDTO(pagingDTO, allNoticeRows));
		
		return "management_notice/notice";
		
	}
	
	//공지사항 작성폼으로 이동
	@GetMapping("/noticeForm.ddun")
	@Override
	public String notice_Form(HttpServletRequest request, Model model) throws Exception{
		HttpSession session = request.getSession();
		Member_VO member = (Member_VO) session.getAttribute("member");
		String id=member.getId();
		System.out.println("작성자 확인:"+id);
		model.addAttribute("manager_Id", id);
		return "/management_notice/noticeForm";
	}
	
	//공지사항 작성
	@PostMapping("/noticeAdd.ddun")
	@ResponseBody
	@Override
	public ResponseEntity<Object> notice_Add(@ModelAttribute("notice") Admin_Notice_VO notice, HttpServletRequest multirequest) throws Exception{
		multirequest.setCharacterEncoding("utf-8");
		
		String message=null;
		ResponseEntity<Object> resEnt = null;
		HttpHeaders responseHeaders = new HttpHeaders();
		responseHeaders.add("Content-Type", "text/html; charset=utf-8");
		
		try {
			notice_Service.add_Notice(notice);
			message +="<script>";
			message +=" alert('새글을 추가했습니다.');";
			message +=" location.href='"+multirequest.getContextPath()+"/management/notice.ddun'; ";
			message +="</script>";
			
			resEnt =  new ResponseEntity<Object>(message, responseHeaders, HttpStatus.CREATED);
		}catch (Exception e) {
			message +="<script>";
			message +=" alert('오류가 발생했습니다 다시 시도해주세요.');";
			message +=" location.href='"+multirequest.getContextPath()+"/management/notice.ddun'; ";
			message +="</script>";
			resEnt =  new ResponseEntity<Object>(message, responseHeaders, HttpStatus.BAD_REQUEST);
			e.printStackTrace();
		}
		
		return resEnt;
		
	}
	
	//이미지 파일 처리
	@PostMapping(value="/uploadSummernoteImageFileOnNotice", produces = "application/json")
	@ResponseBody
	@Override
	public JsonObject uploadSummernoteImageFile(@RequestParam("file") MultipartFile multipartFile) {
		System.out.println("여기 들어오긴하니?");
		JsonObject jsonObject = new JsonObject();
		
		//String fileRoot = "C:\\summernote\\summernote_image\\";	//저장될 외부 파일 경로
		String fileRoot = "C:\\project\\notice\\";	//저장될 외부 파일 경로
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
	
	//공지사항 상세보기
	@GetMapping("/noticeView.ddun")
	@Override
	public String noticeView(@RequestParam Map<String, String> urlInfo, Model model) throws Exception{
		
		//페이지 검색어 유지를 위해 구성
		List<String> for_Back_List_Function = new ArrayList<String>();
		
		int boardno = Integer.valueOf(urlInfo.get("boardno"));
		String currentPageNo = urlInfo.get("currentPageNo");
		String recordsPerPage = urlInfo.get("recordsPerPage");
		String searchType = urlInfo.get("searchType");
		String searchKeyword = urlInfo.get("searchKeyword");
		
		for_Back_List_Function.add(currentPageNo);//0
		for_Back_List_Function.add(recordsPerPage);//1
		for_Back_List_Function.add(searchType);//2
		for_Back_List_Function.add(searchKeyword);//3
		
		//조회수 1 증가
		notice_Service.noticeViewCount(boardno);
		
		//세부 정보 불러오기
		Admin_Notice_VO noticeViewDetail = notice_Service.detailNotice(boardno);
		
		System.out.println("세부 정보 확인:"+noticeViewDetail.getTitle());
		System.out.println("세부 내용 확인"+noticeViewDetail.getContent());
		
		model.addAttribute("for_Back_List_Function", for_Back_List_Function);
		model.addAttribute("noticeViewDetail", noticeViewDetail);
		
		return "/management_notice/noticeView";
		
	}
	
	//공지 수정 폼으로 이동
	@GetMapping("/modNoticeF.ddun")
	@Override
	public String modNoticeForm(@RequestParam Map<String, String> urlInfo, Model model) throws Exception{
		
		List<String> for_Back_List_Function = new ArrayList<String>();
		
		int boardno = Integer.valueOf(urlInfo.get("boardno"));
		String currentPageNo = urlInfo.get("currentPageNo");
		String recordsPerPage = urlInfo.get("recordsPerPage");
		String searchType = urlInfo.get("searchType");
		String searchKeyword = urlInfo.get("searchKeyword");
		
		for_Back_List_Function.add(currentPageNo);//0
		for_Back_List_Function.add(recordsPerPage);//1
		for_Back_List_Function.add(searchType);//2
		for_Back_List_Function.add(searchKeyword);//3
		
		model.addAttribute("for_Back_List_Function", for_Back_List_Function);
		model.addAttribute("noticeModDetail", notice_Service.detailNotice(boardno));
		
		return "/management_notice/noticeModF";
		
	}
	
	//공지 수정
	@PostMapping("/modNotice.ddun")
	@Override
	public String modNotice(@RequestParam Map<String, String> urlInfo, @ModelAttribute("notice") Admin_Notice_VO notice) throws Exception{
		
		notice_Service.modNoticeService(notice);
		String boardno = String.valueOf(notice.getBoardno());
		return "redirect: /unicon/management/noticeView.ddun?boardno="+boardno
		+"&searchType="+urlInfo.get("searchType")
		+"&currentPageNo="+urlInfo.get("currentPageNo")
		+"&recordsPerPage="+urlInfo.get("recordsPerPage")
		+"&searchKeyword="+urlInfo.get("searchKeyword");
		
		
	}
	
	//공지 삭제
	@PostMapping("/delNotice.ddun")
	public String deleteNotice(@RequestParam("boardno") int boardno, HttpServletResponse response) throws Exception{
		notice_Service.delNotice(boardno);
		
		return "redirect: /unicon/management/notice.ddun";
	}

}
