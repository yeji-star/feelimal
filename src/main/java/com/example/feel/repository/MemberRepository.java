package com.example.feel.repository;

import org.apache.ibatis.annotations.Mapper;

import com.example.feel.vo.Member;

@Mapper
public interface MemberRepository {

	public void doJoin(String loginId, String loginPw, String nickname, String email);

	public Member getMemberByLoginId(String loginId);

	public int getLastInsertId();

	public Member getMemberById(int id);

}
