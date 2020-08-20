package com.project.unicon.vo;

import java.sql.Timestamp;

import org.springframework.stereotype.Component;

import lombok.Getter;
import lombok.Setter;

@Component("MyWall_Reply_VO")
@Getter
@Setter
public class MyWall_Reply_VO {
	
	private int rep_boardNO;
	private String rep_content;
	private String rep_id;
	private Timestamp rep_writeDate;
	private int rep_parentNO;
	
}
