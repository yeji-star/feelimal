<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<!-- 상단 메뉴 -->
<%@ include file="/WEB-INF/jsp/feelimals/common/head.jspf"%>
<meta charset="UTF-8">
<title>${pageTitle}</title>

<!-- Tailwind 3.x CDN -->
<script src="https://cdn.tailwindcss.com"></script>

<script src="https://cdnjs.cloudflare.com/ajax/libs/three.js/r134/three.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/vanta/0.5.24/vanta.birds.min.js"></script>



<!-- 사용자 정의 색상 -->
<script>
	tailwind.config = {
		theme : {
			extend : {
				colors : {
					peach : '#FFEBD3',
					cream : '#FAF7F5',
					button : '#FFD8A1'
				}
			}
		}
	}

	function toggleLogin() {
		const form = document.getElementById("loginForm");
		form.classList.toggle("hidden");
	}

	function toggleJoin() {
		const form = document.getElementById("joinForm");

		form.classList.toggle("hidden");
	}
</script>

<style>
html, body {
	margin: 0;
	padding: 0;
	height: 100%;
}

body, main, header {
    background-color: transparent !important;
}

#vanta-bg {
    position: fixed;
    z-index: 0;
    top: 0;
    left: 0;
    width: 100vw;
    height: 100vh;
}

</style>


</head>

<!-- 🟠 전체 화면 배경 + 중앙 정렬을 위한 기본 설정 -->
<body class="bg-cream min-h-screen flex flex-col m-0 p-0">

	<div id="vanta-bg" style="position: fixed; top: 0; left: 0; width: 100%; height: 100%; z-index: -1;"></div>

	<%@ include file="/WEB-INF/jsp/feelimals/common/header.jspf"%>
	<%@ include file="/WEB-INF/jsp/feelimals/common/settings.jspf"%>

	<!-- 로그인 팝업창 -->
	<c:if test="${!rq.isLogined()}">
		<%@ include file="/WEB-INF/jsp/feelimals/member/popup-login.jspf"%>
		<%@ include file="/WEB-INF/jsp/feelimals/member/popup-join.jspf"%>
	</c:if>



	<!-- 중앙... 메인 -->
	<main class="flex-grow flex items-center justify-center text-center">
		<div class="flex flex-col items-center space-y-4">
			<!-- 캐릭터 이미지 -->
			<div class="w-28 h-28 bg-gray-200 rounded-full bg-center bg-no-repeat bg-contain"
				style="background-image: url('/resource/images/rabbit_black.png');"></div>
			<c:if test="${!rq.isLogined() }">
				<!-- 환영 메시지 -->
				<div class="text-lg font-medium text-gray-800">나와 대화해보지 않을래?</div>

				<!-- 로그인 폼 버튼 -->
				<button onclick="toggleLogin()"
					class="px-6 py-2 rounded-full bg-button hover:bg-[#ffc987] transition font-medium shadow-sm">로그인</button>

				<!-- 회원가입 링크 -->
				<div class="text-xs text-gray-600 mt-2">
					계정이 없는 거야?
					<a href="#" onclick="toggleJoin()" class="text-orange-500 hover:underline">회원가입</a>
				</div>
			</c:if>
			<c:if test="${rq.isLogined() }">
				<!-- 환영 메시지 -->
				<div class="text-lg font-medium text-gray-800">${rq.loginedMember.nickname},어서와!</div>

				<!-- 대화 시작 버튼 -->
				<form action="../chat">
					<button class="px-6 py-2 rounded-full bg-button hover:bg-[#ffc987] transition font-medium shadow-sm">대화 시작
					</button>
				</form>
				<li>
					<a onclick="if(confirm('로그아웃 할래?') == false) return false;" class="hover:text-red-600" href="../member/doLogout">LOGOUT</a>
				</li>
			</c:if>

		</div>
	</main>
	<!-- 맨 아래, </body> 직전에 넣기 -->
<script>
  $(function () {
    VANTA.BIRDS({
      el: "#vanta-bg",
      mouseControls: true,
      touchControls: true,
      gyroControls: false,
      minHeight: 200.00,
      minWidth: 200.00,
      scale: 1.00,
      scaleMobile: 1.00,
      backgroundColor: 0xfff0d4,
      color1: 0x88461e,
      color2: 0x814803,
      colorMode: "lerp",
      wingSpan: 25.00,
      speedLimit: 4.00,
      separation: 19.00,
      quantity: 4.00
    });
  });
</script>
	
</body>
</html>
