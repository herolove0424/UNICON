package com.project.unicon.vo;

import java.sql.Timestamp;
import java.util.List;

import org.springframework.stereotype.Component;

import lombok.EqualsAndHashCode;
import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@EqualsAndHashCode
@ToString
@Component("memberVO")
public class Member_VO {
	private String id;
	private String password;
	private String nickname;
	private String phone_number;
	private String email;
	/* 추가 */
	private String email_add2;
	private String phone_number1;
	private String phone_number2;
	private String phone_number3;
	/* 추가 */
	
	private Timestamp join_date;
	private String del_date;
	private int grade;
	private String name;
	private String birthday;
	private String sex;
	private String play_type;
	private String[] genre;
	private String[] hash_tag;
	private String small_category;
	private String genre1;
	private String genre2;
	private String hashtag1;
	private String hashtag2;
	private String hashtag3;
	private String imageFileName;
	private String originalFileName;
}