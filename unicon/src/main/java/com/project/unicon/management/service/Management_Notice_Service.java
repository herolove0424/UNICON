package com.project.unicon.management.service;

import java.util.List;

import com.project.unicon.vo.Admin_Notice_VO;

import common.paging.PagingDTO;

public interface Management_Notice_Service {
	public void add_Notice(Admin_Notice_VO admin_Notice_VO) throws Exception;
	public List<Admin_Notice_VO> bring_Notice_List(PagingDTO pagingDTO) throws Exception;
	public int allNoticeRows(PagingDTO pagingDTO) throws Exception;
	public void noticeViewCount(int boardno) throws Exception;
	public Admin_Notice_VO detailNotice(int boardno) throws Exception;
	public void modNoticeService(Admin_Notice_VO admin_Notice_VO) throws Exception;
	public void delNotice(int boardno) throws Exception;
}
