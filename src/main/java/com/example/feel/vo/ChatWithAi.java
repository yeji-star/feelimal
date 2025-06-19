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
public class ChatWithAi {

    // chatDiary
    private int id;
    private int memberId;
    private int sessionId;
    private String body;
    private boolean thisChat;
    private int emoTagId;
    private String regDate;

    // aiReply
    private String aiReply;
    private String model;
    private String aiRegDate;

}
