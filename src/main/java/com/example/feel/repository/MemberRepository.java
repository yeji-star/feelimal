package com.example.feel.repository;

import org.apache.ibatis.annotations.Mapper;

import com.example.feel.vo.Member;

@Mapper
public interface MemberRepository {

	void doJoin(String loginId, String loginPw, String nickname);

	Member getMemberByLoginId(String loginId);

}
