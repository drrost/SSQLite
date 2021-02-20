DROP TABLE IF EXISTS user;

CREATE TABLE user(
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "first_name" TEXT,
  "last_name" TEXT,
  "age" INTEGER
);

INSERT INTO user (first_name, last_name, age) VALUES ('John', 'Smith', 32);
INSERT INTO user (first_name, last_name, age) VALUES ('Mary', 'Lain', 15);
INSERT INTO user (first_name, last_name, age) VALUES ('Sara', 'OConor', 64);
INSERT INTO user (first_name, last_name, age) VALUES ('Tom', 'Cruise', 28);
INSERT INTO user (first_name, last_name, age) VALUES ('Brandon', 'Lee', 39);
INSERT INTO user (first_name, last_name, age) VALUES ('Adam', 'Smith', 47);
INSERT INTO user (first_name, last_name, age) VALUES ('Eve', 'Custo', 19);

DROP TABLE IF EXISTS test;
CREATE TABLE test (test_id INTEGER, name TEXT);