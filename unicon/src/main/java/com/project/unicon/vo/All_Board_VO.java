package com.project.unicon.vo;

import java.sql.Timestamp;

import org.springframework.stereotype.Component;

import lombok.Getter;
import lombok.Setter;

//member상세 조회 시, 해당 계정이 쓴 글을 조회하기 위한 vo
@Component("All_Board_VO")
@Getter
@Setter
public class All_Board_VO {
	private int boardNO;
	private String title;
	private String content;
	private Timestamp writeDate;
	private int viewCount;
	private int good;
	private String id;
	private int parentNO;
	private int status;
	private String platform;
}
