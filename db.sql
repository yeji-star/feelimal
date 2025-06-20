# dbdiagram.io 버전

DROP DATABASE IF EXISTS `feelimals`;
CREATE DATABASE `feelimals`;
USE `feelimals`;

CREATE TABLE `member` (
  `id` INT(10) UNSIGNED PRIMARY KEY NOT NULL AUTO_INCREMENT,
  `regDate` DATETIME NOT NULL,
  `updateDate` DATETIME NOT NULL,
  `loginId` VARCHAR(100) NOT NULL,
  `loginPw` VARCHAR(100) NOT NULL,
  `nickname` VARCHAR(50) NOT NULL,
  `email` VARCHAR(50) NOT NULL,
  `memberImage` VARCHAR(255),
  `delStatus` TINYINT(1) NOT NULL DEFAULT 0,
  `delDate` DATETIME
);


CREATE TABLE `chara` (
  `id` INT(10) UNSIGNED PRIMARY KEY NOT NULL AUTO_INCREMENT,
  `regDate` DATETIME NOT NULL,
  `updateDate` DATETIME NOT NULL,
  `name` VARCHAR(50) NOT NULL,
  `content` CHAR(50) NOT NULL,
  `image` CHAR(100)
);

CREATE TABLE `charaEmo` (
  `id` INT(10) UNSIGNED PRIMARY KEY NOT NULL AUTO_INCREMENT,
  `charaId` INT(10) UNSIGNED NOT NULL,
  `emoId` INT(10) UNSIGNED NOT NULL,
  `emoType` VARCHAR(50) NOT NULL,
  `image` VARCHAR(100) NOT NULL
);

CREATE TABLE `emoTag` (
  `id` INT(10) UNSIGNED PRIMARY KEY NOT NULL AUTO_INCREMENT,
  `label` CHAR(20) UNIQUE NOT NULL,
  `icon` CHAR(20) NOT NULL,
  `color` CHAR(10) NOT NULL
);

CREATE TABLE `chatDiary` (
  `id` INT(10) UNSIGNED PRIMARY KEY NOT NULL AUTO_INCREMENT,
  `memberId` INT(10) UNSIGNED NOT NULL,
  `sessionId` INT(10) UNSIGNED NULL,
  `body` TEXT NOT NULL,
  `isUser` BOOLEAN DEFAULT TRUE COMMENT 'true면 사용자, false면 AI',
  `thisChat` BOOLEAN DEFAULT FALSE COMMENT 'true면 채팅, false면 일기',
  `emoTagId` INT(10) UNSIGNED NOT NULL,
  `regDate` DATETIME NOT NULL,
  `updateDate` DATETIME NOT NULL,
  `delStatus` TINYINT(1) NOT NULL DEFAULT 0,
  `delDate` DATETIME
);

CREATE TABLE `chatSession` (
`id` INT(10) UNSIGNED PRIMARY KEY NOT NULL AUTO_INCREMENT,
`memberId` INT(10) UNSIGNED NOT NULL,
`title` CHAR(100) DEFAULT NULL,
regDate DATETIME NOT NULL,
updateDate DATETIME NOT NULL,
delStatus TINYINT(1) NOT NULL DEFAULT 0 COMMENT '0이면 삭제 안됨, 1이면 삭제됨',
delDate DATETIME
);

CREATE TABLE `diaryEmo` (
  `id` INT(10) UNSIGNED PRIMARY KEY NOT NULL AUTO_INCREMENT,
  `chatdiaryId` INT(10) UNSIGNED NOT NULL,
  `emoTagId` INT(10) UNSIGNED NOT NULL,
  `score` FLOAT NOT NULL,
  `source` CHAR(50) NOT NULL,
  `regDate` DATETIME NOT NULL,
  `updateDate` DATETIME NOT NULL,
  `delStatus` TINYINT(1) NOT NULL,
  `delDate` DATETIME
);

# 프롬프트 메시지 (AI가 참고해야할 프롬프트)
CREATE TABLE `emotionFeedback` (
  `id` INT(10) UNSIGNED PRIMARY KEY NOT NULL AUTO_INCREMENT,
  `emoTagId` INT(10) UNSIGNED NOT NULL,
  `prompt` TEXT NOT NULL,
  # `emoType` char(20) NOT NULL, <- 나중에 감정을 더 세분화할 때 쓰기
  `regDate` DATETIME NOT NULL
);

CREATE TABLE `aiReply` (
  `id` INT(10) UNSIGNED PRIMARY KEY NOT NULL AUTO_INCREMENT,
  `chatDiaryId` INT(10) UNSIGNED NOT NULL,
  `reply` TEXT NOT NULL,
  `regDate` DATETIME NOT NULL,
  `updateDate` DATETIME NOT NULL,
  `model` CHAR(50) NOT NULL,
  `delStatus` TINYINT(1) NOT NULL DEFAULT 0,
  `delDate` DATETIME
);

