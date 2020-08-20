package com.project.unicon.vo;

import java.sql.Timestamp;

import org.springframework.stereotype.Component;

import lombok.Getter;
import lombok.Setter;

@Component("info_Image_VO")
@Getter
@Setter
public class Info_Image_VO {
	
	private int imagefileno;
	private String imagefilename;
	private Timestamp regdate;
	private String game_code;
	private int logo_status;
	private String oldimagefilename;

}
