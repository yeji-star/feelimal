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
  `userImage` VARCHAR(255),
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
  `userId` INT(10) UNSIGNED NOT NULL,
  `body` TEXT NOT NULL,
  `isChat` BOOLEAN DEFAULT FALSE,
  `emoTagId` INT(10) UNSIGNED NOT NULL,
  `regDate` DATETIME NOT NULL,
  `updateDate` DATETIME NOT NULL,
  `delStatus` TINYINT(1) NOT NULL DEFAULT 0,
  `delDate` DATETIME
);

CREATE TABLE `diartEmo` (
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

CREATE TABLE `emotionFeedback` (
  `id` INT(10) UNSIGNED PRIMARY KEY NOT NULL AUTO_INCREMENT,
  `emoTagId` INT(10) UNSIGNED NOT NULL,
  `message` TEXT NOT NULL,
  `emoType` CHAR(20) NOT NULL,
  `regDate` DATETIME NOT NULL
);

CREATE TABLE `aiReply` (
  `id` INT(10) UNSIGNED PRIMARY KEY NOT NULL AUTO_INCREMENT,
  `chatdiaryId` INT(10) UNSIGNED NOT NULL,
  `reply` TEXT NOT NULL,
  `regDate` DATETIME NOT NULL,
  `updateDate` DATETIME NOT NULL,
  `model` CHAR(50) NOT NULL,
  `delStatus` TINYINT(1) NOT NULL,
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
  `userId` INT(10) UNSIGNED NOT NULL,
  `charaId` INT(10) UNSIGNED NOT NULL,
  `alert` BOOLEAN NOT NULL DEFAULT TRUE,
  `updateDate` DATETIME NOT NULL
);

ALTER TABLE `charaEmo` ADD FOREIGN KEY (`charaId`) REFERENCES `chara` (`id`);

ALTER TABLE `emotionFeedback` ADD FOREIGN KEY (`emoTagId`) REFERENCES `emoTag` (`id`);

ALTER TABLE `settings` ADD FOREIGN KEY (`userId`) REFERENCES `member` (`id`);

ALTER TABLE `chatDiary` ADD FOREIGN KEY (`userId`) REFERENCES `member` (`id`);

ALTER TABLE `diartEmo` ADD FOREIGN KEY (`chatdiaryId`) REFERENCES `chatDiary` (`id`);

ALTER TABLE `diartEmo` ADD FOREIGN KEY (`emoTagId`) REFERENCES `emoTag` (`id`);

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
	
SELECT *
FROM `member`;

DESC `member`;

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



