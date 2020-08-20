package com.project.unicon.mappers;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.project.unicon.vo.All_Board_VO;
import com.project.unicon.vo.Console_Board_VO;
import com.project.unicon.vo.Free_Board_VO;
import com.project.unicon.vo.Jjim_VO;
import com.project.unicon.vo.Member_VO;
import com.project.unicon.vo.Mobile_Board_VO;
import com.project.unicon.vo.Pc_Board_VO;

import common.paging.PagingDTO;

@Mapper
public interface Member_Mapper {
	public Member_VO loginById(Member_VO member) throws Exception;
	
	public Member_VO getinforecomende(Member_VO member) throws Exception;

	public String getplaytype(String id) throws Exception;
	
	public String getsmallcategory(String id) throws Exception;
	
	public void insertMember(Member_VO member) throws Exception;

	public int selectOverlappedID(String id) throws Exception;
	
	public int selectOverlappedNCIKNAME(String nickname) throws Exception;
	
	public int selectOverlappedEMAIL(String email) throws Exception;

	public int selectOverlappedPHONE(String phone_number) throws Exception;

	public String findid(Member_VO member);
	
	public String findpw(Member_VO member) throws Exception;

	public void pwfind2(Member_VO membervo) throws Exception;

	public String mypagepw(Member_VO member) throws Exception;
	
	public String gethp(String id) throws Exception;

	public void modify(Member_VO modmember) throws Exception;

	public void pwmodify(Member_VO membervo) throws Exception;
	
	//--- 0706 김도경 추가--
	//로그인 창에서 받은 아이디/비밀번호가 db에 있는 관리자 계정인지 확인
	public Member_VO loginInfo(Member_VO member_Info) throws Exception;
		
	//검색 조건으로 회원 정보 검색
	public List<Member_VO> member_Search(Map<String, String> search_Info) throws Exception;
		
	//id로 회원 상세 정보 검색
	public Member_VO member_Detail_Search(String id) throws Exception;
	
	//--- 0706 김도경 추가 끝--
	
	//--0728 김도경 추가--
	//id 중복체크
	public int manager_Id_Check(String id) throws Exception;
		
	//휴대폰번호 충복 체크
	public int manager_Phone_Check(String id) throws Exception;
		
	//manager닉네임 순번 지정을 위한 시퀀스
	public int manager_Seq_Num() throws Exception;
		
	//manager 관리 계정 생성
	public void insertManagerMember(Member_VO member) throws Exception;
		
	//권한 생성시 비밀번호 확인
	public int confirm_Password(Map<String, String> values) throws Exception;
		
	//관리자 계정 리스트로 가져오기
	public List<Member_VO> selectAuthorList() throws Exception;
		
	//관리자 계정 삭제
	public void deleteAuthor(String id) throws Exception;
		
	//관리자 초기 비밀번호 변경
	public void updateAuthorPw(@Param("id") String id, @Param("password") String password) throws Exception;
	
	//--0728 김도경 추가 끝--
	
	public int makeKey(@Param("id") String id, @Param("key") String key) throws Exception;
	
	public int change_Key(@Param("id")String id, @Param("key") String key) throws Exception;
	
	public Integer email_check(@Param("id")String id) throws Exception;
	
	public void recommendinsert(Member_VO member) throws Exception;
	
	public void recommendmodify(Member_VO memberVO) throws Exception;
	
	/*김도경 0802 2차 통합 중 변경*/
	//관리자 권한 변경
	public void modifyAuthor(@Param("id") String id,@Param("grade") int grade) throws Exception;
	//회원삭제
	public void removemember(String id) throws Exception;

	public void removemember2(String id) throws Exception;
	//댓글관리
	public List<Map> reply(@Param("id")String id) throws Exception;
	
	public List<Map> freeboardReply(@Param("id")String id) throws Exception;
	
	public List<Map> pcboardReply(@Param("id")String id) throws Exception;
	
	public List<Map> mobileboardReply(@Param("id")String id) throws Exception;

	public List<Map> consoleboardReply(@Param("id")String id) throws Exception;
	
	public List<Pc_Board_VO> pcboard(@Param("id")String id) throws Exception;
	
	public List<Console_Board_VO> consoleboard(@Param("id")String id) throws Exception;
		
	public List<Mobile_Board_VO> mobileboard(@Param("id")String id) throws Exception;
		
	public List<Free_Board_VO> freeboard(@Param("id")String id) throws Exception;
	
	public int getjjim(Jjim_VO jjimvo) throws Exception;
	
	public void insertjjim(Jjim_VO jjimvo) throws Exception;
	
	public void deletejjim(Jjim_VO jjimvo) throws Exception;
	
	public List<Jjim_VO> jjimlist(@Param("id")String id) throws Exception;
	
	//0804 김도경 추가
	public List<All_Board_VO> memberActivityList(PagingDTO pagingDTO) throws Exception;
	public int memberActivityTotalRows(String id) throws Exception;
	public int searchFreeboard(All_Board_VO searchBoard) throws Exception; 
	public int searchMobileboard(All_Board_VO searchBoard) throws Exception; 
	public int searchPcboard(All_Board_VO searchBoard) throws Exception; 
	public int searchConsoleboard(All_Board_VO searchBoard) throws Exception; 
	//0804 김도경 추가 끝
	
	//0805 김도경 추가
	public void deleteMemberActFreeBoard(All_Board_VO delBoard) throws Exception;
	public void deleteMemberActMobileBoard(All_Board_VO delBoard) throws Exception;
	public void deleteMemberActPcBoard(All_Board_VO delBoard) throws Exception;
	public void deleteMemberActConsoleBoard(All_Board_VO delBoard) throws Exception;
	//0805 김도경 추가 끝
	
	// 0810 김도경 추가
	public int countNewMember() throws Exception;
	public int countLastDayNewMember() throws Exception;
	public void setVisitTotalCount() throws Exception;
	public int getVisitTodayCount() throws Exception;
	public int getLastVisitCount() throws Exception;
	public List<Member_VO> newMemberList() throws Exception;
	
	// 0812 이메일 재전송 및 재설정
	public String getEmail(@Param("id")String id) throws Exception;

	public void changeEmail(@Param("id")String id, @Param("email") String email);
	
}