CREATE TABLE `calendar` (
  `date` DATE PRIMARY KEY NOT NULL,
  `year` INT(10) NOT NULL,
  `month` INT(10) NOT NULL,
  `day` INT(10) NOT NULL,
  `dayName` CHAR(10) NOT NULL,
  `isWeekend` BOOLEAN,
  `isHoliday` BOOLEAN DEFAULT FALSE
);


CREATE TABLE `settings` (
  `id` INT(10) UNSIGNED PRIMARY KEY NOT NULL AUTO_INCREMENT,
  `memberId` INT(10) UNSIGNED NOT NULL,
  `charaId` INT(10) UNSIGNED NOT NULL,
  `alert` BOOLEAN NOT NULL DEFAULT TRUE,
  `updateDate` DATETIME NOT NULL
);

ALTER TABLE `charaEmo` ADD FOREIGN KEY (`charaId`) REFERENCES `chara` (`id`);

ALTER TABLE `emotionFeedback` ADD FOREIGN KEY (`emoTagId`) REFERENCES `emoTag` (`id`);

ALTER TABLE `settings` ADD FOREIGN KEY (`memberId`) REFERENCES `member` (`id`);

ALTER TABLE `chatDiary` ADD FOREIGN KEY (`memberId`) REFERENCES `member` (`id`);

ALTER TABLE `chatDiary` ADD FOREIGN KEY (`sessionId`) REFERENCES `chatSession` (`id`);

ALTER TABLE `diaryEmo` ADD FOREIGN KEY (`chatdiaryId`) REFERENCES `chatDiary` (`id`);

ALTER TABLE `diaryEmo` ADD FOREIGN KEY (`emoTagId`) REFERENCES `emoTag` (`id`);

ALTER TABLE `charaEmo` ADD FOREIGN KEY (`emoId`) REFERENCES `emoTag` (`id`);

ALTER TABLE `aiReply` ADD FOREIGN KEY (`chatdiaryId`) REFERENCES `chatDiary` (`id`);

ALTER TABLE `chatDiary` ADD FOREIGN KEY (`emoTagId`) REFERENCES `emoTag` (`id`);

ALTER TABLE `settings` ADD FOREIGN KEY (`charaId`) REFERENCES `chara` (`id`);


SHOW TABLES;

# 테스트 데이터 (유저)

INSERT INTO `member`
SET regDate = NOW(),
	updateDate = NOW(),
	loginId = 'test1',
	loginPw = 'test1',
	nickname = 'test1',
	email = 'test1@gmail.com';
	
INSERT INTO `member`
SET regDate = NOW(),
	updateDate = NOW(),
	loginId = 'test2',
	loginPw = 'test2',
	nickname = 'test2',
	email = 'test2@gmail.com';

# 테스트 데이터 (감정 태그)

INSERT INTO emoTag
SET
  label = '기쁨',
  icon = '😊',
  color = '#FFE082';
   
INSERT INTO emoTag
SET
  label = '슬픔',
  icon = '😔',
  color = '#90CAF9'; 

INSERT INTO emoTag
SET
  label = '분노',
  icon = '😠',
  color = '#FF8A65'; 
  
INSERT INTO emoTag
SET
  label = '불안',
  icon = '😰',
  color = '#B39DDB'; 
  
  INSERT INTO emoTag
SET
  label = '분류안함',
  icon = '❓',
  color = '#E0E0E0'; 
  
SELECT * FROM emoTag;  
  
# 테스트 데이터 (일기)

INSERT INTO chatDiary
SET
  memberId = 1,
  `body` = '오늘은 오랜만에 햇살이 따뜻했어.',
  thisChat = FALSE,
  emoTagId = 1,
  regDate = NOW(),
  updateDate = NOW(),
  delStatus = 0;

INSERT INTO chatDiary
SET
  memberId = 1,
  `body` = '조금 힘들었지만 잘 견뎠어.',
  thisChat = FALSE,
  emoTagId = 2,
  regDate = NOW(),
  updateDate = NOW(),
  delStatus = 0;
  
# 테스트 데이터 (세션)

INSERT INTO chatSession
SET
	memberId = 1,
	title = '대화1',
	regDate = NOW(),
	updateDate = NOW();
  
SELECT LAST_INSERT_ID();  
  
# 테스트 데이터 (대화)

INSERT INTO chatDiary
SET 
memberId = 1,
sessionId = 1,
`body` = '오늘 좀 힘들었어. 위로해줘.',
thisChat = TRUE,
emoTagId = 2,
regDate = NOW(),
updateDate = NOW(),
delStatus = 0;

