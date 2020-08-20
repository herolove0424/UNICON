package com.project.unicon.member.service;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import com.project.unicon.vo.Console_Board_VO;
import com.project.unicon.vo.Free_Board_VO;
import com.project.unicon.vo.Jjim_VO;
import com.project.unicon.vo.Member_VO;
import com.project.unicon.vo.Mobile_Board_VO;
import com.project.unicon.vo.Pc_Board_VO;

public interface MemberService {
	public Member_VO login(Member_VO member) throws Exception;
	
	public void addMember(Member_VO member) throws  Exception;

	public int overlapped(String id) throws Exception;
	
	public int overlappednick(String nickname) throws Exception;
	
	public int overlappedemail(String email) throws Exception;
	
	public int overlappedphone(String phone_number) throws Exception;

	public String findid(Member_VO member) throws Exception;

	public String findpw(Member_VO member) throws Exception;

	public void pwfind2(Member_VO membervo) throws Exception;

	public String mypagepw(Member_VO member) throws Exception;

	public String gethp(String id) throws Exception;

	public void modify(Member_VO modmember) throws Exception;

	public void pwmodify(Member_VO membervo) throws Exception;
	
public void mailsendkey(String email, String id, HttpServletRequest request) throws Exception;
	
	public int change_Key(String id, String key) throws Exception;
	
	public Integer email_check(String id) throws Exception;
	
	public void recommendinsert(Member_VO member) throws Exception;
	
	public void recommendmodify(Member_VO memberVO) throws Exception;
	
	public void removemember(String id) throws Exception;
	
	public List<Map> reply(String id) throws Exception;
	
	public List<Map> freeboardReply(String id) throws Exception;
	
	public List<Map> pcboardReply(String id) throws Exception;
	
	public List<Map> mobileboardReply(String id) throws Exception;
	
	public List<Map> consoleboardReply(String id) throws Exception;
	
	public List<Pc_Board_VO> pcboard(String id) throws Exception;
	
	public List<Console_Board_VO> consoleboard(String id) throws Exception;
		
	public List<Mobile_Board_VO> mobileboard(String id) throws Exception;
		
	public List<Free_Board_VO> freeboard(String id) throws Exception;
		
	public int getjjim(Jjim_VO jjimvo)throws Exception;
		
	public void insertjjim(Jjim_VO jjimvo) throws Exception;

	public void deletejjim(Jjim_VO jjimvo) throws Exception;
		
	public List<Jjim_VO> jjimlist(String id) throws Exception;
	
	public void setVisitTotalCount() throws Exception;
	

	public void requestSend(String id, String email, HttpServletRequest request) throws Exception;
	
	public String getEmail(String id) throws Exception;
	
	public void changeEmail(String id, String email);
}