DROP DATABASE IF EXISTS javaee_library;
CREATE DATABASE javaee_library;

DROP TABLE IF EXISTS javaee_library.user;
CREATE TABLE javaee_library.user (
  id       INT                          AUTO_INCREMENT PRIMARY KEY
  COMMENT 'ID PK',
  username VARCHAR(191) UNIQUE NOT NULL
  COMMENT '用户名',
  password VARCHAR(255)        NOT NULL
  COMMENT '密码',
  role     VARCHAR(255)        NOT NULL DEFAULT '用户'
  COMMENT '角色：用户；管理员'
)
  COMMENT '用户表';


DROP TABLE IF EXISTS javaee_library.book;
CREATE TABLE javaee_library.book (
  id     INT AUTO_INCREMENT PRIMARY KEY
  COMMENT 'ID PK',
  title  VARCHAR(255)  NOT NULL
  COMMENT '书名',
  author VARCHAR(255)  NOT NULL
  COMMENT '作者',
  pub    VARCHAR(255)  NOT NULL
  COMMENT '出版社',
  time   DATE          NOT NULL
  COMMENT '出版时间',
  price  DECIMAL(8, 2) NOT NULL
  COMMENT '定价',
  amount INT           NOT NULL
  COMMENT '数量'
)
  COMMENT '图书表';


DROP TABLE IF EXISTS javaee_library.user_book;
CREATE TABLE javaee_library.user_book (
  id         INT      AUTO_INCREMENT PRIMARY KEY
  COMMENT 'PK',
  userId     INT COMMENT 'FK',
  bookId     INT COMMENT 'FK',
  borrowTime DATETIME DEFAULT now()
  COMMENT '借书时间',
  returnTime DATETIME COMMENT '还书时间'
)
  COMMENT '用户-图书表';

ALTER TABLE javaee_library.user_book
  ADD CONSTRAINT
  user_book_fk_userId
FOREIGN KEY (userId)
REFERENCES javaee_library.user (id);

ALTER TABLE javaee_library.user_book
  ADD CONSTRAINT
  user_book_fk_bookId
FOREIGN KEY (bookId)
REFERENCES javaee_library.book (id);

INSERT INTO javaee_library.user (username, password, role) VALUES ('admin1', '123', '管理员');

SELECT *
FROM javaee_library.user;

SELECT *
FROM javaee_library.book;

SELECT *
FROM javaee_library.user_book;

START TRANSACTION;
INSERT INTO javaee_library.user VALUE (NULL, 'u1', 'p', 'r');
INSERT INTO javaee_library.user VALUE (NULL, 'u2', 'p', 'r');
ROLLBACK;
COMMIT;

SELECT
  b.title,
  ub.borrowTime,
  ub.returnTime
FROM javaee_library.book b INNER JOIN javaee_library.user_book ub
    ON b.id = ub.bookId
WHERE ub.userId = 2;

SELECT
  u.username,
  b.title,
  ub.borrowTime,
  ub.returnTime
FROM javaee_library.book b INNER JOIN javaee_library.user u
  INNER JOIN javaee_library.user_book ub
    ON b.id = ub.bookId AND u.id = ub.userId