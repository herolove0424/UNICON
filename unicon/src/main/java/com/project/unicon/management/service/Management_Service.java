package com.project.unicon.management.service;

import com.project.unicon.vo.Member_VO;

public interface Management_Service {
	
	public Member_VO management_Login(Member_VO member_Info) throws Exception;
	public int countNewMember() throws Exception;
	public int countLastDayNewMember() throws Exception;
	public int getVisitTodayCount() throws Exception;
	public int getLastVisitCount() throws Exception;
	public int todayRegistBoard() throws Exception;
	public int lastDayRegistBoard() throws Exception;
	public int todayReviewCount() throws Exception;
	public int lastDayReviewCount() throws Exception;

}
