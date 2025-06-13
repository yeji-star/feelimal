package com.example.feel.vo;

import java.time.LocalDateTime;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class Calendar {

	private int id;
	private int memberId;
	private int emoTagId;
	private String regDate;
	private String updateDate;
	private String body;
	private boolean delStatus;
	private LocalDateTime delDate;
	
	
	
	private boolean isChat;
	

}
