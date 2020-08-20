package com.project.unicon.vo;
//공지사항

import java.sql.Timestamp;

import org.springframework.stereotype.Component;

import lombok.Getter;
import lombok.Setter;

@Component("notice_VO")
@Getter
@Setter
public class Admin_Notice_VO {
	private int boardno;
	private String title;
	private String content;
	private Timestamp writedate;
	private int viewcount;
	private int exposal;
	private String id;
/*
 BOARDNO	NUMBER(5,0)
TITLE	VARCHAR2(30 BYTE)
CONTENT	CLOB
WRITEDATE	TIMESTAMP(6)
VIEWCOUNT	NUMBER(5,0)
EXPOSAL	NUMBER(1,0)
 */

	
}
