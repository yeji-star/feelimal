<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang='ko'>
<head>
<meta charset='utf-8' />
<title>캘린더</title>
<script src='https://cdn.jsdelivr.net/npm/fullcalendar@6.1.17/index.global.min.js'></script>
<script>
		document.addEventListener('DOMContentLoaded', function () {
			var calendarEl = document.getElementById('calendar');

			var calendar = new FullCalendar.Calendar(calendarEl, {
				headerToolbar: {
					left: 'prev',
					center: 'title',
					right: 'next'
				},
				initialView: 'dayGridMonth',
				timeZone: 'Asia/Seoul',
				locale: 'ko',
				height: 'auto',
				contentHeight: 'auto',
				eventColor: '#FFD8B1',
				dayMaxEvents: true, // ✅ 잘못된 위치 수정

				// ✅ 서버에서 ResultData 구조로 받아서 events 배열만 꺼내기
				events: function (fetchInfo, successCallback, failureCallback) {
					fetch('/feelimals/calendar/events')
						.then(response => response.json())
						.then(data => {
							if (data.resultCode && data.resultCode.startsWith('S-')) {
								successCallback(data.data1);
							} else {
								alert('이벤트 불러오기에 실패했습니다: ' + data.msg);
							}
						})
						.catch(error => {
							alert('서버 요청 오류 발생');
							failureCallback(error);
						});
				},

				// ✅ 더보기 클릭 시 경고
				moreLinkClick: function (info) {
					alert('더보기 날짜: ' + info.dateStr);
					return false;
				}
			});

			calendar.render();
		});
	</script>
</head>
<body class="bg-[#FAF7F5] min-h-screen">
	<!-- 메뉴바 -->
	<%@ include file="/WEB-INF/jsp/feelimals/common/head.jspf"%>
	<%@ include file="/WEB-INF/jsp/feelimals/common/header.jspf"%>

	<br>
	<div id='calendar' class="max-w-4xl mx-auto p-4"></div>
</body>
</html>
