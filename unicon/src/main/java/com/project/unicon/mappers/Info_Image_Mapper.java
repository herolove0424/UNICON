package com.project.unicon.mappers;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.project.unicon.vo.Info_Image_VO;



@Mapper
public interface Info_Image_Mapper {
	//게임 이미지(로고 제외) 출력
	public List<Info_Image_VO> detail_Game_Image_Info(String game_code) throws Exception;
	
	//게임 로고 이미지 출력
	public Info_Image_VO detail_Game_Image_Logo_Info(String game_code) throws Exception;
	
	//게임 이미지 변경
	public void update_Game_Image(Info_Image_VO info_Image_VO) throws Exception;
	
	//게임 이미지 삭제
	public void delete_Game_Image_Info(String game_code) throws Exception;
	
	//리스트 로고 출력
	
	public List<Info_Image_VO> logolist() throws Exception;
	
}
