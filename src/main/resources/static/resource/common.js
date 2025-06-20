$('select[data-value]').each(function(index, el) {
	const $el = $(el);

	defaultValue = $el.attr('data-value').trim();

	if (defaultValue.length > 0) {
		$el.val(defaultValue);
	}
});


function openSetting() {
	document.getElementById("settingOverlay").classList.remove("hidden");

	const panel = document.getElementById("settingPanel");
	panel.classList.remove("translate-x-full", "opacity-0", "pointer-events-none");
}

function closeSetting() {
	document.getElementById("settingOverlay").classList.add("hidden");

	const panel = document.getElementById("settingPanel");
	panel.classList.add("translate-x-full", "opacity-0", "pointer-events-none");
}

function toggleEditMenu() {
	const menu = document.getElementById("editMenu");
	menu.classList.toggle("hidden");
}

function DiaryModify__submit(form) {
	const body = form.body.value.trim();

	if (body.length < 5) {
		alert("내용을 5자 이상 입력해줘.");
		form.body.focus();
		return false;
	}

	return true;
}

document.getElementById('userInput').addEventListener('keydown', function(e) {
	if (e.key === 'Enter') {
		e.preventDefault();
		sendMessage();
	}
});

const sessionId = window.sessionId || "";

function sendMessage() {
	// 입력창에서 텍스트 읽기
	const input = document.getElementById('userInput');
	const message = input.value.trim();

	//빈 값이면 전송 안하기
	if (message === "") return;

	// 중복 전송 방지
	input.disabled = true;

	// sessionId 값이 비어있으면 첫 대화, 있으면 이어쓰기
	let url = '/feelimals/chat';
	let bodyData = '';

	if (sessionId && sessionId !== "null" && sessionId !== "") {
		url += '/continue';
		bodyData = `sessionId=${encodeURIComponent(sessionId)}&newBody=${encodeURIComponent(message)}`;
	} else {
		bodyData = `body=${encodeURIComponent(message)}`;
	}

	// 서버 요청 (ajax)
	fetch(url, {
		method: 'POST',
		headers: { 'Content-Type': 'application/x-www-form-urlencoded' },
		body: bodyData
	})
		// 서버 응답
		.then(res => res.json())
		.then(res => {
			console.log('서버 응답:', res); // 실제로 오는 구조 확인
			// 실제 데이터는 res.data1에 들어있음!
			let messages = res.data1;
			if (!Array.isArray(messages) || messages.length === 0) {
				alert('서버 응답 오류');
				input.disabled = false;
				return;
			}
			renderMessages(messages);
			input.value = '';
			input.disabled = false;
			input.focus();
		})
		.catch(err => {
			alert('오류 발생: ' + err);
			input.disabled = false;
		});
}

function renderMessages(messages) {
	const chatBox = document.getElementById("chatBox");
	chatBox.innerHTML = '<div class="msg him">오늘 어떻게 보냈어?</div>';
	messages.forEach(msg => {
		if (msg.thisChat) {
			const userMsg = document.createElement("div");
			userMsg.className = "msg you";
			userMsg.textContent = msg.body;
			chatBox.appendChild(userMsg);
		}
		if (msg.aiReplyBody) {
			const aiMsg = document.createElement("div");
			aiMsg.className = "msg him";
			aiMsg.textContent = msg.aiReply;
			chatBox.appendChild(aiMsg);
		}
	});
	chatBox.scrollTop = chatBox.scrollHeight;
}