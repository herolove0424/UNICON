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
@Component("info_VO")
public class Info_VO {
	private String id;
	private String game_code;
	private String game_name;
	private String big_category;
	private String small_category;
	private String genre;
	private Timestamp release_date;
	private String st_release_date;
	private String price;
	private String age;
	private String min_system;
	private String recommen_system;
	private Timestamp registered_date;
	private String menufacture;
	private String share_company;
	private String content;
	private String link_1;
	private String link_2;
	private String link_3;
	private String link_4;
	private String hash_tag;
	private String hash_tag2;
	private String hash_tag3;
	private int votes;
	private int rownum;
	private String vote1;
	private String vote2;
	private String vote3;
	private String play_type;
}