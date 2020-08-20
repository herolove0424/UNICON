package com.project.unicon.vo;

import java.sql.Timestamp;

import org.springframework.stereotype.Component;

import lombok.Getter;
import lombok.Setter;

@Component("message_VO")
@Getter
@Setter
public class Message_Box_VO {
	private String id;
	private String title;
	private String content;
	private String send_id;
	private int readyn;
	private Timestamp sendday;
	private int messagenum;
	private int exposeyn;
}