# 테스트 데이터 (ai응답)

INSERT INTO aiReply
SET
chatDiaryId = 1,
reply = '힘들었구나.',
regDate = NOW(),
updateDate = NOW(),
model = 'gpt-3.5-turbo',
delStatus = 0;

SELECT * FROM aiReply WHERE chatdiaryId IN (SELECT id FROM chatDiary WHERE sessionId = 3);


SELECT *
FROM `member`;

SELECT * FROM emoTag;
SELECT * FROM chatDiary;

DESC `member`;

SELECT cd.id, cd.body, cd.sessionId, cd.thisChat, ar.reply
FROM chatDiary cd
LEFT JOIN aiReply ar ON ar.chatDiaryId = cd.id
WHERE cd.sessionId = 1;

SELECT * FROM chatDiary
INNER JOIN chatSession
ON chatDiary.sessionId = chatSession.id
INNER JOIN aiReply
ON aiReply.chatDiaryId = chatDiary.id;

#########

# erdcloud 버전

DROP DATABASE IF EXISTS `feelimals`;
CREATE DATABASE `feelimals`;
USE `feelimals`;

CREATE TABLE `user` (
	`id`	INT	NOT NULL,
	`regDate`	DATETIME	NOT NULL,
	`userId`	CHAR	NOT NULL,
	`userPw`	CHAR	NOT NULL,
	`nickname`	CHAR	NOT NULL,
	`userImage`	CHAR	NOT NULL
);

CREATE TABLE `chat` (
	`id`	INT	NOT NULL,
	`userId`	INT	NOT NULL,
	`regDate`	DATETIME	NOT NULL,
	`updateDate`	DATETIME	NOT NULL,
	`message`	CHAR	NOT NULL,
	`reply`	CHAR	NOT NULL,
	`feelTag`	CHAR	NOT NULL
);

CREATE TABLE `diary` (
	`id`	INT	NOT NULL,
	`userId`	INT	NOT NULL,
	`regDate`	DATETIME	NOT NULL,
	`updateDate`	DATETIME	NOT NULL,
	`body`	CHAR	NOT NULL,
	`feelTag`	CHAR	NOT NULL
);

CREATE TABLE `charaEmotion` (
	`id`	INT	NOT NULL,
	`charaId`	INT	NOT NULL,
	`EmoType`	CHAR	NOT NULL,
	`image`	CHAR	NOT NULL,
	`content`	CHAR	NULL
);

CREATE TABLE `setting` (
	`id`	INT	NOT NULL,
	`alert`	BOOLEAN	NOT NULL	DEFAULT TRUE,
	`userId`	INT	NOT NULL,
	`charaId`	INT	NOT NULL
);

CREATE TABLE `chara` (
	`id`	INT	NOT NULL,
	`regDate`	DATETIME	NOT NULL,
	`name`	CHAR	NOT NULL,
	`content`	CHAR	NULL
);

ALTER TABLE `user` ADD CONSTRAINT `PK_USER` PRIMARY KEY (
	`id`
);

ALTER TABLE `chat` ADD CONSTRAINT `PK_CHAT` PRIMARY KEY (
	`id`
);

ALTER TABLE `diary` ADD CONSTRAINT `PK_DIARY` PRIMARY KEY (
	`id`
);

ALTER TABLE `charaEmotion` ADD CONSTRAINT `PK_CHARAEMOTION` PRIMARY KEY (
	`id`
);

ALTER TABLE `setting` ADD CONSTRAINT `PK_SETTING` PRIMARY KEY (
	`id`
);

ALTER TABLE `chara` ADD CONSTRAINT `PK_CHARA` PRIMARY KEY (
	`id`
);

SELECT *
FROM feelimals;


#######################

# https://aquerytool.com/ 버전

DROP DATABASE IF EXISTS `feelimals`;
CREATE DATABASE `feelimals`;
USE `feelimals`;

-- 테이블 순서는 관계를 고려하여 한 번에 실행해도 에러가 발생하지 않게 정렬되었습니다.

-- chara Table Create SQL
-- 테이블 생성 SQL - chara
CREATE TABLE chara
(
    `id`       INT UNSIGNED    NOT NULL        AUTO_INCREMENT COMMENT '캐릭터 아이디', 
    `regDate`  DATETIME        NOT NULL        COMMENT '등록일?', 
    `name`     VARCHAR(50)     NOT NULL        COMMENT '동물 이름', 
    `content`  VARCHAR(50)     NOT NULL        COMMENT '동물 설명', 
     PRIMARY KEY (id)
);

-- 테이블 Comment 설정 SQL - chara
ALTER TABLE chara COMMENT '동물 캐릭터';


