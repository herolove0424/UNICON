package com.project.unicon.vo;

import java.sql.Timestamp;

import org.springframework.stereotype.Component;

import lombok.Getter;
import lombok.Setter;

// Mobile_게시판 VO

@Component("Mobile_Board_VO")
@Getter
@Setter
public class Mobile_Board_VO {
	
	private int boardNO;
	private String title;
	private String content;
	private Timestamp writeDate;
	private int viewCount;
	private int good;
	private String id;
	private int parentNO;
	
}
