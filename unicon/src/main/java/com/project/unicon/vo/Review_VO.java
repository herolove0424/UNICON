package com.project.unicon.vo;

import java.sql.Timestamp;

import org.springframework.stereotype.Component;

import lombok.EqualsAndHashCode;
import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@EqualsAndHashCode
@ToString
@Component("review_VO")
public class Review_VO {
	private int review_code;
	private String game_code;
	private String id;
	private String content;
	private Timestamp writedate;
	private int score;
	private int goods_count;	
}