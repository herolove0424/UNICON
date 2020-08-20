package com.project.unicon.management.controller;

import java.io.File;
import java.io.FileInputStream;
import java.io.OutputStream;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

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
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.project.unicon.management.service.Management_Game_Service;
import com.project.unicon.vo.Info_Image_VO;
import com.project.unicon.vo.Info_VO;
import com.project.unicon.vo.Review_VO;

import common.paging.PagingCreatorDTO;
import common.paging.PagingDTO;

@Controller("managementGameController")
@RequestMapping(value ="/management" )
public class Management_Game_ContorllerImple implements Management_Game_Contorller{
	
	@Autowired
	private Management_Game_Service management_Game_Service;
	
	@Autowired
	Info_VO info_VO;
	
	@Autowired
	Info_Image_VO info_Image_VO;
	
	public static final String IMAGE_REPO="C:\\project\\image";
	
	//페이징, 검색 기능 구현된 관리자 단 게임 리스트
	@Override
	@GetMapping("/gamelist.ddun")
	public String list_Game_Articles(PagingDTO pagingDTO, Model model) throws Exception {
		
		//조건에 맞는 게임 리스트 출력
		List<Info_VO> all_Gamelist =  management_Game_Service.management_Search_All_Games(pagingDTO);
		
		//페이징을 위한 전체 데이터 개수 확보
		int total_Record_Cnt = management_Game_Service.management_Searched_Total_Rows(pagingDTO);
		
		model.addAttribute("all_Gamelist", all_Gamelist);
		model.addAttribute("pagingCreator", new PagingCreatorDTO(pagingDTO, total_Record_Cnt));
		model.addAttribute("searchKeyword", pagingDTO.getSearchKeyword());
		
		return "/management_game/gamelist";
	}
	
	//글쓰기 폼으로 이동
	@Override
	@PostMapping("/game_RegisteForm.ddun")
	public String add_GameForm() throws Exception{
		return "/management_game/add_GameForm";
	}
	
	
	//글쓰기
	//jsp의 info 내용을 자동으로 vo에 매핑
	@Override
	@PostMapping("/game_Registe.ddun")
	public ResponseEntity<Object> add_Game(@ModelAttribute("game_Info") Info_VO game_Info,MultipartHttpServletRequest multirequest) throws Exception{
		multirequest.setCharacterEncoding("utf-8");
		
		//String imageFileName = null;
		
		//small카테고리에 따라 big카테고리 지정
		String small_category = game_Info.getSmall_category();
		if(small_category.equals("PC")) {
			game_Info.setBig_category("pc");
		}else if(small_category.equals("MOBILE")) {
			game_Info.setBig_category("mobile");
		}else if(small_category.equals("SWITCH")||small_category.equals("PS4")||small_category.equals("XBOX")) {
			game_Info.setBig_category("console");
		}
		
		
		//jsp에서 파일의 name별로 첨부된 이미지 파일의 originalfilename을 리스트에 담음
		List<String> fileList = upload(multirequest);
		
		String message=null;
		ResponseEntity<Object> resEnt = null;
		HttpHeaders responseHeaders = new HttpHeaders();
		responseHeaders.add("Content-Type", "text/html; charset=utf-8");
		
		try {
			//jsp form의 내용을 game_info 테이블에 삽입
			String game_Info_Code=management_Game_Service.add_Game_Info(game_Info);
			

			if(fileList!=null&&fileList.size()!=0) {
				for(String fileName:fileList) {
					
					//이미지 파일과 관련 게임 코드를 game_info_image테이블에 삽입하는 구문
					if(fileName.contains("logo")||fileName.contains("로고")) {
						info_Image_VO.setImagefilename(fileName);
						info_Image_VO.setGame_code(game_Info_Code);
						management_Game_Service.add_Game_Info_Logo_Image(info_Image_VO);
					}else {
						info_Image_VO.setImagefilename(fileName);
						info_Image_VO.setGame_code(game_Info_Code);
						management_Game_Service.add_Game_Info_Image(info_Image_VO);
					}
					
					
					//temp 폴더에 있는 파일을 gamecode파일로 이동
					File srtFile = new File(IMAGE_REPO+"\\"+"temp"+"\\"+fileName);
					File destDir = new File(IMAGE_REPO+"\\"+game_Info_Code);
					FileUtils.moveFileToDirectory(srtFile, destDir, true);
					
				}
				
			}
			
			message +="<script>";
			message +=" alert('새글을 추가했습니다.');";
			message +=" location.href='"+multirequest.getContextPath()+"/management/gamelist.ddun'; ";
			message +="</script>";
			
			resEnt =  new ResponseEntity(message, responseHeaders, HttpStatus.CREATED);
			
		}catch (Exception e) {
			
			//오류처리, temp에 있는 파일 삭제
			if(fileList!=null&&fileList.size()!=0) {
				for(String fileName:fileList) {
					File srtFile = new File(IMAGE_REPO+"\\"+"temp"+"\\"+fileName);
					srtFile.delete();
					
				}
			}
			message +="<script>";
			message +=" alert('오류가 발생했습니다 다시 시도해주세요.');";
			message +=" location.href='"+multirequest.getContextPath()+"/management/game_Registe.ddun'; ";
			message +="</script>";
			resEnt =  new ResponseEntity(message, responseHeaders, HttpStatus.CREATED);
			e.printStackTrace();
			
		}
		
		return resEnt;
		

		
	}
	
