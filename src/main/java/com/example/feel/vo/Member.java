package com.example.feel.vo;

import java.time.LocalDateTime;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class Member {

	public Member(String loginId, String loginPw, String nickname) {
		this.loginId = loginId;
		this.loginPw = loginPw;
		this.nickname = nickname;
	}

	private int id;
	private String regDate;
	private String updateDate;
	private String loginId;
	private String loginPw;
	private String nickname;
	private boolean delStatus;
	private LocalDateTime delDate;

}
