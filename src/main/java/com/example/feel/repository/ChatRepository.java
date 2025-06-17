package com.example.feel.repository;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.example.feel.vo.Chat;

@Mapper
public interface ChatRepository {

	public void writeUserMessage(int memberId, String body, boolean b);

	public int getLastInsertId();

	public void writeAiReply(int chatId, String reply, String model);

	public Chat getChatById(int chatId);

	public List<Chat> getListByMemberId(int memberId);
}