	@Override
	@GetMapping("/viwe_Detail.ddun")
	public String view_Game_Detail(@RequestParam Map<String, String> game_Detail, Model model) throws Exception{
		
		
		System.out.println("확인: "+game_Detail.get("game_code"));
		System.out.println("확인: "+game_Detail.get("currentPageNo"));
		System.out.println("확인: "+game_Detail.get("recordsPerPage"));
		
		List<String> for_Back_List_Function = new ArrayList<String>();
		String game_code = game_Detail.get("game_code");
		String currentPageNo = game_Detail.get("currentPageNo");
		String recordsPerPage = game_Detail.get("recordsPerPage");
		String searchType = game_Detail.get("searchType");
		String searchKeyword = game_Detail.get("searchKeyword");
		
		for_Back_List_Function.add(currentPageNo);//0
		for_Back_List_Function.add(recordsPerPage);//1
		for_Back_List_Function.add(searchType);//2
		for_Back_List_Function.add(searchKeyword);//3
		
		//여기 시작중
		
		//List<Info_VO> detale_Info = management_Game_Service.detail_Game_Info(game_code);
		//게임 상세 정보
		Info_VO detale_Info = management_Game_Service.detail_Game_Info(game_code);
		//로고 이미지 정보
		Info_Image_VO  detail_Image_Logo_Info = management_Game_Service.detail_Game_Image_Logo_Info(game_code);
		//기타 이미지 정보
		List<Info_Image_VO> detail_Image_Info = management_Game_Service.detail_Game_Image_Info(game_code);
		
		model.addAttribute("detail_Game_Info", detale_Info);
		
		model.addAttribute("detail_Image_Logo_Info", detail_Image_Logo_Info);
		model.addAttribute("detail_Image_Info", detail_Image_Info);
		model.addAttribute("for_Back_List_Function", for_Back_List_Function);
		return "/management_game/view_Game_Detail";
		
	}
	
