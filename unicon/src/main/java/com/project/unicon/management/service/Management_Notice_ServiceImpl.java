package com.project.unicon.management.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.project.unicon.mappers.Notice_Mapper;
import com.project.unicon.vo.Admin_Notice_VO;

import common.paging.PagingDTO;

@Service("management_Notice_Service")
@Transactional(propagation = Propagation.REQUIRED)
public class Management_Notice_ServiceImpl implements Management_Notice_Service{
	
	@Autowired
	private Notice_Mapper notice_Mapper;
	
	//공지등록
	@Override
	public void add_Notice(Admin_Notice_VO admin_Notice_VO) throws Exception {
		// TODO Auto-generated method stub
		
		int boardNo=notice_Mapper.noticeBoardNo();
		admin_Notice_VO.setBoardno(boardNo);
		
		notice_Mapper.noticeInsert(admin_Notice_VO);
		
	}
	
	//공지 리스트 출력
	@Override
	public List<Admin_Notice_VO> bring_Notice_List(PagingDTO pagingDTO) throws Exception{
		System.out.println("확인중입니다1: "+pagingDTO.getCurrentPageNo());
		return notice_Mapper.selectAllNoticeSearchedBoardsWithPaging(pagingDTO);
	}
	
	//총 게시글 수
	@Override
	public int allNoticeRows(PagingDTO pagingDTO) throws Exception {
		return notice_Mapper.AllNoticeRows(pagingDTO);
	}
	
	//조회수 증가
	@Override
	public void noticeViewCount(int boardno) throws Exception{
		notice_Mapper.noticeViewCount(boardno);
	}
	
	//상세 보기
	@Override
	public Admin_Notice_VO detailNotice(int boardno) throws Exception{
		return notice_Mapper.detailNotice(boardno);
	}
	
	//수정하기
	@Override
	public void modNoticeService(Admin_Notice_VO admin_Notice_VO) throws Exception{
		notice_Mapper.modNotice(admin_Notice_VO);
	}
	
	//삭제하기
	@Override
	public void delNotice(int boardno) throws Exception{
		notice_Mapper.delNotice(boardno);
	}

}
