package com.project.unicon.vo;

import java.sql.Timestamp;

import org.springframework.stereotype.Component;

import lombok.Getter;
import lombok.Setter;

// PC_게시판 VO

@Component("Free_Board_VO")
@Getter
@Setter
public class Free_Board_VO {
	
	private int boardNO;
	private String title;
	private String content;
	private Timestamp writeDate;
	private int viewCount;
	private int good;
	private String id;
	private int parentNO;
	
}
