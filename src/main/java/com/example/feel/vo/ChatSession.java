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
public class ChatSession {

	private int id;
    private int memberId;
    private String title;
    private String regDate;
    private String updateDate;
    private boolean delStatus;
    private LocalDateTime delDate;

    private boolean userCanDelete;
}
