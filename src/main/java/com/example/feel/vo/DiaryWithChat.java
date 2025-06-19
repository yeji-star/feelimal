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
public class DiaryWithChat {

	private int id;
	private int memberId;
	private int emoTagId;
	private Integer sessionId; // integer 여야만 null이 가능
	private String regDate;
	private String updateDate;
	private String body;
	private boolean delStatus;
	private LocalDateTime delDate;
	
	private Boolean thisChat;
	private String writer;
	
	private String aiReply;
	private String aiModel;
	private String aiReplyRegDate;
	
	private boolean userCanModify;
	private boolean userCanDelete;

}
