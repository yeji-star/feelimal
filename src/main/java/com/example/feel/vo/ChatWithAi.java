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
    private String body;
    private boolean isChat;
    private int emoTagId;
    private String regDate;

    // aiReply
    private String reply;
    private String model;
    private String aiRegDate;

}
