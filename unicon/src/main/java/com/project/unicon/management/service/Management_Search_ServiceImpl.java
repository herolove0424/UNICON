package com.project.unicon.management.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.project.unicon.mappers.Member_Mapper;
import com.project.unicon.vo.All_Board_VO;
import com.project.unicon.vo.Member_VO;

import common.paging.PagingDTO;

@Service("management_search_Service")
@Transactional(propagation = Propagation.REQUIRED)
public class Management_Search_ServiceImpl implements Management_Search_Service{
	
	@Autowired
	private Member_Mapper member_Mapper;

	@Override
	public List<Member_VO> management_Member_Search(Map<String, String> search_Info) throws Exception {
		List<Member_VO> resultMember = member_Mapper.member_Search(search_Info);
		return resultMember;
	}

	@Override
	public Member_VO management_Detail_Search(String id) throws Exception {
		return member_Mapper.member_Detail_Search(id);
	}
	
	@Override
	public int memberActivityTotalRows(String id) throws Exception{
		return member_Mapper.memberActivityTotalRows(id);
	}
	
	@Override
	public List<All_Board_VO> memberActivityList(PagingDTO pagingDTO) throws Exception{
		return member_Mapper.memberActivityList(pagingDTO);
	}
	
	@Override
	public int searchMembersBoard(All_Board_VO searchBoard) throws Exception{
		//어느 게시판에 있는지 status로 확인
		int searchStatus=searchBoard.getStatus();
		
		//controller에서 url처리를 위한 status변수 선언
		int status = 0;
		
		if(searchStatus==1) {
			int temp =member_Mapper.searchFreeboard(searchBoard);
			if(temp==1) {
				status=1;
			}else {
				status=0;
			}
			
		}else if(searchStatus==2) {
			int temp =member_Mapper.searchMobileboard(searchBoard);
			
			if(temp==1) {
				status=2;
			}else {
				status=0;
			}
			
			
		}else if(searchStatus==3) {
			int temp =member_Mapper.searchPcboard(searchBoard);
			if(temp==1) {
				status=3;
			}else {
				status=0;
			}
		}else if(searchStatus==4) {
			int temp =member_Mapper.searchConsoleboard(searchBoard);
			if(temp==1) {
				status=4;
			}else {
				status=0;
			}
		}
		
		return status;
	}
	
	@Override
	public void deleteMemberActBoard(All_Board_VO delBoard) throws Exception{
		int status=delBoard.getStatus();
		
		if(status==1) {
			member_Mapper.deleteMemberActFreeBoard(delBoard);
		}else if(status==2) {
			member_Mapper.deleteMemberActMobileBoard(delBoard);
		}else if(status==3) {
			member_Mapper.deleteMemberActPcBoard(delBoard);
		}else if(status==4) {
			member_Mapper.deleteMemberActConsoleBoard(delBoard);
		}
	}
	
	@Override
	public List<Member_VO> newMemberList() throws Exception {
		return member_Mapper.newMemberList();
	}

}