	@Override
	@PostMapping("/modGameInfo.ddun")
	public ResponseEntity<Object> mod_Game_Info(@ModelAttribute("game_Info") Info_VO mod_Info,@RequestParam Map<String, String> image_Info,MultipartHttpServletRequest multirequest) throws Exception{
		
		String message=null;
		ResponseEntity<Object> resEnt = null;
		HttpHeaders responseHeaders = new HttpHeaders();
		responseHeaders.add("Content-Type", "text/html; charset=utf-8");
		
		//수정이 진행되는 게임 코드를 불러옴
		String game_code = mod_Info.getGame_code();
		int currentPageNo = Integer.valueOf(image_Info.get("currentPageNo"));
		int recordsPerPage = Integer.valueOf(image_Info.get("recordsPerPage"));
		String searchKeyword = image_Info.get("searchKeyword");
		String searchType = image_Info.get("searchType");
		
		System.out.println("게임 스타일 어디갔니:"+mod_Info.getPlay_type());
		
		try {
			
			//game_info 테이블 업데이트 기능
			management_Game_Service.mod_Game_Info(mod_Info);
			
			
			
			//새롭게 등록하는 파일 정보 가져오기
			Iterator<String> fileNames=multirequest.getFileNames();
			
			
			
				while(fileNames.hasNext()) {
					String fileName=fileNames.next();
					
					//새롭게 업로드된 파일 정보 바인딩
					MultipartFile unityFile = multirequest.getFile(fileName);
					
					//jsp에 지정된 파일의 name
					String newContentFileValue = unityFile.getName();
					
					//jsp에 첨부한 파일의 원본 파일 이름
					String newContentFileName = unityFile.getOriginalFilename();
					
					File file = new File(IMAGE_REPO+"\\"+fileName);
					
					if(newContentFileValue.equals("NewLogoName")&&newContentFileName!=null&&newContentFileName!="") {
						//hidden값으로 숨겨놓은 
						String originalFileName=image_Info.get("originalLogoName");
						modify_Image_File(unityFile,file,newContentFileName,originalFileName,game_code);
						
					}
					
					for(int i=1; i<=3;i++) {
						if(newContentFileValue.equals("NewContentName"+i)&&newContentFileName!=null&&newContentFileName!="") {
							//hidden값으로 숨겨놓은 
							String originalFileName=image_Info.get("originalContentName"+i);
							modify_Image_File(unityFile,file,newContentFileName,originalFileName,game_code);
						}
					}
					
				}//1&currentPageNo=1&recordsPerPage=10&searchType=ALL&searchKeyword=테스트
				message +="<script>";
				message +=" alert('수정을 완료했습니다..');";
				message +=" location.href='"+multirequest.getContextPath()
				+"/management/viwe_Detail.ddun?game_code="+game_code
				+"&currentPageNo="+currentPageNo+"&recordsPerPage="+recordsPerPage
				+"&searchType="+searchType+"&searchKeyword="+searchKeyword+"'; ";
				message +="</script>";
				
				resEnt =  new ResponseEntity<Object>(message, responseHeaders, HttpStatus.CREATED);
				
		} catch (Exception e) {
				message +="<script>";
				message +=" alert('오류가 발생했습니다.');";
				message +=" location.href='"+multirequest.getContextPath()
				+"/management/viwe_Detail.ddun?game_code="+game_code
				+"&currentPageNo="+currentPageNo+"&recordsPerPage="+recordsPerPage
				+"&searchType="+searchType+"&searchKeyword="+searchKeyword+"'; ";
				message +="</script>";
				
				resEnt =  new ResponseEntity<Object>(message, responseHeaders, HttpStatus.CREATED);
		}
		
		
		return resEnt;
		
	}
	
	@Override
	@PostMapping("/remove_Game_Info.ddun")
	public ResponseEntity<Object> remove_Game_Info(@RequestParam("game_code") String game_code,@RequestParam Map<String, String> info_For_Del) throws Exception{
		System.out.println("삭제할 게임정보 검색: "+game_code);
		
		String message=null;
		ResponseEntity<Object> resEnt = null;
		HttpHeaders responseHeaders = new HttpHeaders();
		responseHeaders.add("Content-Type", "text/html; charset=utf-8");
		
		try {
			//game_info_image 테이블에서 관련 정보 삭제
			management_Game_Service.delete_Game_Image_Info(game_code);
			
			//game_info 테이블에서 관련 정보 삭제
			management_Game_Service.delete_Game_Info(game_code);
			
			File imgDir = new File(IMAGE_REPO+"\\"+game_code);
			if(imgDir.exists()) {
				FileUtils.deleteDirectory(imgDir);
			}
			
			message +="<script>";
			message +=" alert('삭제를 완료했습니다.');";
			message +=" location.href='"+"/unicon/management/gamelist.ddun'; ";
			message +="</script>";
			
			resEnt =  new ResponseEntity<Object>(message, responseHeaders, HttpStatus.CREATED);
		} catch (Exception e) {
			message +="<script>";
			message +=" alert('오류가 발생했습니다.');";
			message +=" location.href='"+"/unicon/management/gamelist.ddun'; ";
			message +="</script>";
			
			resEnt =  new ResponseEntity<Object>(message, responseHeaders, HttpStatus.CREATED);
		}
		
		return resEnt;
		
	}
	
