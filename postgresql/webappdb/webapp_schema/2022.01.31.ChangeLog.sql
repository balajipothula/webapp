-- liquibase formatted sql

-- comment: Please do not change the value of author:changsetid
-- changeset BalajiPothula:2022-01-31T14:38:00Z
CREATE TABLE IF NOT EXISTS webapp_db.webapp_schema."Login"(
  "id"       BIGSERIAL PRIMARY KEY,
  "username" VARCHAR   NOT NULL,
  "password" VARCHAR   NOT NULL
);