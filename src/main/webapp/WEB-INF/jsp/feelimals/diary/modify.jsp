<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<%@ include file="/WEB-INF/jsp/feelimals/common/head.jspf"%>
<%@ include file="/WEB-INF/jsp/feelimals/common/header.jspf"%>
<meta charset="UTF-8">
<title>일기 수정</title>
<script src="https://cdn.tailwindcss.com"></script>
</head>
<body class="bg-[#FAF7F5] min-h-screen">

	<main class="flex justify-center items-center py-16">
		<form action="/feelimals/diary/doModify" method="post" onsubmit="return DiaryModify__submit(this);" class="relative w-full max-w-2xl bg-[#FFF3E9] p-6 rounded-2xl shadow space-y-4">

			<input type="hidden" name="id" value="${diary.id}" />

			<!-- 질문 -->
			<div class="text-gray-600 text-lg font-medium">어떻게 바꾸고 싶어?</div>

			<!-- 일기 입력 -->
			<textarea name="body" rows="12"
				class="w-full p-4 rounded-md border border-transparent resize-none focus:outline-none focus:ring-2 focus:ring-orange-200">${diary.body}</textarea>

			<!-- 버튼 -->
			<div class="text-right space-x-2">
				<a href="/feelimals/diary/detail?id=${diary.id}" class="text-sm text-gray-500">취소</a>
				<button type="submit" class="bg-[#FFD8A1] px-5 py-2 rounded-full shadow hover:bg-[#ffc987] transition">이걸로
					할게</button>
			</div>

			<!-- 캐릭터 이미지 (우측 하단) -->
			<div class="absolute bottom-10 right-10 w-24 h-24 rounded-full bg-center bg-contain bg-no-repeat"
				style="background-image: url('/resource/images/animals/${sessionScope.user.characterImg}');"></div>
		</form>
	</main>
</body>
</html>
