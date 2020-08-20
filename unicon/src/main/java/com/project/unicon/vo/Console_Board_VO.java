package com.project.unicon.vo;

import java.sql.Timestamp;

import org.springframework.stereotype.Component;

import lombok.Getter;
import lombok.Setter;

// Console_게시판 VO

@Component("Console_Board_VO")
@Getter
@Setter
public class Console_Board_VO {
	
	private int boardNO;
	private String title;
	private String content;
	private Timestamp writeDate;
	private int viewCount;
	private int good;
	private String platform;
	private String id;
	private int parentNO;
	private int status;
	
}
