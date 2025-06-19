<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<%@ include file="/WEB-INF/jsp/feelimals/common/head.jspf"%>
<%@ include file="/WEB-INF/jsp/feelimals/common/header.jspf"%>
<title>대화 상세보기</title>
<link rel="stylesheet" href="/resource/style.css">
<style>
body {
	background-color: #FAF7F5;
	font-family: 'Lato', sans-serif;
	margin: 0;
}

.chat-container {
	max-width: 600px;
	margin: 0 auto;
	padding: 1rem;
	position: relative;
	display: flex;
	flex-direction: column;
	height: 90vh;
}

.chat-box {
	flex: 1;
	overflow-y: auto;
	display: flex;
	flex-direction: column;
	gap: 0.5rem;
	padding: 1rem 0;
}

.msg {
	display: inline-block;
	max-width: 70%;
	padding: 0.75rem 1rem;
	border-radius: 1rem;
	word-break: break-word;
	font-size: 0.95rem;
}

.msg.him {
	background-color: #e0e0e0;
	align-self: flex-start;
	border-bottom-left-radius: 0.2rem;
}

.msg.you {
	background-color: #FFD8B1;
	align-self: flex-end;
	border-bottom-right-radius: 0.2rem;
}

.chat-input {
	display: flex;
	gap: 0.5rem;
	padding-top: 1rem;
}

.chat-input input {
	flex: 1;
	padding: 0.5rem 1rem;
	font-size: 1rem;
	border: 1px solid #ccc;
	border-radius: 1rem;
}

.chat-input button {
	background-color: #FFA726;
	border: none;
	padding: 0.5rem 1rem;
	border-radius: 1rem;
	cursor: pointer;
	color: white;
}
</style>
</head>
<body class="bg-[#FAF7F5] min-h-screen">

	<div class="chat-container">
		<div class="chat-box" id="chatBox">
			<!-- 캐릭터가 먼저 말하기 -->
			<div class="msg him">오늘 무슨 일이 있었어?</div>
		</div>

		<c:forEach var="item" items="${messages}">
			<c:choose>
				<c:when test="${item.isChat}">
					<div class="msg you">${item.body}</div>
				</c:when>
				<c:otherwise>
					<div class="msg him">${item.reply}</div>
				</c:otherwise>
			</c:choose>
		</c:forEach>
	</div>

	<!-- 버튼 -->
	<div class="btn-group">
		<a href="/feelimals/chatDiary/list" class="btn">목록</a>
		<td style="text-align: center;">
			<c:if test="${chat.userCanDelete }">
				<a class="btn btn-outline btn-xs btn-error" onclick="if(confirm('정말 삭제할 거야?') == false) return false;"
					href="../chat/deleteChat?id=${id }">삭제</a>
			</c:if>
		</td>
	</div>
	</div>

	<script>
		function sendMessage() {
			const input = document.getElementById("userInput");
			const message = input.value.trim();
			if (message === "")
				return;

			const chatBox = document.getElementById("chatBox");
			const userMsg = document.createElement("div");
			userMsg.className = "msg you";
			userMsg.textContent = message;
			chatBox.appendChild(userMsg);

			input.value = "";

			// 스크롤 맨 아래로
			chatBox.scrollTop = chatBox.scrollHeight;
		}

		// 엔터로도 전송
		document.getElementById("userInput").addEventListener("keydown",
				function(e) {
					if (e.key === "Enter") {
						e.preventDefault();
						sendMessage();
					}
				});
	</script>

</body>
</html>
