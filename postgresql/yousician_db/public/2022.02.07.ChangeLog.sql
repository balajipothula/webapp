-- liquibase formatted sql

-- comment: Please do not change the value of author:changsetid
-- changeset BalajiPothula:2022-02-07T14:50:00Z
-- create Song table.
CREATE TABLE IF NOT EXISTS yousician_db.public."Song"(
  "songId"     BIGSERIAL PRIMARY KEY,
  "artist"     VARCHAR   NOT NULL,
  "title"      VARCHAR   NOT NULL,
  "difficulty" FLOAT(2)  NOT NULL,
  "level"      SMALLINT  NOT NULL CHECK(0 < "level"  AND "level" < 100),
  "released"   VARCHAR   NOT NULL
);

-- comment: Please do not change the value of author:changsetid
-- changeset BalajiPothula:2022-02-07T17:15:00Z
-- create Rating table.
CREATE TABLE IF NOT EXISTS yousician_db.public."Rating"(
  "songId" BIGINT   NOT NULL,
  "rating" SMALLINT NOT NULL CHECK(0 < "rating" AND "rating" < 6)
);

