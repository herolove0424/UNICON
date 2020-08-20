package com.project.unicon.vo;

import org.springframework.stereotype.Component;

import lombok.EqualsAndHashCode;
import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@EqualsAndHashCode
@ToString
@Component("friend_VO")
public class TimeLine_VO {
	private String id_1;
	private String id_2;
	private int status;
	private int count;
	private String nickname;
	private String id;
	private String imageFileName;
}