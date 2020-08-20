package com.project.unicon.management.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.project.unicon.mappers.Member_Mapper;
import com.project.unicon.mappers.Notice_Mapper;
import com.project.unicon.mappers.Review_Mapper;
import com.project.unicon.vo.Member_VO;


@Service("management_Service")
@Transactional(propagation = Propagation.REQUIRED)
public class Management_ServiceImpl implements Management_Service{
	
	@Autowired
	private Member_Mapper member_Mapper;
	
	@Autowired
	private Notice_Mapper notice_Mapper;
	
	@Autowired
	private Review_Mapper review_Mapper;
	
	//login.do에서 사용
	@Override
	public Member_VO management_Login(Member_VO member_Info) throws Exception {
		return member_Mapper.loginInfo(member_Info);
	}
	
	@Override
	public int countNewMember() throws Exception{
		return member_Mapper.countNewMember();
	}

	@Override
	public int countLastDayNewMember() throws Exception {
		return member_Mapper.countLastDayNewMember();
	}

	@Override
	public int getVisitTodayCount() throws Exception {
		return member_Mapper.getVisitTodayCount();
	}

	@Override
	public int getLastVisitCount() throws Exception {
		return member_Mapper.getLastVisitCount();
	}
	
	@Override
	public int todayRegistBoard() throws Exception {
		return notice_Mapper.todayRegistBoard();
	}

	@Override
	public int lastDayRegistBoard() throws Exception {
		return notice_Mapper.lastDayRegistBoard();
	}

	@Override
	public int todayReviewCount() throws Exception {
		return review_Mapper.todayReviewCount();
	}

	@Override
	public int lastDayReviewCount() throws Exception {
		return review_Mapper.lastDayReviewCount();
	}

}
