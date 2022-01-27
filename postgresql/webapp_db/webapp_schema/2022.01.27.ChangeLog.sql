-- liquibase formatted sql

-- comment: Please do not change the value of author:changsetid
-- changeset BalajiPothula:2022-01-27T09:50:00Z
CREATE TABLE IF NOT EXISTS webapp_db.webapp_schema."Emp"(
  "id"     BIGSERIAL PRIMARY KEY,
  "no"     INTEGER NOT NULL,
  "name"   VARCHAR NOT NULL,
  "salary" REAL    NOT NULL
);