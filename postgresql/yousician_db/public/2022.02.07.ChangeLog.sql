-- liquibase formatted sql

-- comment: Please do not change the value of author:changsetid
-- changeset BalajiPothula:2022-02-07T14:50:00Z
CREATE TABLE IF NOT EXISTS yousician_db.public."Song"(
  "songId"     BIGSERIAL                   PRIMARY KEY,
  "artist"     VARCHAR                     NOT NULL,
  "title"      VARCHAR                     NOT NULL,
  "difficulty" REAL                        NOT NULL,
  "level"      SMALLINT                    NOT NULL CHECK(0 < "level"  AND "level" < 26),
  "released"   TIMESTAMP WITHOUT TIME ZONE NOT NULL,
  "rating"     SMALLINT  ARRAY             NOT NULL CHECK(0 < "rating" AND "rating" < 6)
);
