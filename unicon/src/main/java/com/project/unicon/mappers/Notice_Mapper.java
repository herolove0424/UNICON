package com.project.unicon.mappers;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.project.unicon.vo.Admin_Notice_VO;

import common.paging.PagingDTO;

@Mapper
public interface Notice_Mapper {
	//공지사항 번호 가져오기
	public int noticeBoardNo() throws Exception;
	
	//공지사항 등록
	public void noticeInsert(Admin_Notice_VO admin_Notice_VO) throws Exception;
	
	//페이징 총 행 갯수
	public int AllNoticeRows(PagingDTO pagingDTO) throws Exception;
	
	//페이징 처리 리스트
	public List<Admin_Notice_VO> selectAllNoticeSearchedBoardsWithPaging(PagingDTO pagingDTO) throws Exception;
	
	//VIEWCOUNT
	public void noticeViewCount(int boardno) throws Exception;
	
	//notice 세부 내용 보기
	public Admin_Notice_VO detailNotice(int boardno) throws Exception;
	
	//공지 수정
	public void modNotice(Admin_Notice_VO admin_Notice_VO) throws Exception;
	
	//공지 삭제
	public void delNotice(int boardno) throws Exception;
	
	// 어제 등록된 게시글
	public int todayRegistBoard() throws Exception;
	public int lastDayRegistBoard() throws Exception;
}
