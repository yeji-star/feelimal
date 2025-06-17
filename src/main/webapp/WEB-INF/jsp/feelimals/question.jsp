<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <title>Ask a Question</title>
</head>
<body>
    <form action="ask" method="get" target="_self">
        <label for="question">Your Question:</label>
        <input type="text" id="question" name="question">
        <button type="submit">Ask GPT!</button>
    </form>
</body>
</html>
