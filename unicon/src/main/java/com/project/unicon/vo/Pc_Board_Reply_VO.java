package com.project.unicon.vo;

import java.sql.Timestamp;

import org.springframework.stereotype.Component;

import lombok.Getter;
import lombok.Setter;

//2020.07.27 댓글 구성에 필요한 테이블 추가해서 VO도 추가함.

@Component("Pc_Board_Reply_VO")
@Getter
@Setter
public class Pc_Board_Reply_VO {
	
	private int level;
	private int rep_boardNO;
	private String rep_content;
	private Timestamp rep_writeDate;
	private int rep_good;
	private String rep_id;
	private int rep_parentNO;
	private int daedatNO;
	
}
