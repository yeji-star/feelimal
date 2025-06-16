<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang='ko'>
<head>
<%@ include file="/WEB-INF/jsp/feelimals/common/head.jspf"%>
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
				dayMaxEvents: true,
				
				events: function (fetchInfo, successCallback, failureCallback) {
					fetch('/feelimals/calendar/events')
						.then(response => response.json())
						.then(data => {
							successCallback(data.data1 || []);
						})
						.catch(error => {
							alert("이벤트 로딩 실패");
							failureCallback(error);
						});
				},

				eventClick: function(info) {
					if (info.event.url) {
						window.location.href = info.event.url;
					}
				} ,
				
				eventContent: function(arg) {
					const emoji = document.createElement('span');
					emoji.textContent = arg.event.extendedProps.emoji;

					const prefix = document.createElement('span');
					prefix.textContent = arg.event.extendedProps.type === "chat" ? " 대화: " : " 일기: ";
					prefix.style.fontWeight = 'bold';

					const text = document.createElement('span');
					text.textContent = arg.event.extendedProps.body;
					text.style.display = 'inline-block';
					text.style.overflow = 'hidden';
					text.style.textOverflow = 'ellipsis';
					text.style.whiteSpace = 'nowrap';
					text.style.maxWidth = '90px';

					const container = document.createElement('div');
					container.style.display = 'flex';
					container.style.alignItems = 'center';
					container.appendChild(emoji);
					container.appendChild(prefix);
					container.appendChild(text);

					// 전체 내용 툴팁
					container.title = arg.event.extendedProps.body;

					return { domNodes: [container] };
				}



			});

			calendar.render();
		});
	</script>
</head>
<body class="bg-[#FAF7F5] min-h-screen">
	
	<%@ include file="/WEB-INF/jsp/feelimals/common/header.jspf"%>

	<div id='calendar' class="max-w-4xl mx-auto p-4"></div>
</body>
</html>
