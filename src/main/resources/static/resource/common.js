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