	//게임 리뷰 all
	@GetMapping("/gameReview.ddun")
	@Override
	public String manageGameReview(HttpServletRequest request,PagingDTO pagingDTO, Model model) throws Exception {
		List<Review_VO> reviewList = management_Game_Service.manageReviewWithPaging(pagingDTO);

		// 오늘 리스트
		//List<Review_VO> todayList = management_Game_Service.todayReview();

		// 페이징을 위한 전체 데이터 개수 확보
		int total_Record_Cnt = management_Game_Service.manageReviewWithPagingCount();

		model.addAttribute("reviewList", reviewList);
		model.addAttribute("pagingCreator", new PagingCreatorDTO(pagingDTO, total_Record_Cnt));

		//model.addAttribute("todayList", todayList);
		//request.setAttribute("page", "allReview");
		model.addAttribute("whatPage", "allReview.jsp");
		return "/management_game/review";
	}
	
	@GetMapping("/todayReview.ddun")
	@Override
	public String todayReview(HttpServletRequest request,Model model) throws Exception {
		// 오늘 리스트
		List<Review_VO> todayList = management_Game_Service.todayReview();
		System.out.println("으아아앙 ㅠㅠㅠㅠㅠ"+todayList.isEmpty());
		// 페이징을 위한 전체 데이터 개수 확보

		model.addAttribute("todayList", todayList);
		//request.setAttribute("page", "todayReview");
		model.addAttribute("whatPage", "todayReview.jsp");
		return "/management_game/review";
	}
	
	
	//게임 리뷰 날짜 검색
	@GetMapping("/searchDayReview.ddun")
	@Override
	public String searchDayReview(@RequestParam("startDay") String startDay,@RequestParam("endDay") String endDay,PagingDTO pagingDTO,Model model) throws Exception{
			System.out.println("startDay: "+startDay);
			System.out.println("endDay: "+endDay);
			System.out.println("currentPageNo: "+pagingDTO.getCurrentPageNo());
			System.out.println("recordsPerPage: "+pagingDTO.getRecordsPerPage());
			List<Review_VO> searchDaylist = management_Game_Service.searchDayReview(startDay, endDay, pagingDTO);
			System.out.println("리스트 있나요?"+searchDaylist.isEmpty());
			
			int total_Record_Cnt=management_Game_Service.searchDayReviewCount(startDay, endDay);
			
			System.out.println("내 데이터 내놔"+total_Record_Cnt);
			model.addAttribute("searchDaylist", searchDaylist);
			model.addAttribute("pagingCreator", new PagingCreatorDTO(pagingDTO, total_Record_Cnt));
			model.addAttribute("startDay", startDay);
			model.addAttribute("endDay", endDay);
			model.addAttribute("whatPage", "searchDayReview.jsp");
			return "/management_game/review";
			//return "/management_game/searchDayReview";
		}
	
	@PostMapping("/delReview.ddun")
	@Override
	public String delReview(@RequestParam Map<String, String> delReview) throws Exception{
	//public String delReview(@RequestParam("review_code") int review_code,@RequestParam("url") String url,@RequestParam("whatPage") String whatPage) throws Exception{
		/*System.out.println("review_code"+review_code);
		System.out.println("url"+url);
		System.out.println("whatPage"+whatPage);*/
		int review_code=Integer.valueOf(delReview.get("review_code"));
		String whatPage=delReview.get("whatPage");
		String url=delReview.get("url");
		String reurl="";
		management_Game_Service.deleteReview(review_code);
		if(whatPage.equals("all")) {
			reurl="redirect: /unicon"+url;
		}else if(whatPage.equals("today")) {
			reurl="redirect: /unicon"+url;
		}else if(whatPage.equals("search")) {
			reurl="redirect: /unicon"+url+"?startDay="+delReview.get("startDay")+"&endDay="+delReview.get("endDay");
		}
		
		return reurl;
		
	}
	
