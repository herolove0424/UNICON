package com.project.unicon.vo;

import java.sql.Timestamp;

import org.springframework.stereotype.Component;

import lombok.Getter;
import lombok.Setter;

@Component("Mobile_Board_Reply_VO")
@Getter
@Setter
public class Mobile_Board_Reply_VO {
	
	private int level;
	private int rep_boardNO;
	private String rep_content;
	private Timestamp rep_writeDate;
	private int rep_good;
	private String rep_id;
	private int rep_parentNO;
	private int daedatNO;
	
}
