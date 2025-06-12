<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<c:set var="pageTitle" value="일기 목록" />

<style>
  @keyframes fadeDrop {
    0% {
      transform: translateY(-20px);
      opacity: 0;
    }
    100% {
      transform: translateY(0);
      opacity: 1;
    }
  }

  .note-animate {
    animation: fadeDrop 0.6s ease-out forwards;
  }

  .note {
    background-color: #FFF9C4;
    padding: 1rem;
    border-radius: 0.5rem;
    box-shadow: 2px 2px 8px rgba(0, 0, 0, 0.1);
    width: 200px;
  }
</style>

<body class="bg-[#FAF7F5] min-h-screen">
  <!-- 메뉴바 -->
  <%@ include file="/WEB-INF/jsp/feelimals/common/head.jspf" %>

  <!-- 달 정보 + 리스트 + 캐릭터 -->
  <div class="flex justify-center gap-6 items-start px-10 pt-6">
    
    <!-- 일기 리스트 + 달 버튼 -->
    <div class="relative w-full max-w-5xl bg-[#FFF3E9] px-10 pt-8 pb-50 rounded-2xl shadow space-y-4">
      
      <!-- 달 버튼 (우측 상단) -->
      <div class="flex justify-end pr-2 mb-4">
        <button class="text-xs bg-[#FFD8A1] px-4 py-1 rounded-md shadow">20월</button>
      </div>

      <!-- 메모지 리스트 -->
      <div class="flex flex-wrap gap-4">
        <c:forEach var="diary" items="${diaries}" varStatus="loop">
          <div class="note note-animate" style="animation-delay: ${loop.index * 0.1}s">
            <div class="text-xs text-gray-500 mb-1">${diary.regDate}</div>
            <div class="text-sm text-gray-700">
              ${fn:substring(diary.body, 0, 50)}
              <c:if test="${fn:length(diary.body) > 50}">...</c:if>
            </div>
          </div>
        </c:forEach>

        <c:if test="${empty diaries}">
          <div class="text-gray-400 text-sm">아직 일기가 없어.</div>
        </c:if>
      </div>
    </div>

    <!-- 캐릭터 + 말풍선 (리스트 바로 오른쪽 하단) -->
    <div class="flex flex-col items-end self-end">
      <div class="text-xs text-gray-700 mb-1">최선을 다했구나</div>
      <img src="/resource/images/animals/${sessionScope.user.characterImg}" alt="캐릭터"
        class="w-16 h-16 object-contain" />
    </div>

  </div>
</body>
