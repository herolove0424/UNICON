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
@Component("jjimVO")
public class Jjim_VO {
	private String id;
	private String game_code;
	private String game_name;
	private String small_category;
}
