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
    private int sessionId;
    private String body;
    private String regDate;
    private String updateDate;
    private boolean delStatus;
    private LocalDateTime delDate;
	
	private boolean thisChat;
	
	private boolean userCanDelete;

}
