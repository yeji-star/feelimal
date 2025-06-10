<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<script>
	console.log("🚨 js.jsp 실행됨");

	let msg = '${msg}' || '';
	let historyBack = '${historyBack}' === 'true';
	let replaceUri = '${replaceUri}' || '/';

	console.log("msg =", msg);
	console.log("historyBack =", historyBack);
	console.log("replaceUri =", replaceUri);

	if (msg.trim().length > 0) {
		alert(msg);
	}

	if (historyBack) {
		history.back();
	} else {
		top.location.href = replaceUri;
	}
</script>
