package com.project.unicon.management.service;

import java.util.List;
import java.util.Map;

import com.project.unicon.vo.All_Board_VO;
import com.project.unicon.vo.Member_VO;

import common.paging.PagingDTO;

public interface Management_Search_Service {
	
	public List<Member_VO> management_Member_Search(Map<String, String> search_Info) throws Exception;
	public Member_VO management_Detail_Search(String id) throws Exception;
	public List<All_Board_VO> memberActivityList(PagingDTO pagingDTO) throws Exception;
	public int searchMembersBoard(All_Board_VO searchBoard) throws Exception;
	public int memberActivityTotalRows(String id) throws Exception;
	public void deleteMemberActBoard(All_Board_VO delBoard) throws Exception;
	public List<Member_VO> newMemberList() throws Exception;
}
