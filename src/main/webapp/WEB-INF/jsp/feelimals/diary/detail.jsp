<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<%@ include file="/WEB-INF/jsp/feelimals/common/head.jspf"%>
<%@ include file="/WEB-INF/jsp/feelimals/common/header.jspf"%>

<body class="bg-[#FAF7F5] min-h-screen">


	<!-- 본문 -->
	<div class="relative px-6 py-12 ">
		<!-- 일기 내용 박스 -->

		<div class="relative bg-[#FFF3E9] p-6 rounded-2xl w-[80%] max-w-2xl mx-auto shadow-md min-h-[350px]">
			<c:if test="${diary.userCanModify}">
				<button onclick="toggleEditMenu()" class="absolute top-4 right-4 hover:opacity-80 transition"
					style="color: #FFA726; font-size: 21px;">☰</button>
				<div id="editMenu"
					class="absolute top-4 right-4 px-3 py-2 rounded-xl text-base shadow space-y-1 hidden border transition-all"
					style="background-color: #FFD8A1; border-color: #FDC78A;">

					<button onclick="toggleEditMenu()" class="float-right text-sm font-bold" style="color: #FB8C00;">✕</button>
					<br>
					<a href="/feelimals/diary/modify?id=${diary.id}" class="block text-center py-1 rounded font-semibold transition"
						style="color: #FB8C00;">수정</a>
					<a href="/feelimals/diary/doDelete?id=${diary.id}" onclick="return confirm('정말 삭제할까?');"
						class="block text-center py-1 rounded font-semibold transition" style="color: #E53935;">삭제</a>
				</div>
			</c:if>
			<div class="text-gray-800 text-base whitespace-pre-line">${diary.body}</div>

			<!-- 그만 볼래 버튼 -->
			<div class="absolute bottom-4 right-4">
				<a href="/feelimals/chatDiary/list" class="bg-[#FFD8A1] px-3 py-1 rounded-md shadow text-sm">그만 볼래</a>
			</div>
		</div>

		<!-- 캐릭터 이미지 -->
		<div class="absolute bottom-6 right-6">
			<img src="/resource/images/animals/${sessionScope.user.characterImg}" class="w-20 h-20 object-contain" />
		</div>
	</div>
</body>
