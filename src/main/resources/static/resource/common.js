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