	@PostMapping("/overlapGame.ddun")
	@ResponseBody
	@Override
	public String overlapGame(@RequestParam("small_category") String small_category,@RequestParam("game_name") String game_name) throws Exception{
		System.out.println("small_category 중복 확인:"+small_category);
		System.out.println("결과 확인: "+game_name);
		String valueResult="";
		int result=management_Game_Service.overlapGame(game_name, small_category);
		if(result>=1) {
			valueResult="1";
		}else {
			valueResult="0";
		}
		System.out.println("중복?"+result);
		System.out.println("valueResult?"+valueResult);
		return valueResult;
	}
	
	//이미지 변경 메소드
	private void modify_Image_File(MultipartFile unityFile, File file, String newContentFileName,String originalFileName, String game_code) throws Exception{
		
		Info_Image_VO change_Image_VO = new Info_Image_VO();
		
		change_Image_VO.setOldimagefilename(originalFileName);
		change_Image_VO.setGame_code(game_code);
		change_Image_VO.setImagefilename(newContentFileName);
		
		management_Game_Service.update_Game_Image(change_Image_VO);
		
		try {
			if(unityFile.getSize()!=0) {
				if(!file.exists()) {
					if(file.getParentFile().mkdirs()) {
						file.createNewFile();
					}
				}
				unityFile.transferTo(new File(IMAGE_REPO+"\\"+"temp"+"\\"+newContentFileName));
			}
			
			File srtFile = new File(IMAGE_REPO+"\\"+"temp"+"\\"+newContentFileName);
			File destDir = new File(IMAGE_REPO+"\\"+game_code);
			FileUtils.moveFileToDirectory(srtFile, destDir, true);
			
			
			File deleteDir = new File(IMAGE_REPO+"\\"+game_code+"\\"+originalFileName);
			deleteDir.delete();
		}catch (Exception e) {
			File srtFile = new File(IMAGE_REPO+"\\"+"temp"+"\\"+newContentFileName);
			srtFile.delete();
		}
		
	}
	
	
	private List<String> upload(MultipartHttpServletRequest multirequest) throws Exception {
		List<String> fileList = new ArrayList<String>();
		Iterator<String> fileNames=multirequest.getFileNames();
		
		while(fileNames.hasNext()) {
			String fileName=fileNames.next();
			List<MultipartFile> mFileList=multirequest.getFiles(fileName);
			
			
			
			File file = new File(IMAGE_REPO+"\\"+fileName);
			
			for(MultipartFile mFile:mFileList) {
				String orginFileName=mFile.getOriginalFilename();
				System.out.println("upload메소드의 orginFileName 확인"+orginFileName);
				fileList.add(orginFileName);
				
				if(mFile.getSize()!=0) {
					if(!file.exists()) {
						if(file.getParentFile().mkdirs()) {
							file.createNewFile();
						}
					}
					mFile.transferTo(new File(IMAGE_REPO+"\\"+"temp"+"\\"+orginFileName));
				}
			}
		}
		return fileList;
	}
	
	@GetMapping(value = "/download.ddun")
	public void download(@RequestParam("imagefilename") String imagefilename, @RequestParam("game_code") String game_code, 
			HttpServletResponse response) throws Exception {
		
		System.out.println("이미지 확인중: "+imagefilename);
		System.out.println("이미지 확인중: "+game_code);
		
		OutputStream out = response.getOutputStream();
		String path =IMAGE_REPO+"\\"+game_code+"\\"+imagefilename;
		File imageFile = new File(path);
		response.setHeader("Cache-Control", "no-cache");
		response.addHeader("Content-disposition", "attachment;fileName="+imagefilename);
		FileInputStream in = new FileInputStream(imageFile);
		byte[] buffer = new byte[1024*8];
		while(true) {
			int count = in.read(buffer);
			if(count==-1)
				break;
			out.write(buffer, 0, count);
		}
		in.close();
		out.close();
	}
	
	
	 
}
