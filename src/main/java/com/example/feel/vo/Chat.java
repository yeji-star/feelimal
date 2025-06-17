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
public class Chat {

	private int id;
	private int memberId;
	private int emoTagId;
	private int chatdiaryId;
	private String reply;
	private String regDate;
	private String updateDate;
	private String body;
	private String model;
	private boolean delStatus;
	private LocalDateTime delDate;
	
	private boolean isChat;

}