-- user Table Create SQL
-- 테이블 생성 SQL - user
CREATE TABLE USER
(
    `id`        INT UNSIGNED    NOT NULL        AUTO_INCREMENT COMMENT '유저 아이디', 
    `regDate`   DATETIME        NOT NULL        COMMENT '유저 가입일', 
    `userName`  VARCHAR(50)     NOT NULL        COMMENT '유저 닉네임', 
    `userPw`    VARCHAR(50)     NOT NULL        COMMENT '유저 비밀번호', 
     PRIMARY KEY (id)
);

-- 테이블 Comment 설정 SQL - user
ALTER TABLE USER COMMENT '사용자';


-- chat Table Create SQL
-- 테이블 생성 SQL - chat
CREATE TABLE chat
(
    `id`          INT UNSIGNED    NOT NULL        AUTO_INCREMENT COMMENT '대화 아이디', 
    `userId`      INT UNSIGNED    NOT NULL        COMMENT '유저 아이디', 
    `regDate`     DATETIME        NOT NULL        COMMENT '작성 시간', 
    `updateDate`  DATETIME        NOT NULL        COMMENT '수정 시간', 
    `message`     VARCHAR(50)     NOT NULL        COMMENT '사용자 메세지', 
    `reply`       VARCHAR(50)     NOT NULL        COMMENT '캐릭터 메세지', 
    `feel`        VARCHAR(50)     NOT NULL        COMMENT '감정 태그', 
     PRIMARY KEY (id)
);

-- 테이블 Comment 설정 SQL - chat
ALTER TABLE chat COMMENT '대화';

-- Foreign Key 설정 SQL - chat(userId) -> user(id)
ALTER TABLE chat
    ADD CONSTRAINT FK_chat_userId_user_id FOREIGN KEY (userId)
        REFERENCES USER (id) ON DELETE CASCADE ON UPDATE RESTRICT;

-- Foreign Key 삭제 SQL - chat(userId)
-- ALTER TABLE chat
-- DROP FOREIGN KEY FK_chat_userId_user_id;


-- diary Table Create SQL
-- 테이블 생성 SQL - diary
CREATE TABLE diary
(
    `id`          INT UNSIGNED    NOT NULL        AUTO_INCREMENT COMMENT '일기 아이디', 
    `userId`      INT UNSIGNED    NOT NULL        COMMENT '유저 아이디', 
    `regDate`     DATETIME        NOT NULL        COMMENT '작성 시간', 
    `updateDate`  DATETIME        NOT NULL        COMMENT '수정 시간', 
    `feel`        VARCHAR(50)     NOT NULL        COMMENT '감정 태그', 
    `body`        VARCHAR(50)     NOT NULL        COMMENT '일기 내용', 
     PRIMARY KEY (id)
);

-- 테이블 Comment 설정 SQL - diary
ALTER TABLE diary COMMENT '일기';

-- Foreign Key 설정 SQL - diary(userId) -> user(id)
ALTER TABLE diary
    ADD CONSTRAINT FK_diary_userId_user_id FOREIGN KEY (userId)
        REFERENCES USER (id) ON DELETE CASCADE ON UPDATE RESTRICT;

-- Foreign Key 삭제 SQL - diary(userId)
-- ALTER TABLE diary
-- DROP FOREIGN KEY FK_diary_userId_user_id;


-- charaEmotion Table Create SQL
-- 테이블 생성 SQL - charaEmotion
CREATE TABLE charaEmotion
(
    `id`        INT UNSIGNED    NOT NULL        AUTO_INCREMENT COMMENT '감정 아이디', 
    `charaId`   INT UNSIGNED    NOT NULL        COMMENT '캐릭터 아이디', 
    `feelType`  VARCHAR(50)     NOT NULL        COMMENT '감정 종류', 
    `image`     VARCHAR(50)     NOT NULL        COMMENT '이미지', 
    `content`   VARCHAR(50)     NOT NULL        COMMENT '설명', 
     PRIMARY KEY (id)
);

-- 테이블 Comment 설정 SQL - charaEmotion
ALTER TABLE charaEmotion COMMENT '캐릭터 감정';

-- Foreign Key 설정 SQL - charaEmotion(charaId) -> chara(id)
ALTER TABLE charaEmotion
    ADD CONSTRAINT FK_charaEmotion_charaId_chara_id FOREIGN KEY (charaId)
        REFERENCES chara (id) ON DELETE RESTRICT ON UPDATE RESTRICT;

-- Foreign Key 삭제 SQL - charaEmotion(charaId)
-- ALTER TABLE charaEmotion
-- DROP FOREIGN KEY FK_charaEmotion_charaId_chara_id;



